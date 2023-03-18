import 'package:ag_smart/View%20Model/bloc/Bottom%20navigation%20bar/bottom_nav_bar_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Bottom%20navigation%20bar/bottom_nav_bar_states.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/main_card.dart';
import 'package:ag_smart/View/Reusable/main_icons_row_widget.dart';
import 'package:ag_smart/View/Reusable/pop_screen.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Reusable/text_style.dart';
import 'package:ag_smart/View/Screens/edit_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Reusable/scare_light.dart';

class CustomStationInfoScreen extends StatelessWidget {
  const CustomStationInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text[chosenLanguage]!['Station info']!),
      ),
      body: BlocConsumer<BottomNavBarCubit, BottomNavBarStates>(
        listener: (context, state) {},
        builder: (context, state) {
          BottomNavBarCubit myCubit = BottomNavBarCubit.get(context);
          return Column(
            children: [
              MainCard(
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditSettingsScreen(),
                      ));
                },
                mainWidget: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.19,
                          ),
                          const Text('S'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          const Text('S'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          const Text('M'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          const Text('T'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          const Text('W'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          const Text('T'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          const Text('F'),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.005,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.41,
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, lineIndex) {
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                decoration: BoxDecoration(
                                    color: backgroundColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.01,
                                    ),
                                    Text(
                                        'Line ${myCubit.stationModel!.irrigationSettings![0].customValvesSettings![lineIndex].valveId.toString()}'),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            print(myCubit.customActiveDays);
                                            return CircleAvatar(
                                              radius: 7,
                                              backgroundColor: myCubit
                                                          .customActiveDays[
                                                              lineIndex]
                                                          .isEmpty ||
                                                      myCubit.customActiveDays[
                                                                  lineIndex]
                                                              [index] ==
                                                          0
                                                  ? Colors.grey
                                                  : Colors.green,
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.02,
                                            );
                                          },
                                          itemCount: 7),
                                    ),
                                    myCubit
                                                .stationModel!
                                                .irrigationSettings![0]
                                                .customValvesSettings![
                                                    lineIndex]
                                                .irrigationMethod2 ==
                                            1
                                        ? Text(
                                            'x',
                                            style: smallIcon,
                                          )
                                        : myCubit
                                                    .stationModel!
                                                    .irrigationSettings![0]
                                                    .customValvesSettings![
                                                        lineIndex]
                                                    .irrigationMethod2 ==
                                                2
                                            ? Text(
                                                'c',
                                                style: smallIcon,
                                              )
                                            : const SizedBox(
                                                width: 18,
                                              ),
                                    myCubit
                                                .stationModel!
                                                .irrigationSettings![0]
                                                .customValvesSettings!
                                                .isEmpty ||
                                            myCubit
                                                    .stationModel!
                                                    .irrigationSettings![0]
                                                    .customValvesSettings![
                                                        lineIndex]
                                                    .irrigationMethod1 ==
                                                0
                                        ? const SizedBox(
                                            width: 18,
                                          )
                                        : Text(
                                            myCubit
                                                        .stationModel!
                                                        .irrigationSettings![0]
                                                        .customValvesSettings![
                                                            lineIndex]
                                                        .irrigationMethod1 ==
                                                    2
                                                ? 'u'
                                                : 'w',
                                            style: smallIcon,
                                          ),
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      0,
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.05,
                                                      0,
                                                      0),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              content: PopUpScreen(
                                                lineIndex: lineIndex,
                                                valveId: myCubit
                                                    .stationModel!
                                                    .irrigationSettings![0]
                                                    .customValvesSettings![
                                                        lineIndex]
                                                    .valveId!,
                                              )),
                                        );
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                        decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(0.6),
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10))),
                                        child: Center(
                                          child: Text(
                                            'q',
                                            style: smallIcon,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              );
                            },
                            itemCount: myCubit
                                .stationModel!
                                .irrigationSettings![0]
                                .customValvesSettings!
                                .length),
                      ),
                      const Spacer(),
                      const ScarLightWidget()
                    ],
                  ),
                ),
                rowWidget: const MainIconsRowWidget(
                  icon1: 'm',
                  icon2: 'f',
                ),
                buttonColor: settingsColor,
                buttonTitle: text[chosenLanguage]!['Settings']!,
                buttonIcon: const Text(
                  'q',
                  style: TextStyle(fontFamily: 'icons', fontSize: 25),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
