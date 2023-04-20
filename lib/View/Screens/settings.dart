import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/settings_button.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Screens/choose_language.dart';
import 'package:ag_smart/View/Screens/dashboard.dart';
import 'package:ag_smart/View/Screens/sign_in.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text[chosenLanguage]!['Settings']!),
      ),
      body: SafeArea(
          child: Column(
        children: [
          SettingsButton(
              title: text[chosenLanguage]!['Contact us']!,
              function: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DashsboardScreen(),
                    ),
                    (route) => false);
              }),
          SettingsButton(
              title: text[chosenLanguage]!['About us']!, function: () {}),
          SettingsButton(
              title: text[chosenLanguage]!['Change language']!,
              function: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ChooseLanguageScreen(isEdit: true),
                    ));
              }),
          SettingsButton(
            title: text[chosenLanguage]!['Log out']!,
            function: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    actionsAlignment: MainAxisAlignment.center,
                    titlePadding: const EdgeInsets.fromLTRB(15, 10, 15, 30),
                    actionsPadding: const EdgeInsets.only(bottom: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: Text(
                      text[chosenLanguage]!['Sure']!,
                      textDirection: chosenLanguage == 'ar'
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.04,
                              width: MediaQuery.of(context).size.width * 0.15,
                              decoration: BoxDecoration(
                                  color: greenButtonColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                  child: Text(text[chosenLanguage]!['No']!))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignInScreen(),
                                ),
                                (route) => false);
                          },
                          child: Text(text[chosenLanguage]!['Yes']!),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      )),
    );
  }
}
