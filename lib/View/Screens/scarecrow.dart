import 'package:ag_smart/View%20Model/bloc/Scarcrow/Scarcrow_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Scarcrow/scarcrow_states.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/error_toast.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/my_time_picker.dart';
import 'package:ag_smart/View/Reusable/open_valve_period_text_field.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Reusable/text_style.dart';
import 'package:ag_smart/View/Screens/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ScarecrowScreen extends StatelessWidget {
  ScarecrowScreen({Key? key}) : super(key: key);
  TextEditingController startControl = TextEditingController();
  TextEditingController endControl = TextEditingController();

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
                BlocConsumer<ScarecrowCubit, ScarecrowStates>(
                  listener: (context, state) {
                    if (state is ScarecrowPostSuccessState) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BottomNavBarScreen(),
                          ),
                          (route) => false);
                    }else if(state is ScarecrowPostFailState){
                      errorToast('An error has occured');
                    }
                  },
                  builder: (context, state) {
                    ScarecrowCubit myCubit = ScarecrowCubit.get(context);
                    return MainCard2(
                        mainWidget: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.3,
                          decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                textDirection: chosenLanguage == 'ar'
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                children: [
                                  Column(
                                    children: [
                                      Text(text[chosenLanguage]!['From']!),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      MyTimePicker(
                                        time: myCubit.time1
                                            .format(context)
                                            .toString(),
                                        function: (value) =>
                                            myCubit.chooseTime1(value),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(text[chosenLanguage]!['To']!),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      MyTimePicker(
                                        time: myCubit.time2
                                            .format(context)
                                            .toString(),
                                        function: (value) =>
                                            myCubit.chooseTime2(value),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                textDirection: chosenLanguage == 'ar'
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                children: [
                                  Column(
                                    children: [
                                      Text(text[chosenLanguage]!['Turn off']!),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      OpenValvePeriodTextField(
                                          control: startControl,
                                          hintText: '00',
                                          unit:
                                              text[chosenLanguage]!['Minutes']!)
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(text[chosenLanguage]!['Turn on']!),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      OpenValvePeriodTextField(
                                          control: endControl,
                                          hintText: '00',
                                          unit:
                                              text[chosenLanguage]!['Minutes']!)
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        rowWidget: Text(
                          'z',
                          style: yellowIcon,
                        ),
                        function: () {
                          if (startControl.text.isEmpty ||
                              endControl.text.isEmpty) {
                            errorToast('Please fill the on and off periods');
                          } else {
                            myCubit.issDone();
                            myCubit.put(
                                startingTime: myCubit.time1,
                                finishTime: myCubit.time2,
                                onTime: int.parse(startControl.text),
                                offTime: int.parse(endControl.text));
                          }
                        },
                        cardtitle: text[chosenLanguage]!['Scarecrow Settings']!,
                        buttonColor: yellowColor);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
