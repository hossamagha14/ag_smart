import 'package:ag_smart/View%20Model/bloc/Custom%20Firtilization/custom_fertilization_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Custom%20Firtilization/custom_fertilization_states.dart';
import 'package:ag_smart/View%20Model/bloc/commom_states.dart';
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
import 'package:ag_smart/View/Screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../View Model/Repo/auth_bloc.dart';
import '../Reusable/toasts.dart';

// ignore: must_be_immutable
class CustomFirtiliserSettingsScreen extends StatefulWidget {
  final int lineIndex;
  final int valveId;
  final int fertiliationType;
  final int flowMeter;
  final int currentMethod;
  const CustomFirtiliserSettingsScreen(
      {Key? key,
      required this.lineIndex,
      required this.currentMethod,
      required this.valveId,
      required this.flowMeter,
      required this.fertiliationType})
      : super(key: key);

  @override
  State<CustomFirtiliserSettingsScreen> createState() =>
      _CustomFirtiliserSettingsScreenState();
}

class _CustomFirtiliserSettingsScreenState
    extends State<CustomFirtiliserSettingsScreen> {
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
      body: BlocConsumer<CustomFertilizationCubit, CommonStates>(
        listener: (context, state) {
          if (state is CustomFertilizationPutSuccessState) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomNavBarScreen(),
                ),
                (route) => false);
          } else if (state is CustomFertilizationPutFailState) {
            errorToast(context,'An error has occurred');
          }
        },
        builder: (context, state) {
          CustomFertilizationCubit myCubit =
              CustomFertilizationCubit.get(context);
          return state is CustomFertilizationLoadingState
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
                                              CustomFirtilizationTypesScreen(
                                                currentMethod: widget.currentMethod,
                                                flowMeter: widget.flowMeter,
                                                  lineIndex: widget.lineIndex,
                                                  valveId: widget.valveId)));
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
                                                widget.lineIndex]
                                            .controllers
                                            .length;
                                    i++) {
                                  if (myCubit
                                          .customFertilizationModelList[
                                              widget.lineIndex]
                                          .controllers[i]
                                          .text
                                          .isEmpty ||
                                      myCubit
                                                  .customFertilizationModelList[
                                                      widget.lineIndex]
                                                  .daysList
                                                  .length -
                                              1 <
                                          i ||
                                      myCubit
                                              .customFertilizationModelList[
                                                  widget.lineIndex]
                                              .daysList[i] ==
                                          0) {
                                    allFull = false;
                                  }
                                }
                                if (allFull == true) {
                                  if (widget.fertiliationType == 1) {
                                    validInfo =
                                        myCubit.checkOpenValveTimeParallel(
                                            lineIndex: widget.lineIndex);
                                  }
                                }
                                if (allFull == true && validInfo == true) {
                                  myCubit.putFertilizationPeriods(
                                      stationId: stationId,
                                      periodsList: myCubit.makeAList(
                                          ferMethod1: widget.fertiliationType,
                                          lineIndex: widget.lineIndex,
                                          valveId: widget.valveId));
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
                                              visible: myCubit.visible,
                                              function: () {
                                                myCubit.removeContainerFromdb(
                                                    lineIndex: widget.lineIndex,
                                                    containerIndex: index,
                                                    stationId: stationId,
                                                    valveId: widget.valveId,
                                                    ferMethod1:
                                                        widget.fertiliationType,
                                                    periodId: myCubit
                                                        .customFertilizationModelList[
                                                            widget.lineIndex]
                                                        .controllers
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
                                                            CustomFertilizationCubit,
                                                            CommonStates>(
                                                      builder:
                                                          (context, state) {
                                                        return DayPickerPopUp(
                                                            function: (value) {
                                                              
                                                              myCubit.chooseDay(
                                                                  value,
                                                                  widget
                                                                      .lineIndex,
                                                                  index);
                                                            },
                                                            value: myCubit
                                                                .dayValue,
                                                            lineIndex: widget
                                                                .lineIndex,
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
                                                                          widget
                                                                              .lineIndex]
                                                                      .daysList
                                                                      .length -
                                                                  1 <
                                                              index
                                                          ? text[chosenLanguage]![
                                                              'Date']!
                                                          : myCubit
                                                              .customFertilizationModelList[
                                                                  widget
                                                                      .lineIndex]
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
                                                  time: DateFormat('HH:mm').format(DateTime(
                                                      2023,
                                                      1,
                                                      1,
                                                      myCubit
                                                          .customFertilizationModelList[
                                                              widget.lineIndex]
                                                          .time[index]
                                                          .hour,
                                                      myCubit
                                                          .customFertilizationModelList[
                                                              widget.lineIndex]
                                                          .time[index]
                                                          .minute)),
                                                  function: (value) =>
                                                      myCubit.chooseTime(
                                                          value,
                                                          index,
                                                          widget.lineIndex)),
                                              thirdRowTitle: myCubit.fertilizationType == 1
                                                  ? text[chosenLanguage]!['Open valve time']!
                                                  : text[chosenLanguage]!['Fertillization amount']!,
                                              thirdRowWidget: OpenValvePeriodTextField(hintText: '00', unit: widget.fertiliationType == 1 ? text[chosenLanguage]!['Minutes']! : text[chosenLanguage]!['ml']!, control: myCubit.customFertilizationModelList[widget.lineIndex].controllers[index]));
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
                                                widget.lineIndex]
                                            .controllers
                                            .length),
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
                              rowWidget: Text(
                                widget.fertiliationType == 1 ? 'g' : 'h',
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
