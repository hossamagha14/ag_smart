import 'package:ag_smart/View%20Model/bloc/Custom%20Irrigation/custom_irrigation_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Custom%20Irrigation/custom_irrigation_states.dart';
import 'package:ag_smart/View/Reusable/duration_settings_row.dart';
import 'package:ag_smart/View/Reusable/error_toast.dart';
import 'package:ag_smart/View/Reusable/global.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Reusable/text_style.dart';
import 'package:ag_smart/View/Screens/custom_duration_settings_period.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Reusable/colors.dart';
import '../Reusable/main_icons_row_widget.dart';
import 'custom_duration_by_time.dart';

class CustomDurationSettingsScreen extends StatelessWidget {
  final int lineIndex;
  const CustomDurationSettingsScreen({Key? key, required this.lineIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text[chosenLanguage]!['Device Setup']!),
      ),
      body: BlocConsumer<CustomIrrigationCubit, CustomIrrigationStates>(
        listener: (context, state) {
          CustomIrrigationCubit myCubit = CustomIrrigationCubit.get(context);
          if (state is CustomIrrigationGetSuccessState) {
            if (myCubit.customIrrigationModelList[lineIndex].accordingToHour ==
                true) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomDurationByTime(
                      lineIndex: lineIndex,
                    ),
                  ));
            } else if (myCubit
                    .customIrrigationModelList[lineIndex].accordingToHour ==
                false) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomDurationSettingsByPeriodScreen(
                      lineIndex: lineIndex,
                    ),
                  ));
            }
          } else if (state is CustomIrrigationPutFailState) {
            errorToast('An error has occured');
          }
        },
        builder: (context, state) {
          CustomIrrigationCubit myCubit = CustomIrrigationCubit.get(context);
          return Column(
            children: [
              MainCard2(
                  function: () {
                    if (myCubit.customIrrigationModelList[lineIndex]
                                .accordingToHour ==
                            null ||
                        myCubit.customIrrigationModelList[lineIndex]
                                .accordingToQuantity ==
                            null) {
                      errorToast('Please select both categories');
                    } else {
                      myCubit.putIrrigationSettings(
                          activeValves: binaryValves,
                          irrigationMethod1: myCubit.irrigationMethod1!,
                          irrigationMethod2: myCubit.irrigationMethod1!,
                          lineIndex: lineIndex,
                          valveId: lineIndex + 1,
                          deleteIrrigationMethod1: myCubit.irrigationMethod1!,
                          deleteIrrigationMethod2: myCubit.irrigationMethod1!,
                          stationId: 1);
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
                            myCubit.chooseAccordingToHour(lineIndex);
                          },
                          secondButtonFunction: () {
                            myCubit.chooseAccordingToPeriod(lineIndex);
                          },
                          firstButtonColor: myCubit
                                      .customIrrigationModelList[lineIndex]
                                      .accordingToHour ==
                                  true
                              ? selectedColor
                              : Colors.white,
                          secondButtonColor: myCubit
                                      .customIrrigationModelList[lineIndex]
                                      .accordingToHour ==
                                  false
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
                            myCubit.chooseAccordingToTime(lineIndex);
                          },
                          secondButtonFunction: () {
                            myCubit.chooseAccordingToQuantity(lineIndex);
                          },
                          firstButtonColor: myCubit
                                      .customIrrigationModelList[lineIndex]
                                      .accordingToQuantity ==
                                  false
                              ? selectedColor
                              : Colors.white,
                          secondButtonColor: myCubit
                                      .customIrrigationModelList[lineIndex]
                                      .accordingToQuantity ==
                                  true
                              ? selectedColor
                              : Colors.white),
                    ],
                  ),
                  rowWidget: const MainIconsRowWidget(
                    icon1: 'm',
                    icon2: 'f',
                  ),
                  cardtitle: 'Line ${lineIndex + 1}'),
            ],
          );
        },
      ),
    );
  }
}
