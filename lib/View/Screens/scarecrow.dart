import 'package:ag_smart/View%20Model/bloc/Scarcrow/Scarcrow_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Scarcrow/scarcrow_states.dart';
import 'package:ag_smart/View%20Model/bloc/commom_states.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/toasts.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/my_time_picker.dart';
import 'package:ag_smart/View/Reusable/open_valve_period_text_field.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Reusable/text_style.dart';
import 'package:ag_smart/View/Screens/bottom_nav_bar.dart';
import 'package:ag_smart/View/Screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;

import '../../View Model/Repo/auth_bloc.dart';

// ignore: must_be_immutable
class ScarecrowScreen extends StatefulWidget {
  const ScarecrowScreen({Key? key}) : super(key: key);

  @override
  State<ScarecrowScreen> createState() => _ScarecrowScreenState();
}

class _ScarecrowScreenState extends State<ScarecrowScreen> {
  TextEditingController onControl = TextEditingController();
  TextEditingController offControl = TextEditingController();
  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text[chosenLanguage]!['Device Setup']!),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ScarecrowCubit(authBloc)
            ..getData(onTime: onControl, offTime: offControl),
          child: BlocConsumer<ScarecrowCubit, CommonStates>(
            listener: (context, state) {
              if (state is ScarecrowPostSuccessState) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNavBarScreen(),
                    ),
                    (route) => false);
              } else if (state is ScarecrowPostFailState) {
                errorToast(context,'An error has occured');
              }
            },
            builder: (context, state) {
              ScarecrowCubit myCubit = ScarecrowCubit.get(context);
              return myCubit.stationModel == null ||
                      state is ScarecrowLoadingState
                  ? const Center(child: CircularProgressIndicator())
                  : BlocListener<AuthBloc, CommonStates>(
                      listener: (context, state) {
                        if (state is ExpiredTokenState) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(),
                              ),
                              (route) => false);
                          expiredTokenToast(context);
                        }
                        if (state is ServerDownState) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(),
                              ),
                              (route) => false);
                          serverDownToast(context);
                        }
                      },
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: Column(
                            children: [
                              MainCard2(
                                  mainWidget: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    decoration: BoxDecoration(
                                        color: backgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
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
                                                Text(text[chosenLanguage]![
                                                    'From']!),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                MyTimePicker(
                                                  time: intl.DateFormat('HH:mm')
                                                      .format(DateTime(
                                                          2023,
                                                          1,
                                                          1,
                                                          myCubit.time1.hour,
                                                          myCubit
                                                              .time1.minute)),
                                                  function: (value) => myCubit
                                                      .chooseTime1(value),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(text[chosenLanguage]![
                                                    'To']!),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                MyTimePicker(
                                                  time: intl.DateFormat('HH:mm')
                                                      .format(DateTime(
                                                          2023,
                                                          1,
                                                          1,
                                                          myCubit.time2.hour,
                                                          myCubit
                                                              .time2.minute)),
                                                  function: (value) => myCubit
                                                      .chooseTime2(value),
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
                                                Text(text[chosenLanguage]![
                                                    'Turn off']!),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                OpenValvePeriodTextField(
                                                    control: onControl,
                                                    hintText: '00',
                                                    unit: text[chosenLanguage]![
                                                        'Minutes']!)
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(text[chosenLanguage]![
                                                    'Turn on']!),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                OpenValvePeriodTextField(
                                                    control: offControl,
                                                    hintText: '00',
                                                    unit: text[chosenLanguage]![
                                                        'Minutes']!)
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
                                    if (onControl.text.isEmpty ||
                                        offControl.text.isEmpty) {
                                      errorToast(
                                          context,'Please fill the on and off periods');
                                    } else {
                                      int availableTime = myCubit.checkTime();
                                      int onTime = int.parse(onControl.text);
                                      int offTime = int.parse(offControl.text);
                                      if (availableTime >= onTime + offTime) {
                                        myCubit.put(
                                            startingTime: myCubit.time1,
                                            finishTime: myCubit.time2,
                                            onTime: int.parse(onControl.text),
                                            offTime:
                                                int.parse(offControl.text));
                                      } else {
                                        errorToast(context,'Input error');
                                      }
                                    }
                                  },
                                  cardtitle: text[chosenLanguage]![
                                      'Scarecrow Settings']!,
                                  buttonColor: yellowColor),
                            ],
                          ),
                        ),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
