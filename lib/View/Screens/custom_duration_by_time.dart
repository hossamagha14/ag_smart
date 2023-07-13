import 'package:ag_smart/View%20Model/bloc/Custom%20Irrigation/custom_irrigation_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Custom%20Irrigation/custom_irrigation_states.dart';
import 'package:ag_smart/View%20Model/bloc/commom_states.dart';
import 'package:ag_smart/View/Reusable/add_new_container_button.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/toasts.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/main_icons_row_widget.dart';
import 'package:ag_smart/View/Reusable/my_time_picker.dart';
import 'package:ag_smart/View/Reusable/open_valve_period_text_field.dart';
import 'package:ag_smart/View/Reusable/set_settings_2rows_container.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../View Model/Repo/auth_bloc.dart';
import '../Reusable/custom_irrigation_choose_day.dart';
import '../Reusable/loading_set_settings_2_rows.dart';
import 'bottom_nav_bar.dart';
import 'custom_duration_settings.dart';

// ignore: must_be_immutable
class CustomDurationByTime extends StatefulWidget {
  final int lineIndex;
  final int valveId;
  final int stationId;
  final int irrigationMethod2;
  final int flowMeter;
  final int currentMethod1;
  final int currentMethod2;
  const CustomDurationByTime(
      {Key? key,
      required this.lineIndex,
      required this.currentMethod1,
      required this.currentMethod2,
      required this.valveId,
      required this.flowMeter,
      required this.stationId,
      required this.irrigationMethod2})
      : super(key: key);

  @override
  State<CustomDurationByTime> createState() => _CustomDurationByTimeState();
}

class _CustomDurationByTimeState extends State<CustomDurationByTime> {
  TextEditingController openValveControl = TextEditingController();
  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text[chosenLanguage]!['Device Setup']!),
      ),
      body: SafeArea(
          child: BlocProvider(
        create: (context) => CustomIrrigationCubit(authBloc)
          ..getPeriods(
              stationId: widget.stationId,
              lineIndex: widget.lineIndex,
              valveId: widget.valveId),
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
              errorToast(context,'An error has occured');
            } else if (state is CustomIrrigationGetFailState) {
              errorToast(context,'An error has occured');
              Navigator.pop(context);
            } else if (state is CustomIrrigationDeleteFailedState) {
              errorToast(context,'An error has occured');
            }
          },
          builder: (context, state) {
            CustomIrrigationCubit myCubit = CustomIrrigationCubit.get(context);
            return myCubit.irrigationSettingsModel == null
                ? const Center(child: CircularProgressIndicator())
                : BlocListener<AuthBloc, CommonStates>(
                    listener: (context, state) {
                      if (state is ExpiredTokenState) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(),
                            ),
                            (route) => false);
                        expiredTokenToast(context);
                      }
                      if (state is ServerDownState) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(),
                            ),
                            (route) => false);
                        serverDownToast(context);
                      }
                    },
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: Column(
                          children: [
                            MainCard2(
                                editButton: InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CustomDurationSettingsScreen(
                                                  currentMethod1:
                                                      widget.currentMethod1,
                                                  currentMethod2:
                                                      widget.currentMethod2,
                                                  stationId: widget.stationId,
                                                  flowMeter: widget.flowMeter,
                                                  lineIndex: widget.lineIndex,
                                                  valveId: widget.valveId),
                                        ));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right:
                                            MediaQuery.of(context).size.width *
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
                                    CustomIrrigationChooseDyasWidget(
                                      lineIndex: widget.lineIndex,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.33,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: ListView.separated(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) => myCubit
                                                      .customIrrigationModelList[
                                                          widget.lineIndex]
                                                      .isBeingDeleted[index] ==
                                                  false
                                              ? SetSettings2RowsContainer(
                                                  visible: myCubit.visible,
                                                  function: () {
                                                    if (myCubit
                                                            .irrigationSettingsModel!
                                                            .customValvesSettings![
                                                                widget
                                                                    .lineIndex]
                                                            .irrigationPeriods!
                                                            .length >
                                                        index) {
                                                      myCubit.removeContainerFromdb(
                                                          lineIndex:
                                                              widget.lineIndex,
                                                          weekday: myCubit.toDecimal(
                                                              lineIndex: widget
                                                                  .lineIndex),
                                                          containerIndex: index,
                                                          stationId:
                                                              widget.stationId,
                                                          valveId:
                                                              widget.valveId,
                                                          periodId: myCubit
                                                              .customIrrigationModelList[
                                                                  widget
                                                                      .lineIndex]
                                                              .controllersList
                                                              .length);
                                                    } else {
                                                      myCubit.removeContainer(
                                                          lineIndex:
                                                              widget.lineIndex,
                                                          containerIndex:
                                                              index);
                                                    }
                                                  },
                                                  firstRowTitle:
                                                      text[chosenLanguage]![
                                                          'Set time']!,
                                                  firstRowWidget: MyTimePicker(
                                                      time: DateFormat('HH:mm')
                                                          .format(DateTime(
                                                              2023,
                                                              1,
                                                              1,
                                                              myCubit
                                                                  .customIrrigationModelList[
                                                                      widget.lineIndex]
                                                                  .timeList[index]
                                                                  .hour,
                                                              myCubit.customIrrigationModelList[widget.lineIndex].timeList[index].minute)),
                                                      function: (value) => myCubit.pickTime(value, index, widget.lineIndex)),
                                                  secondRowTitle: myCubit.customIrrigationModelList[widget.lineIndex].accordingToQuantity == false ? text[chosenLanguage]!['Open valve time']! : text[chosenLanguage]!['Amount of water']!,
                                                  secondRowWidget: OpenValvePeriodTextField(
                                                    control: myCubit
                                                        .customIrrigationModelList[
                                                            widget.lineIndex]
                                                        .controllersList[index],
                                                    hintText: '00',
                                                    unit: myCubit
                                                                .customIrrigationModelList[
                                                                    widget
                                                                        .lineIndex]
                                                                .accordingToQuantity ==
                                                            false
                                                        ? text[chosenLanguage]![
                                                            'Minutes']!
                                                        : text[chosenLanguage]![
                                                            'ml']!,
                                                  ))
                                              : LoadingSetSettings2RowsContainer(
                                                  visible: false,
                                                  function: () {},
                                                  firstRowTitle: text[chosenLanguage]!['Set time']!,
                                                  firstRowWidget: MyTimePicker(time: myCubit.customIrrigationModelList[widget.lineIndex].timeList[index].format(context).toString(), function: (value) => myCubit.pickTime(value, index, widget.lineIndex)),
                                                  secondRowTitle: myCubit.customIrrigationModelList[widget.lineIndex].accordingToQuantity == false ? text[chosenLanguage]!['Open valve time']! : text[chosenLanguage]!['Amount of water']!,
                                                  secondRowWidget: OpenValvePeriodTextField(
                                                    control: myCubit
                                                        .customIrrigationModelList[
                                                            widget.lineIndex]
                                                        .controllersList[index],
                                                    hintText: '00',
                                                    unit: myCubit
                                                                .customIrrigationModelList[
                                                                    widget
                                                                        .lineIndex]
                                                                .accordingToQuantity ==
                                                            false
                                                        ? text[chosenLanguage]![
                                                            'Minutes']!
                                                        : text[chosenLanguage]![
                                                            'ml']!,
                                                  )),
                                          separatorBuilder: (context, index) => SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                          itemCount: myCubit.customIrrigationModelList[widget.lineIndex].controllersList.length),
                                    ),
                                    AddNewContainerButton(
                                      functionAdd: () {
                                        myCubit.addContainer(widget.lineIndex,
                                            hour: 0, minute: 0);
                                      },
                                      functionRemove: () {
                                        myCubit.showDeleteButton();
                                      },
                                    )
                                  ],
                                ),
                                rowWidget: MainIconsRowWidget(
                                  icon1: 'm',
                                  icon2: 'f',
                                  icon3: 'u',
                                  icon4: myCubit
                                              .customIrrigationModelList[
                                                  widget.lineIndex]
                                              .accordingToQuantity ==
                                          false
                                      ? 'x'
                                      : 'c',
                                ),
                                function: () {
                                  bool allFull = true;
                                  bool validInfo = true;

                                  for (int i = 0;
                                      i <
                                          myCubit
                                              .customIrrigationModelList[
                                                  widget.lineIndex]
                                              .controllersList
                                              .length;
                                      i++) {
                                    if (myCubit
                                        .customIrrigationModelList[
                                            widget.lineIndex]
                                        .controllersList[i]
                                        .text
                                        .isEmpty) {
                                      allFull = false;
                                    }
                                  }
                                  if (allFull == true) {
                                    if (widget.irrigationMethod2 == 1) {
                                      validInfo =
                                          myCubit.checkOpenValveTimeParallel(
                                              lineIndex: widget.lineIndex);
                                    }
                                  }
                                  if (myCubit
                                          .customIrrigationModelList[
                                              widget.lineIndex]
                                          .noDayIsChosen ==
                                      7) {
                                    errorToast(context,
                                        'Please choose the days of work');
                                  } else {
                                    if (allFull == true && validInfo == true) {
                                      myCubit.putIrrigationHour(
                                          stationId: widget.stationId,
                                          periodsList: myCubit.makeAList(
                                              lineIndex: widget.lineIndex,
                                              valveId: widget.valveId,
                                              weekday: myCubit.toDecimal(
                                                  lineIndex:
                                                      widget.lineIndex)));
                                    } else if (allFull == false) {
                                      errorToast(context,myCubit
                                                  .customIrrigationModelList[
                                                      widget.lineIndex]
                                                  .accordingToQuantity ==
                                              false
                                          ? 'Please add the open valve time'
                                          : 'Please add the amount of water needed');
                                    } else if (validInfo == false) {
                                      errorToast(context,'Input error');
                                    }
                                  }
                                },
                                cardtitle:
                                    text[chosenLanguage]!['Duration settings']!,
                                buttonColor: greenButtonColor),
                          ],
                        ),
                      ),
                    ),
                  );
          },
        ),
      )),
    );
  }
}
