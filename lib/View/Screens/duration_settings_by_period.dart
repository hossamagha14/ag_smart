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

import '../../View Model/bloc/Irrigation type/irrigation_type_cubit.dart';
import '../../View Model/bloc/Irrigation type/irrigation_type_states.dart';
import '../Reusable/error_toast.dart';
import 'bottom_nav_bar.dart';

// ignore: must_be_immutable
class DurationSettingsByPeriodScreen extends StatelessWidget {
  final bool isEdit;
  DurationSettingsByPeriodScreen({Key? key, required this.isEdit})
      : super(key: key);
  TextEditingController numberOfHoursControl = TextEditingController();
  TextEditingController numberOfMinutesControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text[chosenLanguage]!['Line Settings']!),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.85,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BlocConsumer<DurationSettingsCubit, DurationSettingsStates>(
                listener: (context, state) {
                  DurationSettingsCubit myCubit =
                      DurationSettingsCubit.get(context);
                  if (state is DurationSettingsMoveToNextPageState) {
                    myCubit.putIrrigationCycle(
                        valveId: 0,
                        interval: int.parse(numberOfHoursControl.text),
                        duration: int.parse(numberOfMinutesControl.text),
                        quantity: 0,
                        weekDays: 9);
                  } else if (state is DurationSettingsErrorState) {
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
                  DurationSettingsCubit myCubit =
                      DurationSettingsCubit.get(context);
                  return MainCard2(
                      function: () {
                        if (myCubit.noDayIsChosen == 7) {
                          errorToast('Please choose the days of work');
                        } else if (numberOfHoursControl.text.isEmpty ||
                            numberOfMinutesControl.text.isEmpty) {
                          errorToast('Please fill both categories');
                        } else {
                          myCubit.checkOpenValveTimeSeriesByCycle(
                              hours: double.parse(numberOfHoursControl.text),
                              openValveTime:
                                  double.parse(numberOfMinutesControl.text));
                        }
                      },
                      buttonColor: greenButtonColor,
                      mainWidget: Column(
                        children: [
                          const ChooseDyasWidget(
                            useFunction: true,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025,
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
                              secondRowTitle:
                                  text[chosenLanguage]!['Open valve time']!,
                              secondRowWidget: OpenValvePeriodTextField(
                                control: numberOfMinutesControl,
                                hintText: '00',
                                unit: text[chosenLanguage]!['Minutes']!,
                              )),
                        ],
                      ),
                      rowWidget: BlocConsumer<IrrigationTypeCubit,
                          IrrigationTypesStates>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          IrrigationTypeCubit irrigationCubit =
                              IrrigationTypeCubit.get(context);
                          return MainIconsRowWidget(
                            icon1: 'm',
                            icon2:
                                irrigationCubit.irrigationType == 1 ? 'r' : 't',
                            icon3: 'w',
                            icon4: 'x',
                          );
                        },
                      ),
                      cardtitle: text[chosenLanguage]!['Duration settings']!);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
