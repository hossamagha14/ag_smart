import 'package:ag_smart/View%20Model/bloc/Pump%20settings/pump_settingd_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Pump%20settings/pump_settings_states.dart';
import 'package:ag_smart/View/Reusable/toasts.dart';
import 'package:ag_smart/View/Reusable/main_card02.dart';
import 'package:ag_smart/View/Reusable/pump_settings_container.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Reusable/text_style.dart';
import 'package:ag_smart/View/Screens/lines_activation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Reusable/colors.dart';

// ignore: must_be_immutable
class PumpSettingsScreen extends StatelessWidget {
  final bool isEdit;
  PumpSettingsScreen({Key? key, required this.isEdit}) : super(key: key);
  TextEditingController hoursePowerControl = TextEditingController();

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
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocConsumer<PumpSettingsCubit, PumpSettingsStates>(
                    listener: (context, state) {
                  if (state is PumpSettingSendSuccessState) {
                    FocusScope.of(context).unfocus();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LinesActivationScreen(isEdit: isEdit),
                        ));
                  }
                }, builder: (context, state) {
                  PumpSettingsCubit myCubit = PumpSettingsCubit.get(context);
                  return MainCard2(
                      function: () {
                        if (myCubit.groupValue == 0) {
                          errorToast('Please choose pump settings');
                        } else if (myCubit.groupValue == 2 &&
                            hoursePowerControl.text.isEmpty) {
                          errorToast('Please put the pump horse power');
                        } else {
                          myCubit.putPumpSettings(
                              pumpPower: hoursePowerControl.text.isEmpty
                                  ? 0
                                  : double.parse(hoursePowerControl.text),
                              pumpEnabled: myCubit.groupValue,
                              pressureSwitch: 0);
                        }
                      },
                      buttonColor: greenButtonColor,
                      mainWidget: Column(
                        children: [
                          PumpSettingsContainer(
                              value: 2,
                              groupValue: myCubit.groupValue,
                              function: (value) {
                                myCubit.choosePumpSettings(
                                    value!, hoursePowerControl);
                              },
                              widget: Row(
                                textDirection: chosenLanguage == 'ar'
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                children: [
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      child: TextFormField(
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                        readOnly:
                                            myCubit.isPressed ? false : true,
                                        controller: hoursePowerControl,
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          hintStyle: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                          border: InputBorder.none,
                                        ),
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    chosenLanguage == 'ar'
                                        ? '${text[chosenLanguage]!['Horse']!} /'
                                        : '/ ${text[chosenLanguage]!['Horse']!}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          PumpSettingsContainer(
                              value: 1,
                              groupValue: myCubit.groupValue,
                              widget: Text(text[chosenLanguage]!['Nothing']!,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400)),
                              function: (value) {
                                myCubit.choosePumpSettings(
                                    value!, hoursePowerControl);
                              })
                        ],
                      ),
                      rowWidget: Text(
                        'm',
                        style: mainIcon,
                      ),
                      cardtitle: text[chosenLanguage]!['Pump Settings']!);
                }),
              ],
            ),
          ),
        ));
  }
}
