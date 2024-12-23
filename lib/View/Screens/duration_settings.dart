import 'package:ag_smart/View%20Model/bloc/Irrigation%20type/irrigation_type_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Irrigation%20type/irrigation_type_states.dart';
import 'package:ag_smart/View%20Model/bloc/commom_states.dart';
import 'package:ag_smart/View/Reusable/duration_settings_row.dart';
import 'package:ag_smart/View/Reusable/toasts.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Reusable/text_style.dart';
import 'package:ag_smart/View/Screens/duration_settings_by_period.dart';
import 'package:ag_smart/View/Screens/duration_settings_hours.dart';
import 'package:ag_smart/View/Screens/period_amount.dart';
import 'package:ag_smart/View/Screens/sign_in.dart';
import 'package:ag_smart/View/Screens/time_amount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../View Model/Repo/auth_bloc.dart';
import '../Reusable/colors.dart';

class DurationSettingsScreen extends StatefulWidget {
  final bool isEdit;
  final int stationIrrigationType;
  final int flowMeter;
  final int pressure;
  final int pressureSwitch;
  const DurationSettingsScreen(
      {Key? key,
      required this.isEdit,
      required this.stationIrrigationType,
      required this.pressure,
      required this.pressureSwitch,
      required this.flowMeter})
      : super(key: key);

  @override
  State<DurationSettingsScreen> createState() => _DurationSettingsScreenState();
}

class _DurationSettingsScreenState extends State<DurationSettingsScreen> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocConsumer<IrrigationTypeCubit, CommonStates>(
              listener: (context, state) {
                IrrigationTypeCubit myCubit = IrrigationTypeCubit.get(context);
                if (state is IrrigationTypeSendSuccessState) {
                  if (myCubit.accordingToHour == true &&
                      myCubit.accordingToQuantity == false) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DurationSettingsByHourScreen(
                            pressureSwitch: widget.pressureSwitch,
                            pressure: widget.pressure,
                            flowMeter: widget.flowMeter,
                            isEdit: widget.isEdit,
                            irrigationType: widget.stationIrrigationType,
                          ),
                        ));
                  } else if (myCubit.accordingToHour == true &&
                      myCubit.accordingToQuantity == true) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TimeAmountScreen(
                            pressureSwitch: widget.pressureSwitch,
                            pressure: widget.pressure,
                            flowMeter: widget.flowMeter,
                            isEdit: widget.isEdit,
                            irrigationType: widget.stationIrrigationType,
                          ),
                        ));
                  } else if (myCubit.accordingToHour == false &&
                      myCubit.accordingToQuantity == false) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DurationSettingsByPeriodScreen(
                            pressureSwitch: widget.pressureSwitch,
                            pressure: widget.pressure,
                            flowMeter: widget.flowMeter,
                            isEdit: widget.isEdit,
                            irrigationType: widget.stationIrrigationType,
                          ),
                        ));
                  } else if (myCubit.accordingToHour == false &&
                      myCubit.accordingToQuantity == true) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PeriodAmountScreen(
                            pressureSwitch: widget.pressureSwitch,
                            pressure: widget.pressure,
                            flowMeter: widget.flowMeter,
                            isEdit: widget.isEdit,
                            irrigationType: widget.stationIrrigationType,
                          ),
                        ));
                  }
                } else if (state is IrrigationTypeSendFailState) {
                  errorToast(context,'An error has occurred');
                }
              },
              builder: (context, state) {
                IrrigationTypeCubit myCubit = IrrigationTypeCubit.get(context);
                return BlocListener<AuthBloc, CommonStates>(
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
                  child: MainCard2(
                      function: () {
                        if (myCubit.accordingToHour == null ||
                            myCubit.accordingToQuantity == null) {
                          errorToast(context,"Please select both categories");
                        } else {
                          if (widget.isEdit == false) {
                            myCubit.putIrrigationType(
                                pressure: widget.pressure,
                                pressureSwitch: widget.pressureSwitch,
                                activeValves: binaryValves,
                                irrigationType: myCubit.irrigationType,
                                irrigationMethod1: myCubit.irrigationMethod1!,
                                irrigationMethod2: myCubit.irrigationMethod2!);
                          }else{
                            myCubit.putIrrigationTypeEdit(
                                pressure: widget.pressure,
                                pressureSwitch: widget.pressureSwitch,
                                activeValves: binaryValves,
                                irrigationType: myCubit.irrigationType,
                                irrigationMethod1: myCubit.irrigationMethod1!,
                                irrigationMethod2: myCubit.irrigationMethod2!);
                          }
                        }
                      },
                      buttonColor: greenButtonColor,
                      mainWidget: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DurationSettingsRow(
                              firstButtonTitle:
                                  text[chosenLanguage]!['According to time']!,
                              secondButtonTitle:
                                  text[chosenLanguage]!['According to cycle']!,
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
                                myCubit.chooseAccordingToHour();
                              },
                              secondButtonFunction: () {
                                myCubit.chooseAccordingToPeriod();
                              },
                              firstButtonColor: myCubit.accordingToHour == true
                                  ? selectedColor
                                  : Colors.white,
                              secondButtonColor:
                                  myCubit.accordingToHour == false
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
                                myCubit.chooseAccordingToTime();
                              },
                              secondButtonFunction: () {
                                if (widget.flowMeter == 2) {
                                  myCubit.chooseAccordingToQuantity();
                                } else {
                                  errorToast(context,text[chosenLanguage]![
                                      'You are not subscribed for this feature']!);
                                }
                              },
                              firstButtonColor:
                                  myCubit.accordingToQuantity == false
                                      ? selectedColor
                                      : Colors.white,
                              secondButtonColor: widget.flowMeter != 2
                                  ? disabledBackground
                                  : myCubit.accordingToQuantity == true
                                      ? selectedColor
                                      : Colors.white),
                        ],
                      ),
                      rowWidget: Row(
                        children: [
                          Text(
                            widget.stationIrrigationType == 1 ? 'r' : 't',
                            style: mainIcon,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                          ),
                          Text(
                            'm',
                            style: mainIcon,
                          ),
                        ],
                      ),
                      cardtitle: text[chosenLanguage]!['Duration settings']!),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
