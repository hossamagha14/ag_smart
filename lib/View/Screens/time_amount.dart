import 'package:ag_smart/View%20Model/bloc/Duration%20settings/duration_settings_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Duration%20settings/duration_settings_states.dart';
import 'package:ag_smart/View%20Model/bloc/commom_states.dart';
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
import 'package:ag_smart/View/Screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;
import '../../View Model/Repo/auth_bloc.dart';
import '../Reusable/toasts.dart';
import 'duration_settings.dart';

// ignore: must_be_immutable
class TimeAmountScreen extends StatefulWidget {
  final bool isEdit;
  final int irrigationType;
  const TimeAmountScreen(
      {Key? key, required this.isEdit, required this.irrigationType})
      : super(key: key);

  @override
  State<TimeAmountScreen> createState() => _TimeAmountScreenState();
}

class _TimeAmountScreenState extends State<TimeAmountScreen> {
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
        create: (context) => DurationSettingsCubit(authBloc)..getPeriods(),
        child: BlocConsumer<DurationSettingsCubit, CommonStates>(
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
            DurationSettingsCubit myCubit = DurationSettingsCubit.get(context);
            return state is DurationSettingsLoadingState ||
                    myCubit.irrigationSettingsModel == null
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
                        expiredTokenToast();
                      }
                      if (state is ServerDownState) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(),
                            ),
                            (route) => false);
                        serverDownToast();
                      }
                    },
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: Column(
                          children: [
                            MainCard2(
                                editButton: InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DurationSettingsScreen(
                                            isEdit: true,
                                            stationIrrigationType:
                                                widget.irrigationType,
                                          ),
                                        ));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.03),
                                    child: Text(
                                      'l',
                                      style: TextStyle(
                                          fontFamily: 'icons',
                                          fontSize: 25,
                                          color: iconColor),
                                    ),
                                  ),
                                ),
                                mainWidget: Column(
                                  children: [
                                    const ChooseDyasWidget(
                                      useFunction: true,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.33,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: ListView.separated(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemBuilder: (context, index) =>
                                              SetSettings2RowsContainer(
                                                visible: myCubit.visible,
                                                function: () {
                                                  myCubit.removeContainerFromdb(
                                                      containerIndex: index,
                                                      valveId: 0,
                                                      weekday:
                                                          myCubit.toDecimal(),
                                                      periodId: myCubit
                                                          .durationModel
                                                          .controller
                                                          .length);
                                                },
                                                firstRowTitle:
                                                    text[chosenLanguage]![
                                                        'Set time']!,
                                                firstRowWidget: MyTimePicker(
                                                    time: intl.DateFormat(
                                                            'HH:mm')
                                                        .format(DateTime(
                                                            2023,
                                                            1,
                                                            1,
                                                            myCubit
                                                                .durationModel
                                                                .time[index]
                                                                .hour,
                                                            myCubit
                                                                .durationModel
                                                                .time[index]
                                                                .minute)),
                                                    function: (value) =>
                                                        myCubit.pickTime(
                                                            value, index)),
                                                secondRowTitle:
                                                    text[chosenLanguage]![
                                                        'Amount of water']!,
                                                secondRowWidget:
                                                    OpenValvePeriodTextField(
                                                        control: myCubit
                                                            .durationModel
                                                            .controller[index],
                                                        hintText: '00',
                                                        unit: text[
                                                                chosenLanguage]![
                                                            'ml']!),
                                              ),
                                          separatorBuilder: (context, index) =>
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
                                              ),
                                          itemCount: myCubit
                                              .durationModel.controller.length),
                                    ),
                                    AddNewContainerButton(
                                      functionAdd: () {
                                        myCubit.addContainer(
                                            hour: 0, minute: 0);
                                      },
                                      functionRemove: () {
                                        myCubit.showDeleteButton();
                                      },
                                    )
                                  ],
                                ),
                                rowWidget: MainIconsRowWidget(
                                  icon1: 'm',
                                  icon2: widget.irrigationType == 1 ? 'r' : 't',
                                  icon3: 'u',
                                  icon4: 'c',
                                ),
                                function: () {
                                  bool allFull = true;
                                  for (int i = 0;
                                      i <
                                          myCubit
                                              .durationModel.controller.length;
                                      i++) {
                                    if (myCubit.durationModel.controller[i].text
                                        .isEmpty) {
                                      allFull = false;
                                    }
                                  }
                                  if (myCubit.noDayIsChosen == 7) {
                                    errorToast(
                                        'Please choose the days of work');
                                  } else if (allFull == true) {
                                    myCubit.putIrrigationHourList(
                                        periodsList: myCubit.makeAList(
                                            weekday: myCubit.toDecimal()));
                                  } else {
                                    errorToast(
                                        'Please add the open valve time');
                                  }
                                },
                                cardtitle:
                                    text[chosenLanguage]!['Duration settings']!,
                                buttonColor: greenButtonColor)
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
