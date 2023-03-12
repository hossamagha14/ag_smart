import 'package:ag_smart/View%20Model/bloc/Duration%20settings/duration_settings_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Duration%20settings/duration_settings_states.dart';
import 'package:ag_smart/View/Reusable/choose_days_widget.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/error_toast.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/main_icons_row_widget.dart';
import 'package:ag_smart/View/Reusable/open_valve_period_text_field.dart';
import 'package:ag_smart/View/Reusable/set_settings_2rows_container.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_nav_bar.dart';

// ignore: must_be_immutable
class PeriodAmountScreen extends StatelessWidget {
  final bool isEdit;
  PeriodAmountScreen({Key? key, required this.isEdit}) : super(key: key);
  TextEditingController hoursControl = TextEditingController();
  TextEditingController mlControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text[chosenLanguage]!['Line Settings']!),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
            width: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              children: [
                BlocConsumer<DurationSettingsCubit, DurationSettingsStates>(
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
                    return MainCard2(
                        mainWidget: Column(
                          children: [
                            const ChooseDyasWidget(
                              useFunction: true,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            SetSettings2RowsContainer(
                              visible: false,
                              function: () {},
                              firstRowTitle:
                                  text[chosenLanguage]!['Each cycle']!,
                              firstRowWidget: OpenValvePeriodTextField(
                                  control: hoursControl,
                                  hintText: '00',
                                  unit: text[chosenLanguage]!['Hours']!),
                              secondRowTitle:
                                  text[chosenLanguage]!['Amount of water']!,
                              secondRowWidget: OpenValvePeriodTextField(
                                  control: mlControl,
                                  hintText: '00',
                                  unit: text[chosenLanguage]!['ml']!),
                            ),
                          ],
                        ),
                        rowWidget: const MainIconsRowWidget(
                          icon1: 'm',
                          icon2: 'r',
                          icon3: 'w',
                          icon4: 'c',
                        ),
                        function: () {
                          if (hoursControl.text.isEmpty ||
                              mlControl.text.isEmpty) {
                            errorToast('Please fill both categories');
                          } else {
                            if (myCubit.noDayIsChosen == 7) {
                              errorToast('Please choose the days of work');
                            } else {
                              myCubit.putIrrigationCycle(
                                  valveId: 0,
                                  interval: int.parse(hoursControl.text),
                                  duration: 0,
                                  quantity: int.parse(mlControl.text),
                                  weekDays: myCubit.toBinary());
                            }
                          }
                        },
                        cardtitle: text[chosenLanguage]!['Duration settings']!,
                        buttonColor: greenButtonColor);
                  },
                )
              ],
            )),
      )),
    );
  }
}
