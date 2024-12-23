import 'package:ag_smart/View%20Model/bloc/Firtiliser%20settings/firtiliser_settings_states.dart';
import 'package:ag_smart/View%20Model/bloc/Firtiliser%20settings/firtiliser_settings_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/commom_states.dart';
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
import 'package:ag_smart/View/Screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;
import '../../View Model/Repo/auth_bloc.dart';
import '../Reusable/day_picker_pop_up.dart';
import 'firtilisation_type.dart';

// ignore: must_be_immutable
class FirtiliserSettingsScreen extends StatefulWidget {
  final int flowMeter;
  final int currentIndexF1;
  final int currentIndexF2;
  const FirtiliserSettingsScreen(
      {Key? key,
      required this.flowMeter,
      required this.currentIndexF2,
      required this.currentIndexF1})
      : super(key: key);

  @override
  State<FirtiliserSettingsScreen> createState() =>
      _FirtiliserSettingsScreenState();
}

class _FirtiliserSettingsScreenState extends State<FirtiliserSettingsScreen> {
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
      body: BlocConsumer<FirtiliserSettingsCubit, CommonStates>(
        listener: (context, state) {
          if (state is FirtiliserSettingsSendSuccessState) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomNavBarScreen(),
                ),
                (route) => false);
          } else if (state is FirtiliserSettingsSendFailState) {
            errorToast(context,'An error has occurred');
          }
        },
        builder: (context, state) {
          FirtiliserSettingsCubit myCubit =
              FirtiliserSettingsCubit.get(context);
          return state is FirtiliserLoadingState ||
                  myCubit.fertilizationModel == null
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
                                              FirtilisationTypeScreen(
                                                currentIndexF1: widget.currentIndexF1,
                                                currentIndexF2: widget.currentIndexF2,
                                                flowMeter: widget.flowMeter,
                                              )));
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
                                        myCubit.firtiliserModel.controllersList
                                            .length;
                                    i++) {
                                  if (myCubit.firtiliserModel.controllersList[i]
                                          .text.isEmpty ||
                                      myCubit.firtiliserModel.dateList.length -
                                              1 <
                                          i ||
                                      myCubit.firtiliserModel.dateList[i] ==
                                          0) {
                                    allFull = false;
                                  }
                                  if (allFull == true) {
                                    if (myCubit.fertilizationModel!
                                            .fertilizationMethod2 ==
                                        1) {
                                      if (myCubit.fertilizationModel!
                                              .fertilizationMethod1 ==
                                          1) {
                                        validInfo = myCubit
                                            .checkOpenValveTimeSeriesByTime();
                                      } else if (myCubit.fertilizationModel!
                                              .fertilizationMethod1 ==
                                          2) {
                                        validInfo = myCubit
                                            .checkOpenValveTimeParallel();
                                      }
                                    }
                                  }
                                }

                                if (allFull == true && validInfo) {
                                  myCubit.putFertilizationPeriods(
                                      periodsList: myCubit.makeAList(myCubit
                                          .fertilizationModel!
                                          .fertilizationMethod2!));
                                } else if (allFull == false) {
                                  errorToast(context,'Please fill all the data');
                                } else if (validInfo == false) {
                                  errorToast(context,'Input error');
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
                                        0.4,
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
                                                    method2: myCubit
                                                        .fertilizationModel!
                                                        .fertilizationMethod2!,
                                                    periodId: myCubit
                                                        .firtiliserModel
                                                        .controllersList
                                                        .length);
                                              },
                                              firstRowTitle: text[
                                                  chosenLanguage]!['Set day']!,
                                              firstRowWidget: InkWell(
                                                onTap: () {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        BlocBuilder<
                                                            FirtiliserSettingsCubit,
                                                            CommonStates>(
                                                      builder:
                                                          (context, state) {
                                                        return DayPickerPopUp(
                                                            function: (value) {
                                                              myCubit.chooseDay(
                                                                  value, index);
                                                            },
                                                            value: myCubit
                                                                .dayValue,
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
                                                          ? text[chosenLanguage]![
                                                              'Date']!
                                                          : myCubit
                                                              .firtiliserModel
                                                              .dateList[index]
                                                              .toString(),
                                                      textAlign:
                                                          TextAlign.center,
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
                                                  function: (value) =>
                                                      myCubit.chooseTime(
                                                          value, index)),
                                              thirdRowTitle: myCubit
                                                          .fertilizationModel!
                                                          .fertilizationMethod2 ==
                                                      1
                                                  ? text[chosenLanguage]!['Open valve time']!
                                                  : text[chosenLanguage]!['Fertillization amount']!,
                                              thirdRowWidget: OpenValvePeriodTextField(hintText: '00', unit: myCubit.fertilizationModel!.fertilizationMethod2 == 1 ? text[chosenLanguage]!['Minutes']! : text[chosenLanguage]!['ml']!, control: myCubit.firtiliserModel.controllersList[index]));
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
                                myCubit.fertilizationModel!
                                            .fertilizationMethod2 ==
                                        1
                                    ? 'g'
                                    : 'h',
                                style: yellowIcon,
                              ),
                              cardtitle: text[chosenLanguage]![
                                  'Fertilizer Settings']!),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
