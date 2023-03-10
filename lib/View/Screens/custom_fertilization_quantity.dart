import 'package:ag_smart/View%20Model/bloc/Custom%20Firtilization/custom_fertilization_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Custom%20Firtilization/custom_fertilization_states.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/error_toast.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/my_time_picker.dart';
import 'package:ag_smart/View/Reusable/open_valve_period_text_field.dart';
import 'package:ag_smart/View/Reusable/set_settings_3rows_container.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Reusable/text_style.dart';
import 'package:ag_smart/View/Screens/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Reusable/drop_down_menu.dart';

// ignore: must_be_immutable
class CustomFirtilisatiopnQuantityScreen extends StatelessWidget {
  final int lineIndex;
  CustomFirtilisatiopnQuantityScreen({Key? key, required this.lineIndex})
      : super(key: key);
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
                BlocConsumer<CustomFertilizationCubit,
                    CustomFertilizationStates>(
                  listener: (context, state) {
                    if (state is CustomFertilizationPutSuccessState) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BottomNavBarScreen(),
                          ),
                          (route) => false);
                    }else if(state is CustomFertilizationPutFailState){
                      errorToast('An error has occurred');
                    }
                  },
                  builder: (context, state) {
                    CustomFertilizationCubit myCubit =
                        CustomFertilizationCubit.get(context);
                    return MainCard2(
                        mainWidget: SetSettings3RowsContainer(
                            visible: false,
                            function: () {},
                            firstRowTitle: text[chosenLanguage]!['Set day']!,
                            firstRowWidget: MyDropDownMenu(
                                hint: const Text('Days'),
                                value: myCubit.quantityDayValue,
                                items: myCubit
                                    .customFertilizationModelList[lineIndex]
                                    .days
                                    .map((e) => DropdownMenuItem(
                                        value: e, child: Text(e.toString())))
                                    .toList(),
                                function: (value) {
                                  myCubit.chooseQuantityDay(value);
                                }),
                            secondRowTitle: text[chosenLanguage]!['Set time']!,
                            secondRowWidget: MyTimePicker(
                                time: myCubit.quantityTime
                                    .format(context)
                                    .toString(),
                                function: (value) =>
                                    myCubit.chooseQuantityTime(value)),
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
                          if (myCubit.quantityDayValue == null ||
                              mlControl.text.isEmpty) {
                            errorToast('Please fill all the data');
                          } else {
                            myCubit.putFertilizationQuantitySettings(
                                stationId: 1,
                                valveId: lineIndex+1,
                                periodId: 0,
                                startTime: myCubit.quantityTime,
                                duration: 0,
                                quantity: int.parse(mlControl.text),
                                date: myCubit.quantityDayValue!);
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
