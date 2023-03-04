import 'package:ag_smart/View%20Model/bloc/Custom%20Irrigation/custom_irrigation_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Custom%20Irrigation/custom_irrigation_states.dart';
import 'package:ag_smart/View/Reusable/add_new_container_button.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/error_toast.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/main_icons_row_widget.dart';
import 'package:ag_smart/View/Reusable/my_time_picker.dart';
import 'package:ag_smart/View/Reusable/open_valve_period_text_field.dart';
import 'package:ag_smart/View/Reusable/set_settings_2rows_container.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Screens/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Reusable/custom_irrigation_choose_day.dart';
import '../Reusable/loading_set_settings_2_rows.dart';

// ignore: must_be_immutable
class CustomDurationByTime extends StatelessWidget {
  final int lineIndex;
  CustomDurationByTime({Key? key, required this.lineIndex}) : super(key: key);
  TextEditingController openValveControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text[chosenLanguage]!['Device Setup']!),
      ),
      body: SafeArea(
          child: BlocProvider(
        create: (context) => CustomIrrigationCubit()
          ..getPeriods(stationId: 1, lineIndex: lineIndex),
        child: BlocConsumer<CustomIrrigationCubit, CustomIrrigationStates>(
          listener: (context, state) {
            CustomIrrigationCubit myCubit = CustomIrrigationCubit.get(context);
            if (myCubit.allSent == true) {
              if (state is CustomIrrigationPutSuccessState) {
                myCubit.allSent == false;
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNavBarScreen(),
                    ),
                    (route) => false);
              } else if (state is CustomIrrigationPutFailState) {
                myCubit.allSent == false;
                errorToast('An error has occured');
              }
            }
          },
          builder: (context, state) {
            CustomIrrigationCubit myCubit = CustomIrrigationCubit.get(context);
            return myCubit.irrigationSettingsModel == null
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Column(
                        children: [
                          MainCard2(
                              mainWidget: Column(
                                children: [
                                  CustomIrrigationChooseDyasWidget(
                                    lineIndex: lineIndex,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: ListView.separated(
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) => myCubit
                                                    .customIrrigationModelList[
                                                        lineIndex]
                                                    .isBeingDeleted[index] ==
                                                false
                                            ? SetSettings2RowsContainer(
                                                visible: myCubit.visible,
                                                function: () {
                                                  myCubit.removeContainerFromdb(
                                                      lineIndex: lineIndex,
                                                      containerIndex: index,
                                                      stationId: 1,
                                                      valveId: lineIndex+1,
                                                      periodId: index+1);
                                                },
                                                firstRowTitle: text[chosenLanguage]![
                                                    'Set time']!,
                                                firstRowWidget: MyTimePicker(
                                                    time: myCubit.customIrrigationModelList[lineIndex].timeList[index]
                                                        .format(context)
                                                        .toString(),
                                                    function: (value) => myCubit.pickTime(
                                                        value, index, lineIndex)),
                                                secondRowTitle: myCubit
                                                            .customIrrigationModelList[lineIndex]
                                                            .accordingToQuantity ==
                                                        false
                                                    ? text[chosenLanguage]!['Open valve time']!
                                                    : text[chosenLanguage]!['Amount of water']!,
                                                secondRowWidget: OpenValvePeriodTextField(
                                                  control: myCubit
                                                      .customIrrigationModelList[
                                                          lineIndex]
                                                      .controllersList[index],
                                                  hintText: '00',
                                                  unit: myCubit
                                                              .customIrrigationModelList[
                                                                  lineIndex]
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
                                                firstRowWidget: MyTimePicker(time: myCubit.customIrrigationModelList[lineIndex].timeList[index].format(context).toString(), function: (value) => myCubit.pickTime(value, index, lineIndex)),
                                                secondRowTitle: myCubit.customIrrigationModelList[lineIndex].accordingToQuantity == false ? text[chosenLanguage]!['Open valve time']! : text[chosenLanguage]!['Amount of water']!,
                                                secondRowWidget: OpenValvePeriodTextField(
                                                  control: myCubit
                                                      .customIrrigationModelList[
                                                          lineIndex]
                                                      .controllersList[index],
                                                  hintText: '00',
                                                  unit: myCubit
                                                              .customIrrigationModelList[
                                                                  lineIndex]
                                                              .accordingToQuantity ==
                                                          false
                                                      ? text[chosenLanguage]![
                                                          'Minutes']!
                                                      : text[chosenLanguage]![
                                                          'ml']!,
                                                )),
                                        separatorBuilder: (context, index) => SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                                        itemCount: myCubit.customIrrigationModelList[lineIndex].controllersList.length),
                                  ),
                                  AddNewContainerButton(
                                    functionAdd: () {
                                      myCubit.addContainer(lineIndex);
                                      print(myCubit
                                          .customIrrigationModelList[lineIndex]
                                          .controllersList
                                          .length);
                                    },
                                    functionRemove: () {
                                      myCubit.showDeleteButton();
                                      print(myCubit
                                          .customIrrigationModelList[lineIndex]
                                          .controllersList
                                          .length);
                                    },
                                  )
                                ],
                              ),
                              rowWidget: MainIconsRowWidget(
                                icon1: 'm',
                                icon2: 'f',
                                icon3: 'u',
                                icon4:
                                    myCubit.customIrrigationModelList[lineIndex]
                                                .accordingToQuantity ==
                                            false
                                        ? 'x'
                                        : 'c',
                              ),
                              function: () {
                                bool allFull = true;
                                for (int i = 0;
                                    i <
                                        myCubit
                                            .customIrrigationModelList[
                                                lineIndex]
                                            .controllersList
                                            .length;
                                    i++) {
                                  if (myCubit
                                      .customIrrigationModelList[lineIndex]
                                      .controllersList[i]
                                      .text
                                      .isEmpty) {
                                    allFull = false;
                                  }
                                }
                                if (myCubit.customIrrigationModelList[lineIndex]
                                        .noDayIsChosen ==
                                    7) {
                                  errorToast('Please choose the days of work');
                                } else {
                                  if (allFull == true) {
                                    for (int i = 0;
                                        i <
                                            myCubit
                                                .customIrrigationModelList[
                                                    lineIndex]
                                                .controllersList
                                                .length;
                                        i++) {
                                      myCubit.putIrrigationHour(
                                          stationId: 1,
                                          periodId: i + 1,
                                          valveId: lineIndex + 1,
                                          startTime: myCubit
                                              .customIrrigationModelList[
                                                  lineIndex]
                                              .timeList[i],
                                          duration: myCubit
                                                      .customIrrigationModelList[
                                                          lineIndex]
                                                      .accordingToQuantity ==
                                                  false
                                              ? int.parse(myCubit
                                                  .customIrrigationModelList[
                                                      lineIndex]
                                                  .controllersList[i]
                                                  .text)
                                              : 0,
                                          quantity: myCubit
                                                      .customIrrigationModelList[lineIndex]
                                                      .accordingToQuantity ==
                                                  true
                                              ? int.parse(myCubit.customIrrigationModelList[lineIndex].controllersList[i].text)
                                              : 0,
                                          weekDays: 9);
                                      if (i ==
                                          myCubit
                                                  .customIrrigationModelList[
                                                      lineIndex]
                                                  .controllersList
                                                  .length -
                                              1) {
                                        myCubit.allSent = true;
                                      }
                                    }
                                  } else if (allFull == false) {
                                    errorToast(myCubit
                                                .customIrrigationModelList[
                                                    lineIndex]
                                                .accordingToQuantity ==
                                            false
                                        ? 'Please add the open valve time'
                                        : 'Please add the amount of water needed');
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
      )),
    );
  }
}
