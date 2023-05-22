import 'package:ag_smart/View%20Model/bloc/Duration%20settings/duration_settings_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Duration%20settings/duration_settings_states.dart';
import 'package:ag_smart/View/Reusable/choose_days_widget.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/main_icons_row_widget.dart';
import 'package:ag_smart/View/Reusable/open_valve_period_text_field.dart';
import 'package:ag_smart/View/Reusable/set_settings_2rows_container.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Reusable/toasts.dart';
import 'bottom_nav_bar.dart';
import 'duration_settings.dart';

// ignore: must_be_immutable
class DurationSettingsByPeriodScreen extends StatelessWidget {
  final bool isEdit;
  final int irrigationType;
  DurationSettingsByPeriodScreen(
      {Key? key, required this.isEdit, required this.irrigationType})
      : super(key: key);
  TextEditingController numberOfHoursControl = TextEditingController();
  TextEditingController numberOfMinutesControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text[chosenLanguage]!['Line Settings']!),
      ),
      body: BlocProvider(
        create: (context) => DurationSettingsCubit()
          ..getCycle(
              hours: numberOfHoursControl, amount: numberOfMinutesControl),
        child: BlocConsumer<DurationSettingsCubit, DurationSettingsStates>(
          listener: (context, state) {
            if (state is DurationSettingsErrorState) {
              errorToast('Input error');
            } else if (state is DurationSettingsSendSuccessState) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BottomNavBarScreen(),
                  ),
                  (route) => false);
            } else if (state is DurationSettingsSendFailedState) {
              errorToast('An error has occurred');
            }
          },
          builder: (context, state) {
            DurationSettingsCubit myCubit = DurationSettingsCubit.get(context);
            return state is DurationSettingsLoadingState ||
                    myCubit.irrigationSettingsModel == null
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.85,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MainCard2(
                              function: () {
                                if (myCubit.noDayIsChosen == 7) {
                                  errorToast('Please choose the days of work');
                                } else if (numberOfHoursControl.text.isEmpty ||
                                    numberOfMinutesControl.text.isEmpty) {
                                  errorToast('Please fill both categories');
                                } else {
                                  if (irrigationType == 1) {
                                    myCubit.checkOpenValveTimeSeriesByCycle(
                                        hours: double.parse(
                                            numberOfHoursControl.text),
                                        interval: int.parse(
                                            numberOfHoursControl.text),
                                        duration: int.parse(
                                            numberOfMinutesControl.text),
                                        weekday: myCubit.toDecimal(),
                                        openValveTime: double.parse(
                                            numberOfMinutesControl.text));
                                  } else if (irrigationType == 2) {
                                    myCubit.checkOpenValveTimeParallelByCycle(
                                        hours: double.parse(
                                            numberOfHoursControl.text),
                                        interval: int.parse(
                                            numberOfHoursControl.text),
                                        duration: int.parse(
                                            numberOfMinutesControl.text),
                                        weekday: myCubit.toDecimal(),
                                        openValveTime: double.parse(
                                            numberOfMinutesControl.text));
                                  } else if (double.parse(
                                          numberOfHoursControl.text) >
                                      24) {
                                    errorToast(text[chosenLanguage]![
                                        'The cycle can\'t be more than 24 hours']!);
                                  }
                                }
                              },
                              buttonColor: greenButtonColor,
                              editButton: InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DurationSettingsScreen(
                                          isEdit: true,
                                          stationIrrigationType: irrigationType,
                                        ),
                                      ));
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          0.03),
                                  child: Text(
                                    'l',
                                    style: TextStyle(
                                        fontFamily: 'icons',
                                        fontSize: 25,
                                        color: iconColor),
                                  ),
                                ),
                              ),
                              mainWidget: Column(
                                children: [
                                  const ChooseDyasWidget(
                                    useFunction: true,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.025,
                                  ),
                                  SetSettings2RowsContainer(
                                      visible: false,
                                      function: () {},
                                      firstRowTitle:
                                          text[chosenLanguage]!['Each cycle']!,
                                      firstRowWidget: OpenValvePeriodTextField(
                                        control: numberOfHoursControl,
                                        hintText: '00',
                                        unit: text[chosenLanguage]!['Hours']!,
                                      ),
                                      secondRowTitle: text[chosenLanguage]![
                                          'Open valve time']!,
                                      secondRowWidget: OpenValvePeriodTextField(
                                        control: numberOfMinutesControl,
                                        hintText: '00',
                                        unit: text[chosenLanguage]!['Minutes']!,
                                      )),
                                ],
                              ),
                              rowWidget: MainIconsRowWidget(
                                icon1: 'm',
                                icon2: irrigationType == 1 ? 'r' : 't',
                                icon3: 'w',
                                icon4: 'x',
                              ),
                              cardtitle:
                                  text[chosenLanguage]!['Duration settings']!)
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
