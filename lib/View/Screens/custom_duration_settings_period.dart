import 'package:ag_smart/View%20Model/bloc/Custom%20Irrigation/custom_irrigation_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Custom%20Irrigation/custom_irrigation_states.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/custom_irrigation_choose_day.dart';
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
class CustomDurationSettingsByPeriodScreen extends StatelessWidget {
  final int lineIndex;
  CustomDurationSettingsByPeriodScreen({Key? key, required this.lineIndex})
      : super(key: key);
  TextEditingController hourControl = TextEditingController();
  TextEditingController minutesControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            children: [
              BlocConsumer<CustomIrrigationCubit, CustomIrrigationStates>(
                listener: (context, state) {
                  if (state is CustomIrrigationPutSuccessState) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BottomNavBarScreen(),
                        ),
                        (route) => false);
                  } else if (state is CustomIrrigationPutFailState) {
                    errorToast('An error has occured');
                  }
                },
                builder: (context, state) {
                  CustomIrrigationCubit myCubit =
                      CustomIrrigationCubit.get(context);
                  return MainCard2(
                      mainWidget: Column(children: [
                        CustomIrrigationChooseDyasWidget(
                          lineIndex: lineIndex,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        SetSettings2RowsContainer(
                            visible: false,
                            function: () {},
                            firstRowTitle: text[chosenLanguage]!['Each cycle']!,
                            firstRowWidget: OpenValvePeriodTextField(
                                control: hourControl,
                                hintText: '00',
                                unit: text[chosenLanguage]!['Hours']!),
                            secondRowTitle: myCubit
                                        .customIrrigationModelList[lineIndex]
                                        .accordingToQuantity ==
                                    false
                                ? text[chosenLanguage]!['Open valve time']!
                                : text[chosenLanguage]!['Amount of water']!,
                            secondRowWidget: OpenValvePeriodTextField(
                                control: minutesControl,
                                hintText: '00',
                                unit:
                                    myCubit.customIrrigationModelList[lineIndex]
                                                .accordingToQuantity ==
                                            false
                                        ? text[chosenLanguage]!['Minutes']!
                                        : text[chosenLanguage]!['ml']!))
                      ]),
                      rowWidget: MainIconsRowWidget(
                        icon1: 'm',
                        icon2: 'f',
                        icon3: 'w',
                        icon4: myCubit.customIrrigationModelList[lineIndex]
                                    .accordingToQuantity ==
                                false
                            ? 'x'
                            : 'c',
                      ),
                      function: () {
                        if (myCubit.customIrrigationModelList[lineIndex]
                                .noDayIsChosen ==
                            7) {
                          errorToast('Please choose the days of work');
                        } else if (hourControl.text.isEmpty ||
                            minutesControl.text.isEmpty) {
                          errorToast(myCubit
                                      .customIrrigationModelList[lineIndex]
                                      .accordingToQuantity ==
                                  false
                              ? 'Please add the open valve time'
                              : 'Please add the amount of water needed');
                        } else {
                          myCubit.putIrrigationCycle(
                              interval: int.parse(hourControl.text),
                              valveId: lineIndex + 1,
                              duration: myCubit
                                          .customIrrigationModelList[lineIndex]
                                          .accordingToQuantity ==
                                      false
                                  ? int.parse(minutesControl.text)
                                  : 0,
                              quantity: myCubit
                                          .customIrrigationModelList[lineIndex]
                                          .accordingToQuantity ==
                                      true
                                  ? int.parse(minutesControl.text)
                                  : 0,
                              weekDays: 9);
                        }
                      },
                      cardtitle: text[chosenLanguage]!['Duration settings']!,
                      buttonColor: greenButtonColor);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
