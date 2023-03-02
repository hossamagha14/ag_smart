import 'package:ag_smart/View%20Model/bloc/Firtiliser%20settings/firtiliser_settings_states.dart';
import 'package:ag_smart/View%20Model/bloc/Firtiliser%20settings/firtilisers_settings_cubit.dart';
import 'package:ag_smart/View/Reusable/add_new_container_button.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/error_toast.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/my_date_picker.dart';
import 'package:ag_smart/View/Reusable/my_time_picker.dart';
import 'package:ag_smart/View/Reusable/open_valve_period_text_field.dart';
import 'package:ag_smart/View/Reusable/set_settings_3rows_container.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Reusable/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class FirtiliserSettingsScreen extends StatelessWidget {
  const FirtiliserSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text[chosenLanguage]!['Device Setup']!),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.85,
          child: Column(
            children: [
              BlocConsumer<FirtiliserSettingsCubit, FirtiliserSettingsStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  FirtiliserSettingsCubit myCubit =
                      FirtiliserSettingsCubit.get(context);
                  return MainCard2(
                      function: () {
                        if (myCubit
                            .firtiliserModel.controllersList[0].text.isEmpty) {
                          errorToast('Please add the open valve time');
                        } else {
                          myCubit.getData(context);
                          myCubit.issDone();
                          Navigator.of(context)
                            ..pop()
                            ..pop();
                        }
                      },
                      buttonColor: yellowColor,
                      mainWidget: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.35,
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return SetSettings3RowsContainer(
                                      firstRowTitle:
                                          text[chosenLanguage]!['Set day']!,
                                      firstRowWidget: MyDatePicker(
                                          date:
                                              '${myCubit.firtiliserModel.dateList[index].day}/${myCubit.firtiliserModel.dateList[index].month}/${myCubit.firtiliserModel.dateList[index].year}',
                                          function: (value) =>
                                              myCubit.chooseDate(value, index)),
                                      secondRowTitle:
                                          text[chosenLanguage]!['Set time']!,
                                      secondRowWidget: MyTimePicker(
                                          time: myCubit
                                              .firtiliserModel.timeList[index]
                                              .format(context)
                                              .toString(),
                                          function: (value) =>
                                              myCubit.chooseTime(value, index)),
                                      thirdRowTitle: text[chosenLanguage]![
                                          'Open valve time']!,
                                      thirdRowWidget: OpenValvePeriodTextField(
                                          hintText: '00',
                                          unit:
                                              text[chosenLanguage]!['Minutes']!,
                                          control: myCubit.firtiliserModel
                                              .controllersList[index]));
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  );
                                },
                                itemCount: myCubit.index),
                          ),
                          AddNewContainerButton(
                            functionAdd: () {
                              myCubit.addContainer();
                            },
                            functionRemove: () {
                              myCubit.removeContainer();
                            },
                          )
                        ],
                      ),
                      rowWidget: Text(
                        'g',
                        style: yellowIcon,
                      ),
                      cardtitle: text[chosenLanguage]!['Fertilizer Settings']!);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
