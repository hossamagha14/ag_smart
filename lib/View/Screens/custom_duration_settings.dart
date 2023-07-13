import 'package:ag_smart/View%20Model/bloc/Custom%20Irrigation/custom_irrigation_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Custom%20Irrigation/custom_irrigation_states.dart';
import 'package:ag_smart/View%20Model/bloc/commom_states.dart';
import 'package:ag_smart/View/Reusable/duration_settings_row.dart';
import 'package:ag_smart/View/Reusable/toasts.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Reusable/text_style.dart';
import 'package:ag_smart/View/Screens/custom_duration_settings_period.dart';
import 'package:ag_smart/View/Screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../View Model/Repo/auth_bloc.dart';
import '../Reusable/colors.dart';
import '../Reusable/main_icons_row_widget.dart';
import 'custom_duration_by_time.dart';

class CustomDurationSettingsScreen extends StatefulWidget {
  final int lineIndex;
  final int valveId;
  final int stationId;
  final int flowMeter;
  final int currentMethod1;
  final int currentMethod2;
  const CustomDurationSettingsScreen(
      {Key? key,
      required this.lineIndex,
      required this.currentMethod1,
      required this.currentMethod2,
      required this.flowMeter,
      required this.valveId,
      required this.stationId})
      : super(key: key);

  @override
  State<CustomDurationSettingsScreen> createState() =>
      _CustomDurationSettingsScreenState();
}

class _CustomDurationSettingsScreenState
    extends State<CustomDurationSettingsScreen> {
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
      body: BlocConsumer<CustomIrrigationCubit, CommonStates>(
        listener: (context, state) {
          CustomIrrigationCubit myCubit = CustomIrrigationCubit.get(context);
          if (state is CustomIrrigationPutSuccessState) {
            if (myCubit.customIrrigationModelList[widget.lineIndex]
                    .accordingToHour ==
                true) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomDurationByTime(
                      currentMethod1: widget.currentMethod1,
                      currentMethod2: widget.currentMethod2,
                      flowMeter: widget.flowMeter,
                      stationId: widget.stationId,
                      valveId: widget.valveId,
                      lineIndex: widget.lineIndex,
                      irrigationMethod2: myCubit.irrigationMethod2!,
                    ),
                  ));
            } else if (myCubit.customIrrigationModelList[widget.lineIndex]
                    .accordingToHour ==
                false) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomDurationSettingsByPeriodScreen(
                      currentMethod1: widget.currentMethod1,
                      currentMethod2: widget.currentMethod2,
                      flowMeter: widget.flowMeter,
                      stationId: widget.stationId,
                      valveId: widget.valveId,
                      lineIndex: widget.lineIndex,
                      irrigationMethod2: myCubit.irrigationMethod2!,
                    ),
                  ));
            }
          } else if (state is CustomIrrigationPutFailState) {
            errorToast(context, 'An error has occured');
          }
        },
        builder: (context, state) {
          CustomIrrigationCubit myCubit = CustomIrrigationCubit.get(context);
          return myCubit.featuresModel == null
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
                  child: Column(
                    children: [
                      MainCard2(
                          function: () {
                            if (myCubit
                                        .customIrrigationModelList[
                                            widget.lineIndex]
                                        .accordingToHour ==
                                    null ||
                                myCubit
                                        .customIrrigationModelList[
                                            widget.lineIndex]
                                        .accordingToQuantity ==
                                    null) {
                              errorToast(context,'Please select both categories');
                            } else if (widget.currentMethod1 ==
                                    myCubit.irrigationMethod1! &&
                                widget.currentMethod2 ==
                                    myCubit.irrigationMethod2!) {
                              if (myCubit
                                      .customIrrigationModelList[
                                          widget.lineIndex]
                                      .accordingToHour ==
                                  true) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CustomDurationByTime(
                                        currentMethod1: widget.currentMethod1,
                                        currentMethod2: widget.currentMethod2,
                                        flowMeter: widget.flowMeter,
                                        stationId: widget.stationId,
                                        valveId: widget.valveId,
                                        lineIndex: widget.lineIndex,
                                        irrigationMethod2:
                                            myCubit.irrigationMethod2!,
                                      ),
                                    ));
                              } else if (myCubit
                                      .customIrrigationModelList[
                                          widget.lineIndex]
                                      .accordingToHour ==
                                  false) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CustomDurationSettingsByPeriodScreen(
                                        currentMethod1: widget.currentMethod1,
                                        currentMethod2: widget.currentMethod2,
                                        flowMeter: widget.flowMeter,
                                        stationId: widget.stationId,
                                        valveId: widget.valveId,
                                        lineIndex: widget.lineIndex,
                                        irrigationMethod2:
                                            myCubit.irrigationMethod2!,
                                      ),
                                    ));
                              }
                            } else {
                              myCubit.putIrrigationSettings(
                                  irrigationMethod1: myCubit.irrigationMethod1!,
                                  irrigationMethod2: myCubit.irrigationMethod2!,
                                  valveId: widget.valveId,
                                  lineIndex: widget.lineIndex,
                                  stationId: widget.stationId);
                            }
                          },
                          buttonColor: greenButtonColor,
                          mainWidget: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              DurationSettingsRow(
                                  firstButtonTitle: text[chosenLanguage]![
                                      'According to time']!,
                                  secondButtonTitle: text[chosenLanguage]![
                                      'According to cycle']!,
                                  firstButtonIcon: Center(
                                      child: Text(
                                    'u',
                                    style: mainIcon,
                                  )),
                                  secondButtonIcon: Center(
                                      child: Text(
                                    'w',
                                    style: mainIcon,
                                  )),
                                  firstButtonFunction: () {
                                    myCubit.chooseAccordingToHour(
                                        widget.lineIndex);
                                  },
                                  secondButtonFunction: () {
                                    myCubit.chooseAccordingToPeriod(
                                        widget.lineIndex);
                                  },
                                  firstButtonColor: myCubit
                                              .customIrrigationModelList[
                                                  widget.lineIndex]
                                              .accordingToHour ==
                                          true
                                      ? selectedColor
                                      : Colors.white,
                                  secondButtonColor: myCubit
                                              .customIrrigationModelList[
                                                  widget.lineIndex]
                                              .accordingToHour ==
                                          false
                                      ? selectedColor
                                      : Colors.white),
                              DurationSettingsRow(
                                firstButtonTitle:
                                    text[chosenLanguage]!['Watering duration']!,
                                secondButtonTitle: text[chosenLanguage]![
                                    'According to quantity']!,
                                firstButtonIcon: Center(
                                    child: Text(
                                  'v',
                                  style: mainIcon,
                                )),
                                secondButtonIcon: Center(
                                    child: Text(
                                  'c',
                                  style: widget.flowMeter == 2
                                      ? mainIcon
                                      : mainIconDisabled,
                                )),
                                firstButtonFunction: () {
                                  myCubit
                                      .chooseAccordingToTime(widget.lineIndex);
                                },
                                secondButtonFunction: () {
                                  if (widget.flowMeter == 2) {
                                    myCubit.chooseAccordingToQuantity(
                                        widget.lineIndex);
                                  } else {
                                    errorToast(context,text[chosenLanguage]![
                                        'You are not subscribed for this feature']!);
                                  }
                                },
                                firstButtonColor: myCubit
                                            .customIrrigationModelList[
                                                widget.lineIndex]
                                            .accordingToQuantity ==
                                        false
                                    ? selectedColor
                                    : Colors.white,
                                secondButtonColor: widget.flowMeter != 2
                                    ? disabledBackground
                                    : myCubit
                                                .customIrrigationModelList[
                                                    widget.lineIndex]
                                                .accordingToQuantity ==
                                            true
                                        ? selectedColor
                                        : Colors.white,
                              ),
                            ],
                          ),
                          rowWidget: const MainIconsRowWidget(
                            icon1: 'm',
                            icon2: 'f',
                          ),
                          cardtitle: 'Line ${widget.valveId}'),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
