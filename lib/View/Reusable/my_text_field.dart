import 'package:ag_smart/View/Reusable/text.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Color color;
  final Widget? suffixIcon;
  final bool? secureText;

  const MyTextField(
      {Key? key,
      required this.label,
      required this.controller,
      required this.color,
      this.suffixIcon,
      this.secureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          child: Row(
            textDirection:
                chosenLanguage == 'ar' ? TextDirection.rtl : TextDirection.ltr,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.63,
                child: TextFormField(
                  obscureText: secureText ?? false,
                  textDirection: chosenLanguage == 'ar'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  controller: controller,
                  textAlign: TextAlign.start,
                  // the widget between the top row (Agritopia1) and the next button
                  decoration: InputDecoration(
                    hintTextDirection: chosenLanguage == 'ar'
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    hintText: label,
                    border: InputBorder.none,
                  ),
                ),
              ),
              suffixIcon ??
                  const SizedBox(
                    height: 0,
                    width: 0,
                  )
            ],
          ),
        ),
      ),
    );
  }
}
