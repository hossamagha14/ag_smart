import 'package:ag_smart/View%20Model/bloc/light/light_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/light/light_states.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/error_toast.dart';
import 'package:ag_smart/View/Reusable/light_choose_day.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/my_time_picker.dart';
import 'package:ag_smart/View/Reusable/open_valve_period_text_field.dart';
import 'package:ag_smart/View/Reusable/set_settings_2rows_container.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Reusable/text_style.dart';
import 'package:ag_smart/View/Screens/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class LightScreen extends StatelessWidget {
  LightScreen({Key? key}) : super(key: key);
  TextEditingController lightcontrol = TextEditingController();

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
              BlocConsumer<LightCubit, LightStates>(
                listener: (context, state) {
                  if (state is LightPutSuccessState) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BottomNavBarScreen(),
                        ),
                        (route) => false);
                  } else if (state is LightPutFailState) {}
                },
                builder: (context, state) {
                  LightCubit myCubit = LightCubit.get(context);
                  return MainCard2(
                      mainWidget: Column(
                        children: [
                          const LightChooseDay(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: SetSettings2RowsContainer(
                                  visible: false,
                                  function: () {},
                                  firstRowTitle:
                                      text[chosenLanguage]!['Set time']!,
                                  firstRowWidget: MyTimePicker(
                                      time: myCubit.lightTime
                                          .format(context)
                                          .toString(),
                                      function: (value) =>
                                          myCubit.chooseTime(value)),
                                  secondRowTitle:
                                      text[chosenLanguage]!['Lighting time']!,
                                  secondRowWidget: OpenValvePeriodTextField(
                                      control: lightcontrol,
                                      hintText: '00',
                                      unit: text[chosenLanguage]!['Hours']!))),
                        ],
                      ),
                      rowWidget: Text(
                        'k',
                        style: yellowIcon,
                      ),
                      function: () {
                        if (myCubit.noDayIsChosen == 7) {
                          errorToast('Please choose the days of work');
                        } else if (lightcontrol.text.isEmpty) {
                          errorToast('Please add the lighting time');
                        } else {
                          myCubit.issDone();
                          myCubit.putLight(
                              stationId: 1,
                              startTime: myCubit.lightTime,
                              duration: int.parse(lightcontrol.text));
                        }
                      },
                      cardtitle: text[chosenLanguage]!['Light Settings']!,
                      buttonColor: yellowColor);
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
