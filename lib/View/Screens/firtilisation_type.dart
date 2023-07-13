import 'package:ag_smart/View%20Model/bloc/Firtiliser%20settings/firtiliser_settings_states.dart';
import 'package:ag_smart/View%20Model/bloc/Firtiliser%20settings/firtiliser_settings_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/commom_states.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/duration_settings_row.dart';
import 'package:ag_smart/View/Reusable/toasts.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Reusable/text_style.dart';
import 'package:ag_smart/View/Screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../View Model/Repo/auth_bloc.dart';
import 'fertiliser_settings.dart';

class FirtilisationTypeScreen extends StatefulWidget {
  final int flowMeter;
  final int currentIndexF1;
  final int currentIndexF2;
  const FirtilisationTypeScreen(
      {Key? key,
      required this.flowMeter,
      required this.currentIndexF2,
      required this.currentIndexF1})
      : super(key: key);

  @override
  State<FirtilisationTypeScreen> createState() =>
      _FirtilisationTypeScreenState();
}

class _FirtilisationTypeScreenState extends State<FirtilisationTypeScreen> {
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
      body: SafeArea(
        child: Column(
          children: [
            BlocConsumer<FirtiliserSettingsCubit, CommonStates>(
              listener: (context, state) {
                if (state is FirtiliserSettingsSendFailState) {
                  errorToast(context,'An error has occurred');
                } else if (state is FirtiliserSettingsGetSuccessState) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FirtiliserSettingsScreen(
                            currentIndexF1: widget.currentIndexF1,
                            currentIndexF2: widget.currentIndexF2,
                            flowMeter: widget.flowMeter),
                      ));
                }
              },
              builder: (context, state) {
                FirtiliserSettingsCubit myCubit =
                    FirtiliserSettingsCubit.get(context);
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
                      mainWidget: Column(
                        children: [
                          DurationSettingsRow(
                              firstButtonTitle: text[chosenLanguage]![
                                  'Parallel Fertilization']!,
                              secondButtonTitle: text[chosenLanguage]![
                                  'Series Fertilization']!,
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
                              secondButtonTitle: text[chosenLanguage]![
                                  'According to quantity']!,
                              firstButtonIcon: Center(
                                child: Text(
                                  'g',
                                  style: yellowIcon,
                                ),
                              ),
                              secondButtonIcon: Center(
                                child: Text(
                                  'h',
                                  style: TextStyle(
                                      fontFamily: 'icons',
                                      color: widget.flowMeter == 2
                                          ? yellowColor
                                          : disabled,
                                      fontSize: 30),
                                ),
                              ),
                              firstButtonFunction: () {
                                myCubit.firtiliseAccordingToTime();
                              },
                              secondButtonFunction: () {
                                if (widget.flowMeter == 2) {
                                  myCubit.firtiliseAccordingToQuantity();
                                } else {
                                  errorToast(context,text[chosenLanguage]![
                                      'You are not subscribed for this feature']!);
                                }
                              },
                              firstButtonColor: myCubit.accordingToTime == true
                                  ? selectedColor
                                  : Colors.white,
                              secondButtonColor: widget.flowMeter != 2
                                  ? disabledBackground
                                  : myCubit.accordingToTime == false
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
                          errorToast(context,'Please select firtilisation type');
                        } else if (widget.currentIndexF1 == myCubit.method1 &&
                            widget.currentIndexF2 == myCubit.method2) {
                          myCubit.getPeriods();
                        } else {
                          myCubit.putFertilizationSettings(
                              ferMethod1: myCubit.method1!,
                              ferMethod2: myCubit.method2!);
                        }
                      },
                      cardtitle: text[chosenLanguage]!['Fertilizer Settings']!,
                      buttonColor: yellowColor),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
