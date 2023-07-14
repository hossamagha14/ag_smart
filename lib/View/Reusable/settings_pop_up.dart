import 'package:ag_smart/View/Reusable/text.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class SettingsPopUp extends StatelessWidget {
  final function;
  const SettingsPopUp({Key? key, required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.27,
        width: MediaQuery.of(context).size.width * 0.8,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              text[chosenLanguage]!['settings pop up']!,
              textDirection: chosenLanguage == 'ar'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              style: const TextStyle(color: Colors.black87),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: function,
                  child: SizedBox(
                    width: chosenLanguage == 'ar'
                        ? MediaQuery.of(context).size.width * 0.11
                        : MediaQuery.of(context).size.width * 0.065,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: FittedBox(
                      child: Text(
                        text[chosenLanguage]!['Ok']!,
                        textDirection: chosenLanguage == 'ar'
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        style: TextStyle(color: iconColor),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: FittedBox(
                      child: Text(
                        text[chosenLanguage]!['Cancel']!,
                        textDirection: chosenLanguage == 'ar'
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
