// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:flutter/material.dart';

import 'text.dart';

class SettingsButton extends StatelessWidget {
  final String title;
  final function;
  const SettingsButton({Key? key, required this.title, required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: chosenLanguage=='ar'?CrossAxisAlignment.end:CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: function,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            color: backgroundColor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
              child: Text(
                title,
                style: const TextStyle(fontSize: 18),
                textDirection: chosenLanguage == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: Divider(
            thickness: 2,
          ),
        )
      ],
    );
  }
}
