import 'package:ag_smart/View%20Model/bloc/Bottom%20Dash%20bar/bottom_dash_bar_states.dart';
import 'package:ag_smart/View%20Model/bloc/commom_states.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Reusable/toasts.dart';
import 'package:ag_smart/View/Screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../View Model/Repo/auth_bloc.dart';
import '../../View Model/bloc/Bottom Dash bar/bottom_dash_bar_cubit.dart';
import '../../View Model/database/cache_helpher.dart';
import 'about_us.dart';
import 'choose_language.dart';
import 'contact_us.dart';

class BottomDashBarScreen extends StatefulWidget {
  const BottomDashBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomDashBarScreen> createState() => _BottomDashBarScreenState();
}

class _BottomDashBarScreenState extends State<BottomDashBarScreen> {
  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomDashBarCubit(authBloc),
      child: BlocConsumer<BottomDashBarCubit, CommonStates>(
          listener: (context, state) {
        if (state is BottomDashBarLogOutSuccessState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => SignInScreen(),
              ),
              (route) => false);
        }
      }, builder: (context, state) {
        BottomDashBarCubit myCubit = BottomDashBarCubit.get(context);
        return BlocListener<AuthBloc, CommonStates>(
          listener: (context, state) {
            if (state is ExpiredTokenState) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ),
                  (route) => false);
              expiredTokenToast();
            }
            if (state is ServerDownState) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ),
                  (route) => false);
              serverDownToast();
            }
          },
          child: Scaffold(
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
                          child: const SizedBox(),
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
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ContactUsScreen(),
                                ));
                          },
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
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AboutUsScreen(),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text(text[chosenLanguage]!['Change language']!,
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
                                          isEdit: true, chosenLanguageType: 1),
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
                                  titlePadding:
                                      const EdgeInsets.fromLTRB(15, 10, 15, 30),
                                  actionsPadding:
                                      const EdgeInsets.only(bottom: 20),
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
                                                child: Text(text[
                                                    chosenLanguage]!['No']!))),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: InkWell(
                                        onTap: () {
                                          CacheHelper.remove(key: 'token');
                                          myCubit.logout();
                                        },
                                        child:
                                            Text(text[chosenLanguage]!['Yes']!),
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
                          child: const SizedBox(),
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
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ContactUsScreen(),
                                ));
                          },
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
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AboutUsScreen(),
                                ));
                          },
                        ),
                        ListTile(
                          title: Text(text[chosenLanguage]!['Change language']!,
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
                                          isEdit: true, chosenLanguageType: 1),
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
                                  titlePadding:
                                      const EdgeInsets.fromLTRB(15, 10, 15, 30),
                                  actionsPadding:
                                      const EdgeInsets.only(bottom: 20),
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
                                                child: Text(text[
                                                    chosenLanguage]!['No']!))),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: InkWell(
                                        onTap: () {
                                          CacheHelper.remove(key: 'token');
                                          myCubit.logout();
                                        },
                                        child:
                                            Text(text[chosenLanguage]!['Yes']!),
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
                      label: text[chosenLanguage]!['Report']!,
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
          ),
        );
      }),
    );
  }
}
