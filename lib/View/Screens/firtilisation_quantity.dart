import 'package:ag_smart/View%20Model/bloc/Firtiliser%20settings/firtiliser_settings_states.dart';
import 'package:ag_smart/View%20Model/bloc/Firtiliser%20settings/firtilisers_settings_cubit.dart';
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
class FirtilisatiopnQuantityScreen extends StatelessWidget {
  FirtilisatiopnQuantityScreen({Key? key}) : super(key: key);
  TextEditingController mlControl = TextEditingController();

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
                BlocConsumer<FirtiliserSettingsCubit, FirtiliserSettingsStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    FirtiliserSettingsCubit myCubit =
                        FirtiliserSettingsCubit.get(context);
                    return MainCard2(
                        mainWidget: SetSettings3RowsContainer(
                          visible: false,
                          function: (){},
                            firstRowTitle: text[chosenLanguage]!['Set day']!,
                            firstRowWidget: MyDatePicker(
                                date:
                                    '${myCubit.firtiliserModel.dateList[0].day}/${myCubit.firtiliserModel.dateList[0].month}/${myCubit.firtiliserModel.dateList[0].year}',
                                function: (value) =>
                                    myCubit.chooseDate(value, 0)),
                            secondRowTitle: text[chosenLanguage]!['Set time']!,
                            secondRowWidget: MyTimePicker(
                                time: myCubit.firtiliserModel.timeList[0]
                                    .format(context)
                                    .toString(),
                                function: (value) =>
                                    myCubit.chooseTime(value, 0)),
                            thirdRowTitle:
                                text[chosenLanguage]!['Fertillization amount']!,
                            thirdRowWidget: OpenValvePeriodTextField(
                                control: mlControl,
                                hintText: '00',
                                unit: text[chosenLanguage]!['ml']!)),
                        rowWidget: Text(
                          'h',
                          style: yellowIcon,
                        ),
                        function: () {
                          if (mlControl.text.isEmpty) {
                            errorToast('Please add firtiliser amount');
                          } else {
                            myCubit.getData(context);
                            myCubit.issDone();
                            Navigator.of(context)
                              ..pop()
                              ..pop();
                          }
                        },
                        cardtitle:
                            text[chosenLanguage]!['Fertilizer Settings']!,
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
