import 'package:ag_smart/View/Reusable/settings_button.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Screens/dashboard.dart';
import 'package:ag_smart/View/Screens/pump_settings.dart';
import 'package:flutter/material.dart';

import 'device_features.dart';
import 'irrigation_type.dart';
import 'lines_activation.dart';
import 'lines_settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SettingsButton(
              title: 'Dashboard',
              function: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DashsboardScreen(),
                    ),
                    (route) => false);
              }),
          SettingsButton(
              title: text[chosenLanguage]!['Device Features']!,
              function: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DeviceFeaturesScreen(
                        isEdit: true,
                      ),
                    ));
              }),
          SettingsButton(
              title: text[chosenLanguage]!['Pump Settings']!,
              function: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PumpSettingsScreen(
                        isEdit: true,
                      ),
                    ));
              }),
          SettingsButton(
            title: text[chosenLanguage]!['Lines\' Settings']!,
            function: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const LinesSettingsScreen(isEdit: true),
                  ));
            },
          ),
          SettingsButton(
            title: text[chosenLanguage]!['Lines Activation']!,
            function: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LinesActivationScreen(
                      isEdit: true,
                    ),
                  ));
            },
          ),
          SettingsButton(
            title: text[chosenLanguage]!['Irrigation type']!,
            function: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const IrrigationTypeScreen(
                      isEdit: true,
                    ),
                  ));
            },
          ),
        ],
      )),
    );
  }
}
