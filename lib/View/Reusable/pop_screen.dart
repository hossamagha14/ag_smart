import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Screens/custom_ferilization_type.dart';
import 'package:flutter/material.dart';

import '../Screens/custom_duration_settings.dart';
import 'colors.dart';

class PopUpScreen extends StatelessWidget {
  final int lineIndex;
  const PopUpScreen({Key? key, required this.lineIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.18,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CustomDurationSettingsScreen(
                                        lineIndex: lineIndex),
                              ));
                        },
                        child: Text(
                          'c',
                          style: TextStyle(
                              fontSize: 45,
                              fontFamily: 'icons',
                              color: settingsColor),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Text(
                          text[chosenLanguage]!['Irrigation Settings']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 12),
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CustomFirtilizationTypesScreen(
                                  lineIndex: lineIndex,
                                ),
                              ));
                        },
                        child: SizedBox(
                          child: Text(
                            'y',
                            style: TextStyle(
                                fontSize: 45,
                                fontFamily: 'icons',
                                color: yellowColor),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Text(
                          text[chosenLanguage]!['Fertilization Settings']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 12),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: CircleAvatar(
              backgroundColor: settingsColor,
              radius: 15,
              child: const Icon(
                Icons.close,
                color: Colors.white,
              )),
        )
      ],
    );
  }
}
