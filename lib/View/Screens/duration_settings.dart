import 'package:ag_smart/View%20Model/bloc/Irrigation%20type/irrigation_type_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Irrigation%20type/irrigation_type_states.dart';
import 'package:ag_smart/View/Reusable/duration_settings_row.dart';
import 'package:ag_smart/View/Reusable/toasts.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Reusable/text_style.dart';
import 'package:ag_smart/View/Screens/duration_settings_by_period.dart';
import 'package:ag_smart/View/Screens/duration_settings_hours.dart';
import 'package:ag_smart/View/Screens/period_amount.dart';
import 'package:ag_smart/View/Screens/time_amount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Reusable/colors.dart';

class DurationSettingsScreen extends StatelessWidget {
  final bool isEdit;
  final int stationIrrigationType;
  const DurationSettingsScreen(
      {Key? key, required this.isEdit, required this.stationIrrigationType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text[chosenLanguage]!['Device Setup']!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocConsumer<IrrigationTypeCubit, IrrigationTypesStates>(
              listener: (context, state) {
                IrrigationTypeCubit myCubit = IrrigationTypeCubit.get(context);
                if (state is IrrigationTypeSendSuccessState) {
                  if (myCubit.accordingToHour == true &&
                      myCubit.accordingToQuantity == false) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DurationSettingsByHourScreen(
                            isEdit: isEdit,
                            irrigationType: stationIrrigationType,
                          ),
                        ));
                  } else if (myCubit.accordingToHour == true &&
                      myCubit.accordingToQuantity == true) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TimeAmountScreen(
                            isEdit: isEdit,
                            irrigationType: stationIrrigationType,
                          ),
                        ));
                  } else if (myCubit.accordingToHour == false &&
                      myCubit.accordingToQuantity == false) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DurationSettingsByPeriodScreen(
                            isEdit: isEdit,
                            irrigationType: stationIrrigationType,
                          ),
                        ));
                  } else if (myCubit.accordingToHour == false &&
                      myCubit.accordingToQuantity == true) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PeriodAmountScreen(
                            isEdit: isEdit,
                            irrigationType: stationIrrigationType,
                          ),
                        ));
                  }
                } else if (state is IrrigationTypeSendFailState) {
                  errorToast('An error has occurred');
                }
              },
              builder: (context, state) {
                IrrigationTypeCubit myCubit = IrrigationTypeCubit.get(context);
                return MainCard2(
                    function: () {
                      if (myCubit.accordingToHour == null ||
                          myCubit.accordingToQuantity == null) {
                        errorToast("Please select both categories");
                      } else {
                        myCubit.putIrrigationType(
                            activeValves: binaryValves,
                            irrigationType: myCubit.irrigationType,
                            irrigationMethod1: myCubit.irrigationMethod1!,
                            irrigationMethod2: myCubit.irrigationMethod2!);
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
                            secondButtonColor: myCubit.accordingToHour == false
                                ? selectedColor
                                : Colors.white),
                        DurationSettingsRow(
                            firstButtonTitle:
                                text[chosenLanguage]!['Watering duration']!,
                            secondButtonTitle:
                                text[chosenLanguage]!['According to quantity']!,
                            firstButtonIcon: Center(
                                child: Text(
                              'v',
                              style: mainIcon,
                            )),
                            secondButtonIcon: Center(
                                child: Text(
                              'c',
                              style: mainIcon,
                            )),
                            firstButtonFunction: () {
                              myCubit.chooseAccordingToTime();
                            },
                            secondButtonFunction: () {
                              myCubit.chooseAccordingToQuantity();
                            },
                            firstButtonColor:
                                myCubit.accordingToQuantity == false
                                    ? selectedColor
                                    : Colors.white,
                            secondButtonColor:
                                myCubit.accordingToQuantity == true
                                    ? selectedColor
                                    : Colors.white),
                      ],
                    ),
                    rowWidget: Row(
                      children: [
                        Text(
                          stationIrrigationType == 1 ? 'r' : 't',
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
                    cardtitle: text[chosenLanguage]!['Duration settings']!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
