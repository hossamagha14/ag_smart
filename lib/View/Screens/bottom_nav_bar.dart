import 'package:ag_smart/View%20Model/bloc/Bottom%20navigation%20bar/bottom_nav_bar_cubit.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../View Model/bloc/commom_states.dart';

class BottomNavBarScreen extends StatelessWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavBarCubit()..getStation(stationId),
      child: BlocConsumer<BottomNavBarCubit, CommonStates>(
          listener: (context, state) {
        if (state is ExpiredTokenState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => SignInScreen(),
              ),
              (route) => false);
        }
      }, builder: (context, state) {
        BottomNavBarCubit myCubit = BottomNavBarCubit.get(context);
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: backgroundColor,
              elevation: 0,
              onTap: (value) {
                myCubit.chooseIndex(value);
              },
              currentIndex: myCubit.index,
              items: [
                BottomNavigationBarItem(
                    label: 'Home',
                    icon: Text(
                      'i',
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
                BottomNavigationBarItem(
                    label: 'Settings',
                    icon: Text(
                      'q',
                      style: TextStyle(
                          fontFamily: 'icons',
                          fontSize: 25,
                          color: myCubit.index == 2
                              ? Colors.blue
                              : Colors.black54),
                    )),
              ]),
          body: myCubit.bottomNavBarScreens == null
              ? const Center(child: CircularProgressIndicator())
              : myCubit.bottomNavBarScreens![myCubit.index],
        );
      }),
    );
  }
}
