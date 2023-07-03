import 'package:ag_smart/View%20Model/bloc/Bottom%20navigation%20bar/bottom_nav_bar_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Firtiliser%20settings/firtiliser_settings_cubit.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/firtilisers_scarcrow_light_widget.dart';
import 'package:ag_smart/View/Reusable/get_choosen_days.dart';
import 'package:ag_smart/View/Reusable/main_card.dart';
import 'package:ag_smart/View/Reusable/main_icons_row_widget.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Reusable/text_style.dart';
import 'package:ag_smart/View/Reusable/toasts.dart';
import 'package:ag_smart/View/Screens/duration_settings.dart';
import 'package:ag_smart/View/Screens/light.dart';
import 'package:ag_smart/View/Screens/period_amount.dart';
import 'package:ag_smart/View/Screens/scarecrow.dart';
import 'package:ag_smart/View/Screens/time_amount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../View Model/bloc/commom_states.dart';
import 'duration_settings_by_period.dart';
import 'duration_settings_hours.dart';
import 'fertiliser_settings.dart';
import 'firtilisation_type.dart';

class StationInfoScreen extends StatelessWidget {
  const StationInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<BottomNavBarCubit, CommonStates>(
            listener: (context, state) {},
            builder: (context, state) {
              BottomNavBarCubit myCubit = BottomNavBarCubit.get(context);
              return myCubit.stationModel == null
                  ? const Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          MainCard(
                            function: () {
                              if (myCubit.stationModel!.irrigationSettings![0]
                                      .irrigationCycles!.isEmpty &&
                                  myCubit.stationModel!.irrigationSettings![0]
                                      .irrigationPeriods!.isEmpty) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DurationSettingsScreen(
                                        pressureSwitch: myCubit.stationModel!
                                            .pumpSettings![0].pressureSwitch!,
                                        pressure: myCubit.stationModel!
                                            .features![0].pressure!,
                                        flowMeter: myCubit.stationModel!
                                            .features![0].flowMeter!,
                                        isEdit: true,
                                        stationIrrigationType: myCubit
                                            .stationModel!
                                            .irrigationSettings![0]
                                            .settingsType!,
                                      ),
                                    ));
                              } else if (myCubit
                                          .stationModel!
                                          .irrigationSettings![0]
                                          .irrigationMethod1 ==
                                      1 &&
                                  myCubit.stationModel!.irrigationSettings![0]
                                          .irrigationMethod2 ==
                                      1) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DurationSettingsByPeriodScreen(
                                              pressureSwitch: myCubit
                                                  .stationModel!
                                                  .pumpSettings![0]
                                                  .pressureSwitch!,
                                              pressure: myCubit.stationModel!
                                                  .features![0].pressure!,
                                              flowMeter: myCubit.stationModel!
                                                  .features![0].flowMeter!,
                                              isEdit: true,
                                              irrigationType: myCubit
                                                  .stationModel!
                                                  .irrigationSettings![0]
                                                  .settingsType!),
                                    ));
                              } else if (myCubit
                                          .stationModel!
                                          .irrigationSettings![0]
                                          .irrigationMethod1 ==
                                      1 &&
                                  myCubit.stationModel!.irrigationSettings![0]
                                          .irrigationMethod2 ==
                                      2) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PeriodAmountScreen(
                                          pressureSwitch: myCubit.stationModel!
                                              .pumpSettings![0].pressureSwitch!,
                                          pressure: myCubit.stationModel!
                                              .features![0].pressure!,
                                          flowMeter: myCubit.stationModel!
                                              .features![0].flowMeter!,
                                          isEdit: true,
                                          irrigationType: myCubit
                                              .stationModel!
                                              .irrigationSettings![0]
                                              .settingsType!),
                                    ));
                              } else if (myCubit
                                          .stationModel!
                                          .irrigationSettings![0]
                                          .irrigationMethod1 ==
                                      2 &&
                                  myCubit.stationModel!.irrigationSettings![0]
                                          .irrigationMethod2 ==
                                      2) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TimeAmountScreen(
                                          pressureSwitch: myCubit.stationModel!
                                              .pumpSettings![0].pressureSwitch!,
                                          pressure: myCubit.stationModel!
                                              .features![0].pressure!,
                                          flowMeter: myCubit.stationModel!
                                              .features![0].flowMeter!,
                                          isEdit: true,
                                          irrigationType: myCubit
                                              .stationModel!
                                              .irrigationSettings![0]
                                              .settingsType!),
                                    ));
                              } else if (myCubit
                                          .stationModel!
                                          .irrigationSettings![0]
                                          .irrigationMethod1 ==
                                      2 &&
                                  myCubit.stationModel!.irrigationSettings![0]
                                          .irrigationMethod2 ==
                                      1) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DurationSettingsByHourScreen(
                                              pressureSwitch: myCubit
                                                  .stationModel!
                                                  .pumpSettings![0]
                                                  .pressureSwitch!,
                                              pressure: myCubit.stationModel!
                                                  .features![0].pressure!,
                                              flowMeter: myCubit.stationModel!
                                                  .features![0].flowMeter!,
                                              isEdit: true,
                                              irrigationType: myCubit
                                                  .stationModel!
                                                  .irrigationSettings![0]
                                                  .settingsType!),
                                    ));
                              }
                            },
                            mainWidget: Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                const GetChooseDyasWidget(),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.36,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: ListView.separated(
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Visibility(
                                            visible:
                                                myCubit.activeValves[index] == 0
                                                    ? false
                                                    : true,
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.05,
                                              decoration: BoxDecoration(
                                                  color: backgroundColor,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '${text[chosenLanguage]!['line']!} ${index + 1}',
                                                      textDirection:
                                                          chosenLanguage == 'ar'
                                                              ? TextDirection
                                                                  .rtl
                                                              : TextDirection
                                                                  .ltr,
                                                    ),
                                                    const Spacer()
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return Visibility(
                                            visible:
                                                myCubit.activeValves[index] == 0
                                                    ? false
                                                    : true,
                                            child: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01,
                                            ),
                                          );
                                        },
                                        itemCount:
                                            myCubit.activeValves.length)),
                                BlocConsumer<FirtiliserSettingsCubit,
                                    CommonStates>(
                                  listener: (context, state) {},
                                  builder: (context, state) {
                                    FirtiliserSettingsCubit ferCubit =
                                        FirtiliserSettingsCubit.get(context);
                                    return FirScarLightWidget(
                                      ferFunction: () {
                                        if (myCubit.stationModel!.features![0]
                                                .fertilizer ==
                                            1) {
                                          errorToast(text[chosenLanguage]![
                                              'You are not subscribed for this feature']!);
                                        } else if (myCubit.stationModel!
                                            .fertilizationSettings!.isEmpty) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    FirtilisationTypeScreen(
                                                        flowMeter: myCubit
                                                            .stationModel!
                                                            .features![0]
                                                            .flowMeter!),
                                              ));
                                        } else {
                                          ferCubit.getPeriods();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    FirtiliserSettingsScreen(
                                                        flowMeter: myCubit
                                                            .stationModel!
                                                            .features![0]
                                                            .flowMeter!),
                                              ));
                                        }
                                      },
                                      lightFunction: () {
                                        if (myCubit.stationModel!.features![0]
                                                .light ==
                                            1) {
                                          errorToast(text[chosenLanguage]![
                                              'You are not subscribed for this feature']!);
                                        } else {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const LightScreen(),
                                              ));
                                        }
                                      },
                                      scarFunction: () {
                                        if (myCubit.stationModel!.features![0]
                                                .animal ==
                                            1) {
                                          errorToast(text[chosenLanguage]![
                                              'You are not subscribed for this feature']!);
                                        } else {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const ScarecrowScreen(),
                                              ));
                                        }
                                      },
                                      ferColor: myCubit.stationModel!
                                                  .features![0].fertilizer ==
                                              2
                                          ? lightSelectedColor
                                          : Colors.white,
                                      scarColor: myCubit.stationModel!
                                                  .features![0].animal ==
                                              2
                                          ? lightSelectedColor
                                          : Colors.white,
                                      ligColor: myCubit.stationModel!
                                                  .features![0].light ==
                                              2
                                          ? lightSelectedColor
                                          : Colors.white,
                                      fericon: myCubit.stationModel!
                                                  .features![0].fertilizer ==
                                              2
                                          ? smallIconOn
                                          : smallIconOff,
                                      scaricon: myCubit.stationModel!
                                                  .features![0].animal ==
                                              2
                                          ? smallIconOn
                                          : smallIconOff,
                                      ligicon: myCubit.stationModel!
                                                  .features![0].light ==
                                              2
                                          ? smallIconOn
                                          : smallIconOff,
                                    );
                                  },
                                )
                              ],
                            ),
                            rowWidget: MainIconsRowWidget(
                              icon1: 'm',
                              icon2: myCubit
                                          .stationModel!
                                          .irrigationSettings![0]
                                          .settingsType ==
                                      1
                                  ? 'r'
                                  : 't',
                              icon3: myCubit
                                          .stationModel!
                                          .irrigationSettings![0]
                                          .irrigationMethod1 ==
                                      2
                                  ? 'u'
                                  : 'w',
                              icon4: myCubit
                                          .stationModel!
                                          .irrigationSettings![0]
                                          .irrigationMethod2 ==
                                      1
                                  ? 'x'
                                  : 'c',
                            ),
                            buttonColor: settingsColor,
                            buttonTitle:
                                text[chosenLanguage]!['Line Settings']!,
                            buttonIcon: const Text(
                              'q',
                              style:
                                  TextStyle(fontFamily: 'icons', fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                    );
            }),
      ),
    );
  }
}
