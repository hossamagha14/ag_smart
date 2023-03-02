// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class DurationSettingsRow extends StatelessWidget {
  final String firstButtonTitle;
  final String secondButtonTitle;
  final Widget firstButtonIcon;
  final Widget secondButtonIcon;
  final Color firstButtonColor;
  final Color secondButtonColor;
  final firstButtonFunction;
  final secondButtonFunction;
  const DurationSettingsRow(
      {Key? key,
      required this.firstButtonTitle,
      required this.secondButtonTitle,
      required this.firstButtonIcon,
      required this.secondButtonIcon,
      required this.firstButtonFunction,
      required this.secondButtonFunction,
      required this.firstButtonColor,
      required this.secondButtonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              InkWell(
                onTap: firstButtonFunction,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.35,
                  decoration: BoxDecoration(
                      color: firstButtonColor,
                      border: Border.all(width: 1, color: Colors.blue),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: firstButtonIcon,
                ),
              ),
              const SizedBox(height: 5,),
              Text(firstButtonTitle)
            ],
          ),
          Column(
            children: [
              InkWell(
                onTap: secondButtonFunction,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.35,
                  decoration: BoxDecoration(
                      color: secondButtonColor,
                      border: Border.all(width: 1, color: Colors.blue),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                  child: secondButtonIcon,
                ),
              ),
              const SizedBox(height: 5,),
              Text(secondButtonTitle)
            ],
          )
        ],
      ),
    );
  }
}
