import 'package:ag_smart/View/Reusable/text.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class PumpSettingsContainer extends StatelessWidget {
  final int value;
  final int groupValue;
  // ignore: prefer_typing_uninitialized_variables
  final function;
  final Widget widget;
  const PumpSettingsContainer(
      {Key? key,
      required this.value,
      required this.groupValue,
      required this.function,
      required this.widget
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(10)),
      child: Row(
        textDirection: chosenLanguage=='ar'? TextDirection.rtl:TextDirection.ltr,
        children: [
          Radio(value: value, groupValue: groupValue, onChanged: function),
          widget
        ],
      ),
    );
  }
}
