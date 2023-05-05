import 'package:ag_smart/View%20Model/bloc/Firtiliser%20settings/firtiliser_settings_states.dart';
import 'package:ag_smart/View%20Model/bloc/Firtiliser%20settings/firtiliser_settings_cubit.dart';
import 'package:ag_smart/View/Reusable/add_new_container_button.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/toasts.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/my_time_picker.dart';
import 'package:ag_smart/View/Reusable/open_valve_period_text_field.dart';
import 'package:ag_smart/View/Reusable/set_settings_3rows_container.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Reusable/text_style.dart';
import 'package:ag_smart/View/Screens/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;
import '../Reusable/day_picker_pop_up.dart';

// ignore: must_be_immutable
class FirtiliserSettingsScreen extends StatelessWidget {
  const FirtiliserSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text[chosenLanguage]!['Device Setup']!),
      ),
      body: BlocConsumer<FirtiliserSettingsCubit, FirtiliserSettingsStates>(
        listener: (context, state) {
          if (state is FirtiliserSettingsSendSuccessState) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomNavBarScreen(),
                ),
                (route) => false);
          } else if (state is FirtiliserSettingsSendFailState) {
            errorToast('An error has occurred');
          }
        },
        builder: (context, state) {
          FirtiliserSettingsCubit myCubit =
              FirtiliserSettingsCubit.get(context);
          return myCubit.fertilizationModel == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.85,
                    child: Column(
                      children: [
                        MainCard2(
                            function: () {
                              bool allFull = true;
                              bool validInfo = true;
                              for (int i = 0;
                                  i <
                                      myCubit.firtiliserModel.controllersList
                                          .length;
                                  i++) {
                                if (myCubit.firtiliserModel.controllersList[i]
                                        .text.isEmpty ||
                                    myCubit.firtiliserModel.dateList.length -
                                            1 <
                                        i ||
                                    myCubit.firtiliserModel.dateList[i] == 0) {
                                  allFull = false;
                                }
                                if (allFull == true) {
                                  if (myCubit.method2 == 1) {
                                    if (myCubit.method1 == 1) {
                                      validInfo = myCubit
                                          .checkOpenValveTimeSeriesByTime();
                                    } else if (myCubit.method1 == 2) {
                                      validInfo =
                                          myCubit.checkOpenValveTimeParallel();
                                    }
                                  }
                                }
                              }

                              if (allFull == true && validInfo) {
                                myCubit.issDone();
                                myCubit.putFertilizationPeriods(
                                    periodsList: myCubit.makeAList());
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  child: ListView.separated(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return SetSettings3RowsContainer(
                                            visible: myCubit.deleteVisibile,
                                            function: () {
                                              myCubit.removeContainerFromdb(
                                                  containerIndex: index,
                                                  valveId: 0,
                                                  periodId: myCubit
                                                      .firtiliserModel
                                                      .controllersList
                                                      .length);
                                            },
                                            firstRowTitle: text[
                                                chosenLanguage]!['Set day']!,
                                            firstRowWidget: InkWell(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) => BlocBuilder<
                                                      FirtiliserSettingsCubit,
                                                      FirtiliserSettingsStates>(
                                                    builder: (context, state) {
                                                      return DayPickerPopUp(
                                                          function: (value) {
                                                            myCubit.chooseDay(
                                                                value, index);
                                                          },
                                                          value:
                                                              myCubit.dayValue,
                                                          lineIndex: 0,
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
                                                    myCubit.firtiliserModel.dateList
                                                                    .length -
                                                                1 <
                                                            index
                                                        ? 'Date'
                                                        : myCubit
                                                            .firtiliserModel
                                                            .dateList[index]
                                                            .toString(),
                                                    textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.ltr,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            secondRowTitle: text[
                                                chosenLanguage]!['Set time']!,
                                            secondRowWidget: MyTimePicker(
                                                time: intl.DateFormat('HH:mm')
                                                    .format(DateTime(
                                                        2023,
                                                        1,
                                                        1,
                                                        myCubit
                                                            .firtiliserModel
                                                            .timeList[index]
                                                            .hour,
                                                        myCubit
                                                            .firtiliserModel
                                                            .timeList[index]
                                                            .minute)),
                                                function: (value) => myCubit
                                                    .chooseTime(value, index)),
                                            thirdRowTitle: myCubit.method2 == 1
                                                ? text[chosenLanguage]![
                                                    'Open valve time']!
                                                : text[chosenLanguage]!['Fertillization amount']!,
                                            thirdRowWidget: OpenValvePeriodTextField(hintText: '00', unit: myCubit.method2 == 1 ? text[chosenLanguage]!['Minutes']! : text[chosenLanguage]!['ml']!, control: myCubit.firtiliserModel.controllersList[index]));
                                      },
                                      separatorBuilder: (context, index) {
                                        return SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                        );
                                      },
                                      itemCount: myCubit.firtiliserModel
                                          .controllersList.length),
                                ),
                                AddNewContainerButton(
                                  functionAdd: () {
                                    myCubit.addContainer(hour: 0, minute: 0);
                                  },
                                  functionRemove: () {
                                    myCubit.showDeleteButton();
                                  },
                                )
                              ],
                            ),
                            rowWidget: Text(
                              'g',
                              style: yellowIcon,
                            ),
                            cardtitle:
                                text[chosenLanguage]!['Fertilizer Settings']!),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
