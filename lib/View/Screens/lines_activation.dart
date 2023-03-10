import 'package:ag_smart/View%20Model/bloc/Lines%20activation/lines_activation_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Lines%20activation/lines_activation_states.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/global.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Reusable/text_style.dart';
import 'package:ag_smart/View/Screens/edit_settings.dart';
import 'package:ag_smart/View/Screens/irrigation_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Reusable/main_card02.dart';

class LinesActivationScreen extends StatelessWidget {
  final bool isEdit;
  const LinesActivationScreen({Key? key, required this.isEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text[chosenLanguage]!['Device Setup']!),
      ),
      body: BlocConsumer<LinesActivationCubit, LinesActivationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          LinesActivationCubit myCubit = LinesActivationCubit.get(context);
          return state is LinesActivationLoadingState
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  MainCard2(
                      function: () {
                        myCubit.toBinary(myCubit.valves.length);
                        print(binaryValves);
                        if (isEdit == false) {
                          myCubit.numberOfActivelines();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => IrrigationTypeScreen(
                                  isEdit: isEdit,
                                ),
                              ));
                        } else {
                          Navigator.of(context)
                            ..pop()
                            ..pushReplacement(MaterialPageRoute(
                              builder: (context) => const EditSettingsScreen(),
                            ));
                        }
                      },
                      buttonColor: greenButtonColor,
                      mainWidget: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.445,
                          child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  decoration: BoxDecoration(
                                      color: backgroundColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    children: [
                                      Transform.scale(
                                        scale: 0.8,
                                        child: CupertinoSwitch(
                                          value: myCubit.valves[index].isActive,
                                          onChanged: (value) {
                                            myCubit.activateLine(index);
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text('Line ${index + 1}')
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                );
                              },
                              itemCount: myCubit.valves.length)),
                      rowWidget: Text(
                        'm',
                        style: mainIcon,
                      ),
                      cardtitle: text[chosenLanguage]!['Lines Activation']!),
                ],
              );
        },
      ),
    );
  }
}
