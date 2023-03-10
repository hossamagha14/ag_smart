import 'package:ag_smart/View%20Model/bloc/Custom%20Firtilization/custom_fertilization_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Custom%20Firtilization/custom_fertilization_states.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/duration_settings_row.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Reusable/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'custom_fertilization_quantity.dart';
import 'custom_fertlization_duration.dart';

class CustomFirtilizationTypesScreen extends StatelessWidget {
  final int lineIndex;
  const CustomFirtilizationTypesScreen({Key? key, required this.lineIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Station info.'),
      ),
      body: SafeArea(
          child: Column(
        children: [
          BlocConsumer<CustomFertilizationCubit, CustomFertilizationStates>(
            listener: (context, state) {
              CustomFertilizationCubit myCubit =
                  CustomFertilizationCubit.get(context);
              if (state is CustomFertilizationPutSuccessState) {
                if (myCubit.fertilizationType == 1) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomFirtiliserSettingsScreen(
                          lineIndex: lineIndex,
                        ),
                      ));
                } else if (myCubit.fertilizationType == 2) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomFirtilisatiopnQuantityScreen(lineIndex: lineIndex,),
                      ));
                }
              }
            },
            builder: (context, state) {
              CustomFertilizationCubit myCubit =
                  CustomFertilizationCubit.get(context);
              return MainCard2(
                  mainWidget: DurationSettingsRow(
                      firstButtonTitle:
                          text[chosenLanguage]!['Fertilizing by duration']!,
                      secondButtonTitle:
                          text[chosenLanguage]!['Fertilizing by quantity']!,
                      firstButtonIcon: Center(
                          child: Text(
                        'y',
                        style: TextStyle(
                            fontFamily: 'icons',
                            color: yellowColor,
                            fontSize: 30),
                      )),
                      secondButtonIcon: Center(
                          child: Text(
                        'y',
                        style: TextStyle(
                            fontFamily: 'icons',
                            color: yellowColor,
                            fontSize: 30),
                      )),
                      firstButtonFunction: () {
                        myCubit.chooseDuration();
                      },
                      secondButtonFunction: () {
                        myCubit.chooseQuantity();
                      },
                      firstButtonColor: myCubit.isDuration == true
                          ? selectedColor
                          : Colors.white,
                      secondButtonColor: myCubit.isDuration == false
                          ? selectedColor
                          : Colors.white),
                  rowWidget: Text(
                    'y',
                    style: yellowIcon,
                  ),
                  function: () {
                    myCubit.putFertilizationType(
                        stationId: 1,
                        fertilizationMethod: myCubit.fertilizationType!);
                  },
                  cardtitle: 'Fertilization Settings',
                  buttonColor: yellowColor);
            },
          ),
        ],
      )),
    );
  }
}
