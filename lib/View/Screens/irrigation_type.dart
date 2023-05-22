import 'package:ag_smart/View%20Model/bloc/Irrigation%20type/irrigation_type_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Irrigation%20type/irrigation_type_states.dart';
import 'package:ag_smart/View/Reusable/toasts.dart';
import 'package:ag_smart/View/Reusable/irrigation_type_container.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/text_style.dart';
import 'package:ag_smart/View/Screens/bottom_nav_bar.dart';
import 'package:ag_smart/View/Screens/duration_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Reusable/colors.dart';
import '../Reusable/text.dart';

class IrrigationTypeScreen extends StatelessWidget {
  final bool isEdit;
  const IrrigationTypeScreen({Key? key, required this.isEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text[chosenLanguage]!['Device Setup']!),
      ),
      body: Column(
        children: [
          BlocConsumer<IrrigationTypeCubit, IrrigationTypesStates>(
            listener: (context, state) {
              IrrigationTypeCubit myCubit = IrrigationTypeCubit.get(context);
              if (myCubit.irrigationType == 3 ||
                  myCubit.irrigationType == 4 ||
                  myCubit.irrigationType == 5) {
                if (state is IrrigationTypeSendSuccessState) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNavBarScreen(),
                      ),
                      (route) => false);
                } else if (state is IrrigationTypeSendFailState) {
                  errorToast('An error has occurred');
                }
              }
            },
            builder: (context, state) {
              IrrigationTypeCubit myCubit = IrrigationTypeCubit.get(context);
              return MainCard2(
                  function: () {
                    if (myCubit.irrigationType == 1 ||
                        myCubit.irrigationType == 2) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DurationSettingsScreen(
                              isEdit: isEdit,
                              stationIrrigationType: myCubit.irrigationType,
                            ),
                          ));
                    } else if (myCubit.irrigationType == 3 ||
                        myCubit.irrigationType == 4) {
                      myCubit.putIrrigationType(
                          activeValves: binaryValves,
                          irrigationType: myCubit.irrigationType,
                          irrigationMethod1: 1,
                          irrigationMethod2: 1);
                    } else {
                      errorToast('Please choose irrigation type');
                    }
                  },
                  buttonColor: greenButtonColor,
                  mainWidget: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.49,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          IrrigationTypeContainer(
                              function: () {
                                myCubit.chooseSeriesIrrigation();
                              },
                              color: myCubit.irrigationType == 1
                                  ? selectedColor
                                  : backgroundColor,
                              icon: Text('r', style: bigIcon),
                              irrigationType:
                                  text[chosenLanguage]!['Series Irrigation']!),
                          IrrigationTypeContainer(
                            function: () {
                              myCubit.chooseParallelIrrigation();
                            },
                            color: myCubit.irrigationType == 2
                                ? selectedColor
                                : backgroundColor,
                            icon: Text('t', style: bigIcon),
                            irrigationType:
                                text[chosenLanguage]!['Parallel Irrigation']!,
                            widget: Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.05),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CupertinoSwitch(
                                      value: myCubit.irrigationType == 2
                                          ? myCubit.active
                                          : false,
                                      onChanged: (value) {
                                        myCubit.activate();
                                      }),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      text[chosenLanguage]![
                                          'Irregular water pressure']!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 11),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          IrrigationTypeContainer(
                              function: () {
                                myCubit.chooseCustomIrrigation();
                              },
                              color: myCubit.irrigationType == 3
                                  ? selectedColor
                                  : backgroundColor,
                              icon: Text(
                                'f',
                                style: bigIcon,
                              ),
                              irrigationType:
                                  text[chosenLanguage]!['Custom Irrigation']!),
                          IrrigationTypeContainer(
                              function: () {
                                myCubit.chooseAutoIrrigation();
                              },
                              color: myCubit.irrigationType == 4
                                  ? selectedColor
                                  : backgroundColor,
                              icon: Text(
                                'e',
                                style: bigIcon,
                              ),
                              irrigationType: text[chosenLanguage]![
                                  'Automatic Irrigation']!)
                        ],
                      ),
                    ),
                  ),
                  rowWidget: Text(
                    'm',
                    style: mainIcon,
                  ),
                  cardtitle: text[chosenLanguage]!['Irrigation type']!);
            },
          ),
          const Spacer()
        ],
      ),
    );
  }
}
