import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:flutter/material.dart';

class EditSettingsButton extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final function;
  final String buttonTile;
  const EditSettingsButton(
      {Key? key, required this.buttonTile, required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: settingsColor, width: 2),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: Text(
          buttonTile,
          style: TextStyle(color: iconColor, fontWeight: FontWeight.w500),
        )),
      ),
    );
  }
}
