import 'package:ag_smart/View%20Model/bloc/Duration%20settings/duration_settings_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Duration%20settings/duration_settings_states.dart';
import 'package:ag_smart/View%20Model/bloc/commom_states.dart';
import 'package:ag_smart/View/Reusable/add_new_container_button.dart';
import 'package:ag_smart/View/Reusable/choose_days_widget.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/toasts.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/main_icons_row_widget.dart';
import 'package:ag_smart/View/Reusable/my_time_picker.dart';
import 'package:ag_smart/View/Reusable/open_valve_period_text_field.dart';
import 'package:ag_smart/View/Reusable/set_settings_2rows_container.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../View Model/Repo/auth_bloc.dart';
import 'bottom_nav_bar.dart';
import 'package:intl/intl.dart' as intl;
import 'duration_settings.dart';

// ignore: must_be_immutable
class DurationSettingsByHourScreen extends StatefulWidget {
  final bool isEdit;
  final int irrigationType;
  final int flowMeter;
  final int pressure;
  final int pressureSwitch;
  const DurationSettingsByHourScreen(
      {Key? key, required this.isEdit, required this.irrigationType,required this.flowMeter,required this.pressure,required this.pressureSwitch})
      : super(key: key);

  @override
  State<DurationSettingsByHourScreen> createState() =>
      _DurationSettingsByHourScreenState();
}

class _DurationSettingsByHourScreenState
    extends State<DurationSettingsByHourScreen> {
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
      body: BlocProvider(
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
              errorToast(context,'An error has occurred');
            }
          },
          builder: (context, state) {
            DurationSettingsCubit myCubit = DurationSettingsCubit.get(context);
            return myCubit.irrigationSettingsModel == null ||
                    state is DurationSettingsLoadingState
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
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MainCard2(
                              editButton: InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DurationSettingsScreen(
                                              pressureSwitch: widget.pressureSwitch,
                                              pressure: widget.pressure,
                                              flowMeter: widget.flowMeter,
                                          isEdit: true,
                                          stationIrrigationType:
                                              widget.irrigationType,
                                        ),
                                      ));
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
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
                              buttonColor: greenButtonColor,
                              mainWidget: Column(
                                children: [
                                  const ChooseDyasWidget(
                                    useFunction: true,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: MediaQuery.of(context).size.height *
                                        0.33,
                                    child: ListView.separated(
                                        shrinkWrap: true,
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return SetSettings2RowsContainer(
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
                                              firstRowTitle: text[
                                                  chosenLanguage]!['Set time']!,
                                              firstRowWidget: MyTimePicker(
                                                  time: intl.DateFormat('HH:mm')
                                                      .format(DateTime(
                                                          2023,
                                                          1,
                                                          1,
                                                          myCubit.durationModel
                                                              .time[index].hour,
                                                          myCubit
                                                              .durationModel
                                                              .time[index]
                                                              .minute)),
                                                  function: (value) => myCubit
                                                      .pickTime(value, index)),
                                              secondRowTitle: text[chosenLanguage]![
                                                  'Open valve time']!,
                                              secondRowWidget: OpenValvePeriodTextField(
                                                  hintText: '00',
                                                  unit: text[chosenLanguage]![
                                                      'Minutes']!,
                                                  control: myCubit.durationModel
                                                      .controller[index]));
                                        },
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          );
                                        },
                                        itemCount: myCubit
                                            .durationModel.controller.length),
                                  ),
                                  AddNewContainerButton(
                                    functionAdd: () {
                                      myCubit.addContainer(hour: 0, minute: 0);
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
                                icon4: 'x',
                              ),
                              cardtitle:
                                  text[chosenLanguage]!['Duration settings']!,
                              function: () {
                                bool allFull = true;
                                bool checkTime = true;
                                for (int i = 0;
                                    i < myCubit.durationModel.controller.length;
                                    i++) {
                                  if (myCubit.durationModel.controller[i].text
                                      .isEmpty) {
                                    allFull = false;
                                  }
                                }
                                if (allFull == true) {
                                  if (widget.irrigationType == 1) {
                                    checkTime = myCubit
                                        .checkOpenValveTimeSeriesByTime();
                                  } else if (widget.irrigationType == 2) {
                                    checkTime =
                                        myCubit.checkOpenValveTimeParallel();
                                  }
                                }
                                if (allFull == true && checkTime == true) {
                                  if (myCubit.noDayIsChosen == 7) {
                                    errorToast(
                                        context,'Please choose the days of work');
                                  } else {
                                    myCubit.putIrrigationHourList(
                                        periodsList: myCubit.makeAList(
                                            weekday: myCubit.toDecimal()));
                                  }
                                } else if (allFull == false) {
                                  errorToast(context,'Please add the open valve time');
                                } else if (checkTime == false) {
                                  errorToast(context,'Input error');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
