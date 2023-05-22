import 'package:ag_smart/View%20Model/bloc/Language/language_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Language/language_states.dart';
import 'package:ag_smart/View%20Model/database/cache_helpher.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/language_card.dart';
import 'package:ag_smart/View/Screens/bottom_dash_bar_screen.dart';
import 'package:ag_smart/View/Screens/bottom_nav_bar.dart';
import 'package:ag_smart/View/Screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Reusable/text.dart';

class ChooseLanguageScreen extends StatelessWidget {
  final bool isEdit;
  final int chosenLanguageType;
  const ChooseLanguageScreen(
      {Key? key, required this.isEdit, required this.chosenLanguageType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.05,
          MediaQuery.of(context).size.height * 0.03,
          0,
          0,
        ),
        child: BlocConsumer<LanguageCubit, LanguageStates>(
            listener: (context, state) {},
            builder: (context, state) {
              LanguageCubit myCubit = LanguageCubit.get(context);
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Choose your language:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      LanguageCard(
                          color: myCubit.isArabic == false
                              ? selectedColor
                              : Colors.white,
                          language: 'English',
                          imageLanguage: 'english',
                          function: () {
                            myCubit.chooseEnglish();
                          }),
                      LanguageCard(
                          color: myCubit.isArabic == true
                              ? selectedColor
                              : Colors.white,
                          language: 'Arabic',
                          imageLanguage: 'arabic',
                          function: () {
                            myCubit.chooseArabic();
                          })
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Visibility(
                      visible: myCubit.isVisible,
                      child: Center(
                          child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        greenButtonColor),
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)))),
                            onPressed: () {
                              CacheHelper.saveData(
                                  key: 'languageChoosen', value: true);
                              if (isEdit == false && chosenLanguageType == 0) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignInScreen(),
                                    ));
                              } else if (chosenLanguageType == 1) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const BottomDashBarScreen(),
                                    ),
                                    (route) => false);
                              } else if (chosenLanguageType == 2) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const BottomNavBarScreen(),
                                    ),
                                    (route) => false);
                              }
                            },
                            child:  Text(text[chosenLanguage]!['Next']!)),
                      )),
                    ),
                  )
                ],
              );
            }),
      )),
    );
  }
}
