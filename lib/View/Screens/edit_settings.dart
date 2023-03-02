import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/edit_settings_button.dart';
import 'package:ag_smart/View/Reusable/main_card.dart';
import 'package:ag_smart/View/Reusable/main_icons_row_widget.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Screens/irrigation_type.dart';
import 'package:ag_smart/View/Screens/lines_activation.dart';
import 'package:ag_smart/View/Screens/lines_settings.dart';
import 'package:ag_smart/View/Screens/pump_settings.dart';
import 'package:flutter/material.dart';

import 'device_features.dart';

class EditSettingsScreen extends StatelessWidget {
  const EditSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Station info'),
      ),
      body: SafeArea(
          child: Column(
        children: [
          MainCard(
              mainWidget: SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    EditSettingsButton(
                        buttonTile: text[chosenLanguage]!['Device Features']!,
                        function: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const DeviceFeaturesScreen(
                                  isEdit: true,
                                ),
                              ));
                        }),
                    EditSettingsButton(
                        buttonTile: text[chosenLanguage]!['Pump Settings']!,
                        function: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PumpSettingsScreen(
                                  isEdit: true,
                                ),
                              ));
                        }),
                    EditSettingsButton(
                        buttonTile: text[chosenLanguage]!['Lines\' Settings']!,
                        function: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const LinesSettingsScreen(isEdit: true),
                              ));
                        }),
                    EditSettingsButton(
                        buttonTile: text[chosenLanguage]!['Lines Activation']!,
                        function: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const LinesActivationScreen(isEdit: true,),
                              ));
                        }),
                    EditSettingsButton(
                        buttonTile: text[chosenLanguage]!['Irrigation type']!,
                        function: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const IrrigationTypeScreen(isEdit: true,),
                              ));
                        }),
                  ],
                ),
              ),
              buttonColor: settingsColor,
              rowWidget: const MainIconsRowWidget(icon1: 'm'),
              buttonTitle: text[chosenLanguage]!['Back to home page']!,
              function: () {
                Navigator.pop(context);
              }),
        ],
      )),
    );
  }
}
