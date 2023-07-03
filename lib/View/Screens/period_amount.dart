import 'package:ag_smart/View%20Model/bloc/Duration%20settings/duration_settings_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Duration%20settings/duration_settings_states.dart';
import 'package:ag_smart/View%20Model/bloc/commom_states.dart';
import 'package:ag_smart/View/Reusable/choose_days_widget.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/toasts.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/main_icons_row_widget.dart';
import 'package:ag_smart/View/Reusable/open_valve_period_text_field.dart';
import 'package:ag_smart/View/Reusable/set_settings_2rows_container.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../View Model/Repo/auth_bloc.dart';
import 'bottom_nav_bar.dart';
import 'duration_settings.dart';

// ignore: must_be_immutable
class PeriodAmountScreen extends StatefulWidget {
  final bool isEdit;
  final int irrigationType;
  final int flowMeter;
  final int pressure;
  final int pressureSwitch;
  const PeriodAmountScreen(
      {Key? key, required this.isEdit, required this.irrigationType,required this.flowMeter,required this.pressure,required this.pressureSwitch})
      : super(key: key);

  @override
  State<PeriodAmountScreen> createState() => _PeriodAmountScreenState();
}

class _PeriodAmountScreenState extends State<PeriodAmountScreen> {
  TextEditingController hoursControl = TextEditingController();
  TextEditingController mlControl = TextEditingController();
  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, CommonStates>(
      listener: (context, state) {
        if (state is ExpiredTokenState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => SignInScreen(),
              ),
              (route) => false);
          expiredTokenToast();
        }
        if (state is ServerDownState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => SignInScreen(),
              ),
              (route) => false);
          serverDownToast();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(text[chosenLanguage]!['Line Settings']!),
        ),
        body: SafeArea(
          child: BlocProvider(
            create: (context) => DurationSettingsCubit(authBloc)
              ..getCycle(hours: hoursControl, amount: mlControl),
            child: BlocConsumer<DurationSettingsCubit, CommonStates>(
              listener: (context, state) {
                if (state is DurationSettingsSendSuccessState) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNavBarScreen(),
                      ),
                      (route) => false);
                } else if (state is DurationSettingsSendFailedState) {
                  errorToast('An error has occurred');
                }
              },
              builder: (context, state) {
                DurationSettingsCubit myCubit =
                    DurationSettingsCubit.get(context);
                return state is DurationSettingsLoadingState ||
                        myCubit.irrigationSettingsModel == null
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      )
                    : SingleChildScrollView(
                        child: SizedBox(
                            width: MediaQuery.of(context).size.height * 0.8,
                            child: Column(
                              children: [
                                MainCard2(
                                    editButton: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DurationSettingsScreen(
                                                    pressureSwitch: widget.pressureSwitch,
                                                    pressure: widget.pressure,
                                                    flowMeter: widget.flowMeter,
                                                isEdit: true,
                                                stationIrrigationType:
                                                    widget.irrigationType,
                                              ),
                                            ));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width *
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
                                    mainWidget: Column(
                                      children: [
                                        const ChooseDyasWidget(
                                          useFunction: true,
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                        ),
                                        SetSettings2RowsContainer(
                                          visible: false,
                                          function: () {},
                                          firstRowTitle: text[chosenLanguage]![
                                              'Each cycle']!,
                                          firstRowWidget:
                                              OpenValvePeriodTextField(
                                                  control: hoursControl,
                                                  hintText: '00',
                                                  unit: text[chosenLanguage]![
                                                      'Hours']!),
                                          secondRowTitle: text[chosenLanguage]![
                                              'Amount of water']!,
                                          secondRowWidget:
                                              OpenValvePeriodTextField(
                                                  control: mlControl,
                                                  hintText: '00',
                                                  unit: text[chosenLanguage]![
                                                      'ml']!),
                                        ),
                                      ],
                                    ),
                                    rowWidget: MainIconsRowWidget(
                                      icon1: 'm',
                                      icon2: widget.irrigationType == 1
                                          ? 'r'
                                          : 't',
                                      icon3: 'w',
                                      icon4: 'c',
                                    ),
                                    function: () {
                                      if (hoursControl.text.isEmpty ||
                                          mlControl.text.isEmpty) {
                                        errorToast(
                                            'Please fill both categories');
                                      } else {
                                        if (myCubit.noDayIsChosen == 7) {
                                          errorToast(
                                              'Please choose the days of work');
                                        } else if (double.parse(
                                                hoursControl.text) >
                                            24) {
                                          errorToast(text[chosenLanguage]![
                                              'The cycle can\'t be more than 24 hours']!);
                                        } else {
                                          myCubit.putIrrigationCycle(
                                              valveId: 0,
                                              interval:
                                                  int.parse(hoursControl.text),
                                              duration: 0,
                                              quantity:
                                                  int.parse(mlControl.text),
                                              weekDays: myCubit.toDecimal());
                                        }
                                      }
                                    },
                                    cardtitle: text[chosenLanguage]![
                                        'Duration settings']!,
                                    buttonColor: greenButtonColor)
                              ],
                            )),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
