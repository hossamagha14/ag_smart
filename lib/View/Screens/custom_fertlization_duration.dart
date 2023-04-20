import 'package:ag_smart/View%20Model/bloc/Custom%20Firtilization/custom_fertilization_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Custom%20Firtilization/custom_fertilization_states.dart';
import 'package:ag_smart/View/Reusable/add_new_container_button.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/day_picker_pop_up.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/my_time_picker.dart';
import 'package:ag_smart/View/Reusable/open_valve_period_text_field.dart';
import 'package:ag_smart/View/Reusable/set_settings_3rows_container.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Reusable/text_style.dart';
import 'package:ag_smart/View/Screens/bottom_nav_bar.dart';
import 'package:ag_smart/View/Screens/custom_ferilization_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../Reusable/toasts.dart';

// ignore: must_be_immutable
class CustomFirtiliserSettingsScreen extends StatelessWidget {
  final int lineIndex;
  final int valveId;
  final int fertiliationType;
  const CustomFirtiliserSettingsScreen(
      {Key? key,
      required this.lineIndex,
      required this.valveId,
      required this.fertiliationType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text[chosenLanguage]!['Device Setup']!),
      ),
      body: BlocProvider(
        create: (context) => CustomFertilizationCubit()
          ..getNumberOfValvesandperiods(
              serialNumber: serialNumber,
              lineIndex: lineIndex,
              valveId: valveId),
        child:
            BlocConsumer<CustomFertilizationCubit, CustomFertilizationStates>(
          listener: (context, state) {
            if (state is CustomFertilizationPutSuccessState) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BottomNavBarScreen(),
                  ),
                  (route) => false);
            } else if (state is CustomFertilizationPutFailState) {
              errorToast('An error has occurred');
            }
          },
          builder: (context, state) {
            CustomFertilizationCubit myCubit =
                CustomFertilizationCubit.get(context);
            return myCubit.fertilizationModel == null ||
                    myCubit.featuresModel == null
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.85,
                      child: Column(
                        children: [
                          MainCard2(
                              editButton: InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CustomFirtilizationTypesScreen(
                                                  lineIndex: lineIndex,
                                                  valveId: valveId)));
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
                              function: () {
                                bool allFull = true;
                                bool validInfo = true;
                                for (int i = 0;
                                    i <
                                        myCubit
                                            .customFertilizationModelList[
                                                lineIndex]
                                            .controllers
                                            .length;
                                    i++) {
                                  if (myCubit
                                          .customFertilizationModelList[
                                              lineIndex]
                                          .controllers[i]
                                          .text
                                          .isEmpty ||
                                      myCubit
                                                  .customFertilizationModelList[
                                                      lineIndex]
                                                  .daysList
                                                  .length -
                                              1 <
                                          i ||
                                      myCubit
                                              .customFertilizationModelList[
                                                  lineIndex]
                                              .daysList[i] ==
                                          0) {
                                    allFull = false;
                                  }
                                }
                                if (allFull == true) {
                                  if (fertiliationType == 1) {
                                    validInfo =
                                        myCubit.checkOpenValveTimeParallel(
                                            lineIndex: lineIndex);
                                  }
                                }
                                if (allFull == true && validInfo == true) {
                                  myCubit.putFertilizationPeriods(
                                      stationId: 1,
                                      periodsList: myCubit.makeAList(
                                          ferMethod1: fertiliationType,
                                          lineIndex: lineIndex,
                                          valveId: valveId));
                                } else if (allFull == false) {
                                  errorToast('Please fill all the data');
                                } else if (validInfo == false) {
                                  errorToast('Input error');
                                }
                              },
                              buttonColor: yellowColor,
                              mainWidget: Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: MediaQuery.of(context).size.height *
                                        0.35,
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return SetSettings3RowsContainer(
                                              visible: myCubit.visible,
                                              function: () {
                                                myCubit.removeContainerFromdb(
                                                    lineIndex: lineIndex,
                                                    containerIndex: index,
                                                    stationId: stationId,
                                                    valveId: valveId,
                                                    ferMethod1:
                                                        fertiliationType,
                                                    periodId: myCubit
                                                        .customFertilizationModelList[
                                                            lineIndex]
                                                        .controllers
                                                        .length);
                                              },
                                              firstRowTitle: text[
                                                  chosenLanguage]!['Set day']!,
                                              firstRowWidget: InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) => BlocBuilder<
                                                        CustomFertilizationCubit,
                                                        CustomFertilizationStates>(
                                                      builder:
                                                          (context, state) {
                                                        return DayPickerPopUp(
                                                            function: (value) {
                                                              myCubit.chooseDay(
                                                                  value,
                                                                  lineIndex,
                                                                  index);
                                                            },
                                                            value: myCubit
                                                                .dayValue,
                                                            lineIndex:
                                                                lineIndex,
                                                            index: index);
                                                      },
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.05,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.31,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Center(
                                                    child: Text(
                                                      myCubit
                                                                      .customFertilizationModelList[
                                                                          lineIndex]
                                                                      .daysList
                                                                      .length -
                                                                  1 <
                                                              index
                                                          ? 'Date'
                                                          : myCubit
                                                              .customFertilizationModelList[
                                                                  lineIndex]
                                                              .daysList[index]
                                                              .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              secondRowTitle: text[
                                                  chosenLanguage]!['Set time']!,
                                              secondRowWidget: MyTimePicker(
                                                  time: DateFormat('HH:mm')
                                                      .format(DateTime(
                                                          2023,
                                                          1,
                                                          1,
                                                          myCubit
                                                              .customFertilizationModelList[
                                                                  lineIndex]
                                                              .time[index]
                                                              .hour,
                                                          myCubit
                                                              .customFertilizationModelList[
                                                                  lineIndex]
                                                              .time[index]
                                                              .minute)),
                                                  function: (value) =>
                                                      myCubit.chooseTime(
                                                          value, index, lineIndex)),
                                              thirdRowTitle:
                                                  myCubit.fertilizationType == 1
                                                      ? text[chosenLanguage]![
                                                          'Open valve time']!
                                                      : text[chosenLanguage]!['Fertillization amount']!,
                                              thirdRowWidget: OpenValvePeriodTextField(hintText: '00', unit: fertiliationType == 1 ? text[chosenLanguage]!['Minutes']! : text[chosenLanguage]!['ml']!, control: myCubit.customFertilizationModelList[lineIndex].controllers[index]));
                                        },
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          );
                                        },
                                        itemCount: myCubit
                                            .customFertilizationModelList[
                                                lineIndex]
                                            .controllers
                                            .length),
                                  ),
                                  AddNewContainerButton(
                                    functionAdd: () {
                                      myCubit.addContainer(lineIndex,
                                          hour: 0, minute: 0);
                                    },
                                    functionRemove: () {
                                      myCubit.showDeleteButton();
                                    },
                                  )
                                ],
                              ),
                              rowWidget: Text(
                                fertiliationType == 1 ? 'g' : 'h',
                                style: yellowIcon,
                              ),
                              cardtitle: text[chosenLanguage]![
                                  'Fertilizer Settings']!),
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
