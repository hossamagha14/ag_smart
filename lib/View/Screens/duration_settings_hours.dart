import 'package:ag_smart/View%20Model/bloc/Duration%20settings/duration_settings_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Duration%20settings/duration_settings_states.dart';
import 'package:ag_smart/View/Reusable/add_new_container_button.dart';
import 'package:ag_smart/View/Reusable/choose_days_widget.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/error_toast.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/main_icons_row_widget.dart';
import 'package:ag_smart/View/Reusable/my_time_picker.dart';
import 'package:ag_smart/View/Reusable/open_valve_period_text_field.dart';
import 'package:ag_smart/View/Reusable/set_settings_2rows_container.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../View Model/bloc/Irrigation type/irrigation_type_cubit.dart';
import '../../View Model/bloc/Irrigation type/irrigation_type_states.dart';
import 'bottom_nav_bar.dart';

// ignore: must_be_immutable
class DurationSettingsByHourScreen extends StatelessWidget {
  final bool isEdit;
  const DurationSettingsByHourScreen({Key? key, required this.isEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text[chosenLanguage]!['Device Setup']!),
      ),
      body: BlocConsumer<DurationSettingsCubit, DurationSettingsStates>(
        listener: (context, state) {
          if (state is DurationSettingsSendSuccessState) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottomNavBarScreen(),
                ),
                (route) => false);
          } else if (state is DurationSettingsSendFailedState) {
            errorToast('An error has occurred');
          }
        },
        builder: (context, state) {
          DurationSettingsCubit myCubit = DurationSettingsCubit.get(context);
          return myCubit.irrigationSettingsModel == null
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MainCard2(
                          buttonColor: greenButtonColor,
                          mainWidget: Column(
                            children: [
                              const ChooseDyasWidget(
                                useFunction: true,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: ListView.separated(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return SetSettings2RowsContainer(
                                          visible: myCubit.visible,
                                          function: () {},
                                          firstRowTitle: text[chosenLanguage]![
                                              'Set time']!,
                                          firstRowWidget: MyTimePicker(
                                              time: myCubit
                                                  .durations[index].time
                                                  .format(context)
                                                  .toString(),
                                              function: (value) =>
                                                  myCubit.pickTime(value,
                                                      index)),
                                          secondRowTitle: text[chosenLanguage]![
                                              'Open valve time']!,
                                          secondRowWidget:
                                              OpenValvePeriodTextField(
                                                  hintText: '00',
                                                  unit:
                                                      text[
                                                              chosenLanguage]![
                                                          'Minutes']!,
                                                  control: myCubit
                                                      .durations[index]
                                                      .controller));
                                    },
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01,
                                      );
                                    },
                                    itemCount: myCubit.durations.length),
                              ),
                              AddNewContainerButton(
                                functionAdd: () {
                                  myCubit.addContainer();
                                },
                                functionRemove: () {
                                  myCubit.showDeleteButton();
                                },
                              )
                            ],
                          ),
                          rowWidget: BlocConsumer<IrrigationTypeCubit,
                              IrrigationTypesStates>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              IrrigationTypeCubit irrigationCubit =
                                  IrrigationTypeCubit.get(context);
                              return MainIconsRowWidget(
                                icon1: 'm',
                                icon2: irrigationCubit.irrigationType == 1
                                    ? 'r'
                                    : 't',
                                icon3: 'u',
                                icon4: 'x',
                              );
                            },
                          ),
                          cardtitle:
                              text[chosenLanguage]!['Duration settings']!,
                          function: () {
                            bool allFull = true;
                            for (int i = 0; i < myCubit.durations.length; i++) {
                              if (myCubit
                                  .durations[i].controller.text.isEmpty) {
                                allFull = false;
                              }
                              print(myCubit.durations);
                            }
                            if (allFull == true) {
                              if (myCubit.noDayIsChosen == 7) {
                                errorToast('Please choose the days of work');
                              } else {
                                myCubit.putIrrigationHourList(
                                    stationId: 1,
                                    periodsList:
                                        myCubit.makeAList(weekday: 90));
                              }
                            } else if (allFull == false) {
                              errorToast('Please add the open valve time');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
