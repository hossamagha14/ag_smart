import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class MyNumberPicker extends StatelessWidget {
  final int value;
  final function;
  const MyNumberPicker({Key? key,required this.value,required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NumberPicker(
      value: value,
      minValue: 0,
      maxValue: 28,
      onChanged: function,
      itemCount: 7,
      itemHeight: MediaQuery.of(context).size.height*0.07,
    );
  }
}
