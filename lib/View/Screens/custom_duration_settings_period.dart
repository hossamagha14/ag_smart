import 'package:ag_smart/View%20Model/bloc/Custom%20Irrigation/custom_irrigation_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Custom%20Irrigation/custom_irrigation_states.dart';
import 'package:ag_smart/View%20Model/bloc/commom_states.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/custom_irrigation_choose_day.dart';
import 'package:ag_smart/View/Reusable/toasts.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/main_icons_row_widget.dart';
import 'package:ag_smart/View/Reusable/open_valve_period_text_field.dart';
import 'package:ag_smart/View/Reusable/set_settings_2rows_container.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../View Model/Repo/auth_bloc.dart';
import 'bottom_nav_bar.dart';
import 'custom_duration_settings.dart';

// ignore: must_be_immutable
class CustomDurationSettingsByPeriodScreen extends StatefulWidget {
  final int lineIndex;
  final int valveId;
  final int irrigationMethod2;
  final int stationId;
  CustomDurationSettingsByPeriodScreen(
      {Key? key,
      required this.lineIndex,
      required this.valveId,
      required this.stationId,
      required this.irrigationMethod2})
      : super(key: key);

  @override
  State<CustomDurationSettingsByPeriodScreen> createState() =>
      _CustomDurationSettingsByPeriodScreenState();
}

class _CustomDurationSettingsByPeriodScreenState
    extends State<CustomDurationSettingsByPeriodScreen> {
  TextEditingController hourControl = TextEditingController();
  TextEditingController minutesControl = TextEditingController();
  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => CustomIrrigationCubit(authBloc)
          ..getPeriods(
              stationId: widget.stationId,
              lineIndex: widget.lineIndex,
              valveId: widget.valveId,
              hours: hourControl,
              amount: minutesControl),
        child: BlocConsumer<CustomIrrigationCubit, CommonStates>(
          listener: (context, state) {
            if (state is CustomIrrigationPutSuccessState) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BottomNavBarScreen(),
                  ),
                  (route) => false);
            } else if (state is CustomIrrigationPutFailState) {
              errorToast('An error has occured');
            }
          },
          builder: (context, state) {
            CustomIrrigationCubit myCubit = CustomIrrigationCubit.get(context);
            return myCubit.irrigationSettingsModel == null ||
                    state is CustomIrrigationLoadingState
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Column(
                        children: [
                          MainCard2(
                              editButton: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CustomDurationSettingsScreen(
                                                stationId: widget.stationId,
                                                lineIndex: widget.lineIndex,
                                                valveId: widget.valveId),
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
                              mainWidget: Column(children: [
                                CustomIrrigationChooseDyasWidget(
                                  lineIndex: widget.lineIndex,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                SetSettings2RowsContainer(
                                    visible: false,
                                    function: () {},
                                    firstRowTitle:
                                        text[chosenLanguage]!['Each cycle']!,
                                    firstRowWidget: OpenValvePeriodTextField(
                                        control: hourControl,
                                        hintText: '00',
                                        unit: text[chosenLanguage]!['Hours']!),
                                    secondRowTitle:
                                        widget.irrigationMethod2 == 1
                                            ? text[chosenLanguage]![
                                                'Open valve time']!
                                            : text[chosenLanguage]![
                                                'Amount of water']!,
                                    secondRowWidget: OpenValvePeriodTextField(
                                        control: minutesControl,
                                        hintText: '00',
                                        unit: widget.irrigationMethod2 == 1
                                            ? text[chosenLanguage]!['Minutes']!
                                            : text[chosenLanguage]!['ml']!))
                              ]),
                              rowWidget: MainIconsRowWidget(
                                icon1: 'm',
                                icon2: 'f',
                                icon3: 'w',
                                icon4:
                                    widget.irrigationMethod2 == 1 ? 'x' : 'c',
                              ),
                              function: () {
                                bool validInfo = true;
                                if (myCubit
                                        .customIrrigationModelList[
                                            widget.lineIndex]
                                        .noDayIsChosen ==
                                    7) {
                                  errorToast('Please choose the days of work');
                                } else if (hourControl.text.isEmpty ||
                                    minutesControl.text.isEmpty) {
                                  errorToast(widget.irrigationMethod2 == 1
                                      ? 'Please add the open valve time'
                                      : 'Please add the amount of water needed');
                                } else {
                                  if (widget.irrigationMethod2 == 1) {
                                    validInfo =
                                        myCubit.checkOpenValveTimeSeriesByCycle(
                                            hours:
                                                double.parse(hourControl.text),
                                            openValveTime: double.parse(
                                                minutesControl.text));
                                  }
                                  if (validInfo == true) {
                                    myCubit.putIrrigationCycle(
                                        interval: int.parse(hourControl.text),
                                        stationId: widget.stationId,
                                        valveId: widget.valveId,
                                        duration: widget.irrigationMethod2 == 1
                                            ? int.parse(minutesControl.text)
                                            : 0,
                                        quantity: widget.irrigationMethod2 == 2
                                            ? int.parse(minutesControl.text)
                                            : 0,
                                        weekDays: myCubit.toDecimal(
                                            lineIndex: widget.lineIndex));
                                  } else if (validInfo == false) {
                                    errorToast('Input error');
                                  }
                                }
                              },
                              cardtitle:
                                  text[chosenLanguage]!['Duration settings']!,
                              buttonColor: greenButtonColor),
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
