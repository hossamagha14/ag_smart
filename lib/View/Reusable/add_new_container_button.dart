// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:ag_smart/View/Reusable/text.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

class AddNewContainerButton extends StatelessWidget {
  final functionAdd;
  final functionRemove;
  const AddNewContainerButton(
      {Key? key, required this.functionAdd, required this.functionRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        textDirection: TextDirection.rtl,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.06,
            child: ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(0),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10)))),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(backgroundColor)),
                onPressed: functionAdd,
                child: Center(
                    child: Text(
                  '${text[chosenLanguage]!['Add a period']!} +',
                  textDirection: chosenLanguage== 'ar'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ))),
          ),
          Container(
            width: 2,
            height: MediaQuery.of(context).size.height * 0.06,
            color: iconColor,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.06,
            child: ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(0),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)))),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(backgroundColor)),
                onPressed: functionRemove,
                child:  Center(
                    child: Text(
                  '${text[chosenLanguage]!['Remove a period']!} -',
                  textDirection: chosenLanguage== 'ar'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                  style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ))),
          ),
        ],
      ),
    );
  }
}
