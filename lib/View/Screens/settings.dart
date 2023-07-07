import 'package:ag_smart/View/Reusable/edit_settings_button.dart';
import 'package:ag_smart/View/Reusable/main_card.dart';
import 'package:ag_smart/View/Reusable/settings_pop_up.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Screens/manual_irrigation.dart';
import 'package:ag_smart/View/Screens/pump_settings.dart';
import 'package:flutter/material.dart';

import 'device_features.dart';
import 'edit_settings.dart';
import 'irrigation_type.dart';
import 'lines_activation.dart';
import 'lines_settings.dart';

class SettingsScreen extends StatelessWidget {
  final int flowMeter;
  final int pressure;
  final String serial;
  const SettingsScreen(
      {Key? key,
      required this.flowMeter,
      required this.pressure,
      required this.serial})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MainCard(
          mainWidget: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  EditSettingsButton(
                      buttonTile: text[chosenLanguage]!['Edit settings']!,
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditSettingsScreen(serial: serial),
                            ));
                      }),
                  EditSettingsButton(
                      buttonTile: text[chosenLanguage]!['Manual Irrigation']!,
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ManualIrrigationScreen(),
                            ));
                      }),
                  EditSettingsButton(
                      buttonTile: text[chosenLanguage]!['Device Features']!,
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DeviceFeaturesScreen(
                                isEdit: true,
                              ),
                            ));
                      }),
                  EditSettingsButton(
                      buttonTile: text[chosenLanguage]!['Pump Settings']!,
                      function: () {
                        showDialog(
                            context: context,
                            builder: (context) => SettingsPopUp(function: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PumpSettingsScreen(
                                          isEdit: true,
                                        ),
                                      ));
                                }));
                      }),
                  EditSettingsButton(
                      buttonTile: text[chosenLanguage]!['Lines Activation']!,
                      function: () {
                        showDialog(
                            context: context,
                            builder: (context) => SettingsPopUp(function: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LinesActivationScreen(
                                          isEdit: true,
                                        ),
                                      ));
                                }));
                      }),
                  EditSettingsButton(
                      buttonTile: text[chosenLanguage]!['Lines\' Settings']!,
                      function: () {
                        showDialog(
                            context: context,
                            builder: (context) => SettingsPopUp(function: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LinesSettingsScreen(
                                                isEdit: true),
                                      ));
                                }));
                      }),
                  EditSettingsButton(
                      buttonTile: text[chosenLanguage]!['Irrigation type']!,
                      function: () {
                        showDialog(
                            context: context,
                            builder: (context) => SettingsPopUp(function: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            IrrigationTypeScreen(
                                          pressure: pressure,
                                          isEdit: true,
                                          flowMeter: flowMeter,
                                        ),
                                      ));
                                }));
                      }),
                ],
              ),
            ),
          ),
          buttonColor: Colors.black,
          rowWidget: const SizedBox(),
          buttonTitle: '',
          function: () {},
          button: const SizedBox(
            width: 0,
            height: 0,
          ),
        ),
      ),
    );
  }
}
