import 'package:ag_smart/View/Reusable/text.dart';
import 'package:flutter/material.dart';

class OpenValvePeriodTextField extends StatelessWidget {
  final TextEditingController control;
  final String hintText;
  final String unit;

  const OpenValvePeriodTextField(
      {Key? key,
      required this.control,
      required this.hintText,
      required this.unit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.31,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          textDirection:
              chosenLanguage == 'ar' ? TextDirection.rtl : TextDirection.ltr,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.12,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: control,
                decoration: InputDecoration(
                    hintText: hintText, border: InputBorder.none),
              ),
            ),
            Text(unit),
          ],
        ),
      ),
    );
  }
}
