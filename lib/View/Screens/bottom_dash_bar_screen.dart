import 'package:ag_smart/View%20Model/bloc/Bottom%20Dash%20bar/bottom_dash_bar_states.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../View Model/bloc/Bottom Dash bar/bottom_dash_bar_cubit.dart';
import 'choose_language.dart';

class BottomDashBarScreen extends StatelessWidget {
  const BottomDashBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomDashBarCubit(),
      child: BlocConsumer<BottomDashBarCubit, BottomDashBarStates>(
          listener: (context, state) {},
          builder: (context, state) {
            BottomDashBarCubit myCubit = BottomDashBarCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text(myCubit.index == 0
                    ? text[chosenLanguage]!['Dashboard']!
                    : text[chosenLanguage]!['Report']!),
              ),
              endDrawer: chosenLanguage == 'ar'
                  ? Drawer(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          DrawerHeader(
                            decoration: BoxDecoration(
                              color: settingsColor,
                            ),
                            child: Text(
                              stationName,
                              style: const TextStyle(
                                  fontSize: 21,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          ListTile(
                            title: Text(text[chosenLanguage]!['Contact us']!,
                                textDirection: chosenLanguage == 'ar'
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: iconColor,
                                    fontWeight: FontWeight.w500)),
                            onTap: () {},
                          ),
                          ListTile(
                            title: Text(text[chosenLanguage]!['About us']!,
                                textDirection: chosenLanguage == 'ar'
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: iconColor,
                                    fontWeight: FontWeight.w500)),
                            onTap: () {},
                          ),
                          ListTile(
                            title: Text(
                                text[chosenLanguage]!['Change language']!,
                                textDirection: chosenLanguage == 'ar'
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: iconColor,
                                    fontWeight: FontWeight.w500)),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ChooseLanguageScreen(
                                            isEdit: true,
                                            chosenLanguageType: 1),
                                  ));
                            },
                          ),
                          ListTile(
                            title: Text(text[chosenLanguage]!['Log out']!,
                                textDirection: chosenLanguage == 'ar'
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: iconColor,
                                    fontWeight: FontWeight.w500)),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    actionsAlignment: MainAxisAlignment.center,
                                    titlePadding: const EdgeInsets.fromLTRB(
                                        15, 10, 15, 30),
                                    actionsPadding:
                                        const EdgeInsets.only(bottom: 20),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    title: Text(
                                      text[chosenLanguage]!['Sure']!,
                                      textDirection: chosenLanguage == 'ar'
                                          ? TextDirection.rtl
                                          : TextDirection.ltr,
                                    ),
                                    actions: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.04,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.15,
                                              decoration: BoxDecoration(
                                                  color: greenButtonColor,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Center(
                                                  child: Text(
                                                      text[chosenLanguage]![
                                                          'No']!))),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: InkWell(
                                          onTap: () {},
                                          child: Text(
                                              text[chosenLanguage]!['Yes']!),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  : null,
              drawer: chosenLanguage == 'en'
                  ? Drawer(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          DrawerHeader(
                            decoration: BoxDecoration(
                              color: settingsColor,
                            ),
                            child: Text(
                              stationName,
                              style: const TextStyle(
                                  fontSize: 21,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          ListTile(
                            title: Text(text[chosenLanguage]!['Contact us']!,
                                textDirection: chosenLanguage == 'ar'
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: iconColor,
                                    fontWeight: FontWeight.w500)),
                            onTap: () {},
                          ),
                          ListTile(
                            title: Text(text[chosenLanguage]!['About us']!,
                                textDirection: chosenLanguage == 'ar'
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: iconColor,
                                    fontWeight: FontWeight.w500)),
                            onTap: () {},
                          ),
                          ListTile(
                            title: Text(
                                text[chosenLanguage]!['Change language']!,
                                textDirection: chosenLanguage == 'ar'
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: iconColor,
                                    fontWeight: FontWeight.w500)),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ChooseLanguageScreen(
                                            isEdit: true,
                                            chosenLanguageType: 1),
                                  ));
                            },
                          ),
                          ListTile(
                            title: Text(text[chosenLanguage]!['Log out']!,
                                textDirection: chosenLanguage == 'ar'
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: iconColor,
                                    fontWeight: FontWeight.w500)),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    actionsAlignment: MainAxisAlignment.center,
                                    titlePadding: const EdgeInsets.fromLTRB(
                                        15, 10, 15, 30),
                                    actionsPadding:
                                        const EdgeInsets.only(bottom: 20),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    title: Text(
                                      text[chosenLanguage]!['Sure']!,
                                      textDirection: chosenLanguage == 'ar'
                                          ? TextDirection.rtl
                                          : TextDirection.ltr,
                                    ),
                                    actions: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.04,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.15,
                                              decoration: BoxDecoration(
                                                  color: greenButtonColor,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Center(
                                                  child: Text(
                                                      text[chosenLanguage]![
                                                          'No']!))),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: InkWell(
                                          onTap: () {},
                                          child: Text(
                                              text[chosenLanguage]!['Yes']!),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  : null,
              bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: backgroundColor,
                  elevation: 0,
                  onTap: (value) {
                    myCubit.chooseIndex(value);
                  },
                  currentIndex: myCubit.index,
                  items: [
                    BottomNavigationBarItem(
                        label: text[chosenLanguage]!['Dashboard']!,
                        icon: Text(
                          'a',
                          style: TextStyle(
                              fontFamily: 'icons',
                              fontSize: 25,
                              color: myCubit.index == 0
                                  ? Colors.blue
                                  : Colors.black54),
                        )),
                    BottomNavigationBarItem(
                        label: 'Report',
                        icon: Text(
                          's',
                          style: TextStyle(
                              fontFamily: 'icons',
                              fontSize: 25,
                              color: myCubit.index == 1
                                  ? Colors.blue
                                  : Colors.black54),
                        )),
                  ]),
              body: myCubit.bottomDashBarScreens[myCubit.index],
            );
          }),
    );
  }
}
