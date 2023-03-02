import 'package:ag_smart/View%20Model/bloc/Custom%20Irrigation/custom_irrigation_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Custom%20Irrigation/custom_irrigation_states.dart';
import 'package:ag_smart/View%20Model/bloc/Lines%20activation/lines_activation_cubit.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/firtilisers_scarcrow_light_widget.dart';
import 'package:ag_smart/View/Reusable/main_card.dart';
import 'package:ag_smart/View/Reusable/main_icons_row_widget.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Reusable/text_style.dart';
import 'package:ag_smart/View/Screens/custom_duration_settings.dart';
import 'package:ag_smart/View/Screens/edit_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../View Model/bloc/Lines activation/lines_activation_states.dart';

class CustomStationInfoScreen extends StatelessWidget {
  const CustomStationInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text[chosenLanguage]!['Station info']!),
      ),
      body: BlocConsumer<CustomIrrigationCubit, CustomIrrigationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          CustomIrrigationCubit myCubit = CustomIrrigationCubit.get(context);
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
                        child: BlocConsumer<LinesActivationCubit,
                                LinesActivationStates>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              LinesActivationCubit activeLineCubit =LinesActivationCubit.get(context);
                              return ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, lineIndex) {
                                    return Visibility(
                                      visible: activeLineCubit.valves[lineIndex].isActive,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width *
                                            0.8,
                                        height: MediaQuery.of(context).size.height*0.05,
                                        decoration: BoxDecoration(
                                            color: backgroundColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.01,
                                            ),
                                            Text('Line ${lineIndex + 1}'),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              child: ListView.separated(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder: (context, index) {
                                                    return CircleAvatar(
                                                      radius: 7,
                                                      backgroundColor: myCubit
                                                                  .customIrrigationModelList[
                                                                      lineIndex]
                                                                  .days[index]
                                                                  .isOn ==
                                                              true
                                                          ? Colors.green
                                                          : Colors.grey,
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.02,
                                                    );
                                                  },
                                                  itemCount: 7),
                                            ),
                                            myCubit
                                                        .customIrrigationModelList[
                                                            lineIndex]
                                                        .accordingToQuantity ==
                                                    null
                                                ? const SizedBox(
                                                    width: 18,
                                                  )
                                                : Text(
                                                    myCubit
                                                                .customIrrigationModelList[
                                                                    lineIndex]
                                                                .accordingToQuantity ==
                                                            true
                                                        ? 'c'
                                                        : 'x',
                                                    style: smallIcon,
                                                  ),
                                            myCubit
                                                        .customIrrigationModelList[
                                                            lineIndex]
                                                        .accordingToHour ==
                                                    null
                                                ? const SizedBox(
                                                    width: 18,
                                                  )
                                                : Text(
                                                    myCubit
                                                                .customIrrigationModelList[
                                                                    lineIndex]
                                                                .accordingToHour ==
                                                            true
                                                        ? 'u'
                                                        : 'w',
                                                    style: smallIcon,
                                                  ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          CustomDurationSettingsScreen(
                                                              lineIndex:
                                                                  lineIndex),
                                                    ));
                                              },
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.05,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue
                                                        .withOpacity(0.6),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10))),
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
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Visibility(
                                      visible: activeLineCubit.valves[index].isActive,
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      ),
                                    );
                                  },
                                  itemCount: activeLineCubit.valves.length);
                            }),
                      ),
                      const Spacer(),
                      const FirScarLightWidget()
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
