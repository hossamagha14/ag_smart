import 'package:ag_smart/View%20Model/bloc/Firtiliser%20settings/firtiliser_settings_states.dart';
import 'package:ag_smart/View%20Model/bloc/Firtiliser%20settings/firtilisers_settings_cubit.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/duration_settings_row.dart';
import 'package:ag_smart/View/Reusable/error_toast.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Reusable/text_style.dart';
import 'package:ag_smart/View/Screens/fertiliser_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirtilisationTypeScreen extends StatelessWidget {
  const FirtilisationTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text[chosenLanguage]!['Device Setup']!),
      ),
      body: SafeArea(
        child: Column(
          children: [
            BlocConsumer<FirtiliserSettingsCubit, FirtiliserSettingsStates>(
              listener: (context, state) {
                if (state is FirtiliserSettingsGetSuccessState) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FirtiliserSettingsScreen(),
                      ));
                } else if (state is FirtiliserSettingsSendFailState) {
                  errorToast('An error has occurred');
                }
              },
              builder: (context, state) {
                FirtiliserSettingsCubit myCubit =
                    FirtiliserSettingsCubit.get(context);
                return MainCard2(
                    mainWidget: Column(
                      children: [
                        DurationSettingsRow(
                            firstButtonTitle: text[chosenLanguage]![
                                'Parallel Fertilization']!,
                            secondButtonTitle:
                                text[chosenLanguage]!['Series Fertilization']!,
                            firstButtonIcon: Center(
                              child: Text(
                                'B',
                                style: yellowIcon,
                              ),
                            ),
                            secondButtonIcon: Center(
                              child: Text(
                                'C',
                                style: yellowIcon,
                              ),
                            ),
                            firstButtonFunction: () {
                              myCubit.chooseParallelFertilization();
                            },
                            secondButtonFunction: () {
                              myCubit.chooseSeriesFertilization();
                            },
                            firstButtonColor:
                                myCubit.seriesFertilization == false
                                    ? selectedColor
                                    : Colors.white,
                            secondButtonColor:
                                myCubit.seriesFertilization == true
                                    ? selectedColor
                                    : Colors.white),
                        DurationSettingsRow(
                            firstButtonTitle:
                                text[chosenLanguage]!['According to time']!,
                            secondButtonTitle:
                                text[chosenLanguage]!['According to quantity']!,
                            firstButtonIcon: Center(
                              child: Text(
                                'g',
                                style: yellowIcon,
                              ),
                            ),
                            secondButtonIcon: Center(
                              child: Text(
                                'h',
                                style: yellowIcon,
                              ),
                            ),
                            firstButtonFunction: () {
                              myCubit.firtiliseAccordingToTime();
                            },
                            secondButtonFunction: () {
                              myCubit.firtiliseAccordingToQuantity();
                            },
                            firstButtonColor: myCubit.accordingToTime == true
                                ? selectedColor
                                : Colors.white,
                            secondButtonColor: myCubit.accordingToTime == false
                                ? selectedColor
                                : Colors.white),
                      ],
                    ),
                    rowWidget: Text(
                      'y',
                      style: yellowIcon,
                    ),
                    function: () {
                      if (myCubit.accordingToTime == null ||
                          myCubit.seriesFertilization == null) {
                        errorToast('Please select firtilisation type');
                      } else {
                        myCubit.putFertilizationSettings(
                            stationId: 1,
                            ferMethod1: myCubit.method1!,
                            ferMethod2: myCubit.method2!);
                            
                      }
                    },
                    cardtitle: text[chosenLanguage]!['Fertilizer Settings']!,
                    buttonColor: yellowColor);
              },
            )
          ],
        ),
      ),
    );
  }
}
