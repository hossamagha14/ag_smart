import 'package:ag_smart/View%20Model/bloc/Lines%20activation/lines_activation_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Lines%20activation/lines_activation_states.dart';
import 'package:ag_smart/View/Reusable/choose_days_widget.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/firtilisers_scarcrow_light_widget.dart';
import 'package:ag_smart/View/Reusable/main_card.dart';
import 'package:ag_smart/View/Reusable/main_icons_row_widget.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Screens/edit_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../View Model/bloc/Irrigation type/irrigation_type_cubit.dart';
import '../../View Model/bloc/Irrigation type/irrigation_type_states.dart';

class StationInfoScreen extends StatelessWidget {
  const StationInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text[chosenLanguage]!['Station info']!),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: BlocConsumer<IrrigationTypeCubit, IrrigationTypesStates>(
            listener: (context, state) {},
            builder: (context, state) {
              IrrigationTypeCubit myCubit = IrrigationTypeCubit.get(context);
              return Column(
                children: [
                  MainCard(
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditSettingsScreen(),
                          ));
                    },
                    mainWidget: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        const ChooseDyasWidget(
                          useFunction: false,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.36,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: BlocConsumer<LinesActivationCubit,
                                  LinesActivationStates>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                LinesActivationCubit activationCubit =
                                    LinesActivationCubit.get(context);
                                return ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Visibility(
                                        visible: activationCubit
                                            .valves[index].isActive,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          decoration: BoxDecoration(
                                              color: backgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text('Line ${index + 1}'),
                                                const Spacer()
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return Visibility(
                                        visible: activationCubit
                                            .valves[index].isActive,
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                        ),
                                      );
                                    },
                                    itemCount: activationCubit.valves.length);
                              }),
                        ),
                        const FirScarLightWidget()
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
                          icon2:
                              irrigationCubit.irrigationType == 1 ? 'r' : 't',
                          icon3: myCubit.accordingToHour == true ? 'u' : 'w',
                          icon4:
                              myCubit.accordingToQuantity == true ? 'c' : 'x',
                        );
                      },
                    ),
                    buttonColor: settingsColor,
                    buttonTitle: text[chosenLanguage]!['Settings']!,
                    buttonIcon: const Text(
                      'q',
                      style: TextStyle(fontFamily: 'icons', fontSize: 25),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
