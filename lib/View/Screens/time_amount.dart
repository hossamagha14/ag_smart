import 'package:ag_smart/View%20Model/bloc/Duration%20settings/duration_settings_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Duration%20settings/duration_settings_states.dart';
import 'package:ag_smart/View/Reusable/add_new_container_button.dart';
import 'package:ag_smart/View/Reusable/choose_days_widget.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/main_icons_row_widget.dart';
import 'package:ag_smart/View/Reusable/my_time_picker.dart';
import 'package:ag_smart/View/Reusable/open_valve_period_text_field.dart';
import 'package:ag_smart/View/Reusable/set_settings_2rows_container.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Screens/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Reusable/toasts.dart';

// ignore: must_be_immutable
class TimeAmountScreen extends StatelessWidget {
  final bool isEdit;
  const TimeAmountScreen({Key? key, required this.isEdit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text[chosenLanguage]!['Device Setup']!),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
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
                    errorToast('An error has occured');
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
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    SetSettings2RowsContainer(
                                      visible: myCubit.visible,
                                      function: () {
                                        myCubit.removeContainerFromdb(
                                            containerIndex: index,
                                            stationId: stationId,
                                            valveId: 0,
                                            weekday: myCubit.toDecimal(),
                                            periodId: myCubit.durationModel.controller.length);
                                      },
                                      firstRowTitle:
                                          text[chosenLanguage]!['Set time']!,
                                      firstRowWidget: MyTimePicker(
                                          time: myCubit
                                              .durationModel.time[index]
                                              .format(context)
                                              .toString(),
                                          function: (value) =>
                                              myCubit.pickTime(value, index)),
                                      secondRowTitle: text[chosenLanguage]![
                                          'Amount of water']!,
                                      secondRowWidget: OpenValvePeriodTextField(
                                          control: myCubit
                                              .durationModel.controller[index],
                                          hintText: '00',
                                          unit: text[chosenLanguage]!['ml']!),
                                    ),
                                separatorBuilder: (context, index) => SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                itemCount:
                                    myCubit.durationModel.controller.length),
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
                      rowWidget: const MainIconsRowWidget(
                        icon1: 'm',
                        icon2: 'r',
                        icon3: 'u',
                        icon4: 'c',
                      ),
                      function: () {
                        bool allFull = true;
                        for (int i = 0;
                            i < myCubit.durationModel.controller.length;
                            i++) {
                          if (myCubit
                              .durationModel.controller[i].text.isEmpty) {
                            allFull = false;
                          }
                        }
                        if (myCubit.noDayIsChosen == 7) {
                          errorToast('Please choose the days of work');
                        }
                        if (allFull == true) {
                          myCubit.putIrrigationHourList(
                              stationId: 1,
                              periodsList: myCubit.makeAList(
                                  weekday: myCubit.toDecimal()));
                        } else {
                          errorToast('Please add the open valve time');
                        }
                      },
                      cardtitle: text[chosenLanguage]!['Duration settings']!,
                      buttonColor: greenButtonColor);
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}