import 'package:ag_smart/View%20Model/bloc/Bottom%20navigation%20bar/bottom_nav_bar_cubit.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/main_card.dart';
import 'package:ag_smart/View/Reusable/main_icons_row_widget.dart';
import 'package:ag_smart/View/Reusable/pop_screen.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Reusable/text_style.dart';
import 'package:ag_smart/View/Screens/scarecrow.dart';
import 'package:ag_smart/View/Screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../View Model/bloc/commom_states.dart';
import '../Reusable/pop_screen2.dart';
import '../Reusable/scare_light.dart';
import '../Reusable/toasts.dart';
import 'light.dart';

class CustomStationInfoScreen extends StatelessWidget {
  const CustomStationInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<BottomNavBarCubit, CommonStates>(
        listener: (context, state) {
          if (state is ExpiredTokenState) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => SignInScreen(),
                ),
                (route) => false);
          }
        },
        builder: (context, state) {
          BottomNavBarCubit myCubit = BottomNavBarCubit.get(context);
          return SingleChildScrollView(
            child: Column(
              children: [
                MainCard(
                  function: () {},
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  decoration: BoxDecoration(
                                      color: backgroundColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                      ),
                                      Text(
                                        '${text[chosenLanguage]!['line']!} ${myCubit.stationModel!.irrigationSettings![0].customValvesSettings![lineIndex].valveId.toString()}',
                                        textDirection: chosenLanguage == 'ar'
                                            ? TextDirection.rtl
                                            : TextDirection.ltr,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: ListView.separated(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
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
                                                          .irrigationSettings![
                                                              0]
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
                                          myCubit.stationModel!.features![0]
                                                      .fertilizer ==
                                                  2
                                              ? showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                          contentPadding:
                                                              EdgeInsets.fromLTRB(
                                                                  0,
                                                                  MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.05,
                                                                  0,
                                                                  0),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          content: PopUpScreen(
                                                            currentMethod1: myCubit
                                                                .stationModel!
                                                                .irrigationSettings![
                                                                    0]
                                                                .customValvesSettings![
                                                                    0]
                                                                .irrigationMethod1!,
                                                            currentMethod2: myCubit
                                                                .stationModel!
                                                                .irrigationSettings![
                                                                    0]
                                                                .customValvesSettings![
                                                                    0]
                                                                .irrigationMethod2!,
                                                            currentMethod: myCubit
                                                                .stationModel!
                                                                .fertilizationSettings![
                                                                    0]
                                                                .customFertilizerSettings![
                                                                    0]
                                                                .fertilizerMethod1!,
                                                            flowMeter: myCubit
                                                                .stationModel!
                                                                .features![0]
                                                                .flowMeter!,
                                                            fertiliationType: myCubit
                                                                .stationModel!
                                                                .fertilizationSettings![
                                                                    0]
                                                                .customFertilizerSettings![
                                                                    lineIndex]
                                                                .fertilizerMethod1!,
                                                            ferStatusType: myCubit
                                                                .customIrrigationModelList[
                                                                    lineIndex]
                                                                .fertilizationStatusType,
                                                            statusType: myCubit
                                                                .customIrrigationModelList[
                                                                    lineIndex]
                                                                .statusType,
                                                            stationId:
                                                                stationId,
                                                            irrigationMethod2: myCubit
                                                                .stationModel!
                                                                .irrigationSettings![
                                                                    0]
                                                                .customValvesSettings![
                                                                    lineIndex]
                                                                .irrigationMethod2!,
                                                            lineIndex:
                                                                lineIndex,
                                                            valveId: myCubit
                                                                .stationModel!
                                                                .irrigationSettings![
                                                                    0]
                                                                .customValvesSettings![
                                                                    lineIndex]
                                                                .valveId!,
                                                          )),
                                                )
                                              : showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                          contentPadding:
                                                              EdgeInsets.fromLTRB(
                                                                  0,
                                                                  MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.05,
                                                                  0,
                                                                  0),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          content: PopUpScreen2(
                                                            currentMethod1: myCubit
                                                                .stationModel!
                                                                .irrigationSettings![
                                                                    0]
                                                                .customValvesSettings![
                                                                    0]
                                                                .irrigationMethod1!,
                                                            currentMethod2: myCubit
                                                                .stationModel!
                                                                .irrigationSettings![
                                                                    0]
                                                                .customValvesSettings![
                                                                    0]
                                                                .irrigationMethod2!,
                                                            flowMeter: myCubit
                                                                .stationModel!
                                                                .features![0]
                                                                .flowMeter!,
                                                            statusType: myCubit
                                                                .customIrrigationModelList[
                                                                    lineIndex]
                                                                .statusType,
                                                            stationId:
                                                                stationId,
                                                            irrigationMethod2: myCubit
                                                                .stationModel!
                                                                .irrigationSettings![
                                                                    0]
                                                                .customValvesSettings![
                                                                    lineIndex]
                                                                .irrigationMethod2!,
                                                            lineIndex:
                                                                lineIndex,
                                                            valveId: myCubit
                                                                .stationModel!
                                                                .irrigationSettings![
                                                                    0]
                                                                .customValvesSettings![
                                                                    lineIndex]
                                                                .valveId!,
                                                          )),
                                                );
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
                                              color:
                                                  Colors.blue.withOpacity(0.6),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(5),
                                                      bottomRight:
                                                          Radius.circular(5))),
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
                        ScarLightWidget(
                          lightFunction: () {
                            if (myCubit.stationModel!.features![0].light == 1) {
                              errorToast(context,text[chosenLanguage]![
                                  'You are not subscribed for this feature']!);
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LightScreen(),
                                  ));
                            }
                          },
                          scarFunction: () {
                            if (myCubit.stationModel!.features![0].animal ==
                                1) {
                              errorToast(context,text[chosenLanguage]![
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
                          scarColor:
                              myCubit.stationModel!.features![0].animal == 2
                                  ? lightSelectedColor
                                  : Colors.white,
                          scaricon:
                              myCubit.stationModel!.features![0].animal == 2
                                  ? smallIconOn
                                  : smallIconOff,
                          ligColor:
                              myCubit.stationModel!.features![0].light == 2
                                  ? lightSelectedColor
                                  : Colors.white,
                          ligicon: myCubit.stationModel!.features![0].light == 2
                              ? smallIconOn
                              : smallIconOff,
                        )
                      ],
                    ),
                  ),
                  rowWidget: const MainIconsRowWidget(
                    icon1: 'm',
                    icon2: 'f',
                  ),
                  buttonColor: settingsColor,
                  buttonTitle: text[chosenLanguage]!['Settings']!,
                  button: const SizedBox(
                    width: 0,
                    height: 0,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
