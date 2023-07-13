import 'package:ag_smart/View%20Model/bloc/commom_states.dart';
import 'package:ag_smart/View%20Model/bloc/light/light_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/light/light_states.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/toasts.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/my_time_picker.dart';
import 'package:ag_smart/View/Reusable/open_valve_period_text_field.dart';
import 'package:ag_smart/View/Reusable/set_settings_2rows_container.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Reusable/text_style.dart';
import 'package:ag_smart/View/Screens/bottom_nav_bar.dart';
import 'package:ag_smart/View/Screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;

import '../../View Model/Repo/auth_bloc.dart';

// ignore: must_be_immutable
class LightScreen extends StatefulWidget {
  const LightScreen({Key? key}) : super(key: key);

  @override
  State<LightScreen> createState() => _LightScreenState();
}

class _LightScreenState extends State<LightScreen> {
  TextEditingController lightcontrol = TextEditingController();
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
        create: (context) =>
            LightCubit(authBloc)..getData(duration: lightcontrol),
        child: BlocConsumer<LightCubit, CommonStates>(
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
            return myCubit.stationModel == null || state is LightLoadingState
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
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
                                mainWidget: Column(
                                  children: [
                                    SizedBox(
                                        height: MediaQuery.of(context).size.height *
                                            0.15,
                                        width: MediaQuery.of(context).size.width *
                                            0.8,
                                        child: SetSettings2RowsContainer(
                                            visible: false,
                                            function: () {},
                                            firstRowTitle: text[
                                                chosenLanguage]!['Set time']!,
                                            firstRowWidget: MyTimePicker(
                                                time: intl.DateFormat('HH:mm')
                                                    .format(DateTime(
                                                        2023,
                                                        1,
                                                        1,
                                                        myCubit.lightTime.hour,
                                                        myCubit
                                                            .lightTime.minute)),
                                                function: (value) =>
                                                    myCubit.chooseTime(value)),
                                            secondRowTitle:
                                                text[chosenLanguage]!['Lighting time']!,
                                            secondRowWidget: OpenValvePeriodTextField(control: lightcontrol, hintText: '00', unit: text[chosenLanguage]!['Hours']!))),
                                  ],
                                ),
                                rowWidget: Text(
                                  'k',
                                  style: yellowIcon,
                                ),
                                function: () {
                                  if (lightcontrol.text.isEmpty) {
                                    errorToast(context,'Please add the lighting time');
                                  } else {
                                    myCubit.putLight(
                                        stationId: stationId,
                                        startTime: myCubit.lightTime,
                                        duration: int.parse(lightcontrol.text));
                                  }
                                },
                                cardtitle:
                                    text[chosenLanguage]!['Light Settings']!,
                                buttonColor: yellowColor),
                          ],
                        ),
                      ),
                    ),
                  );
          },
        ),
      )),
    );
  }
}
