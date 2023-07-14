import 'package:ag_smart/View%20Model/bloc/commom_states.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/main_button.dart';
import 'package:ag_smart/View/Reusable/toasts.dart';
import 'package:ag_smart/View/Screens/device_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../View Model/bloc/Bottom navigation bar/bottom_nav_bar_cubit.dart';
import '../../View Model/bloc/Bottom navigation bar/bottom_nav_bar_states.dart';
import '../Reusable/text.dart';
import 'bottom_dash_bar_screen.dart';

class EditSettingsScreen extends StatefulWidget {
  final String serial;
  const EditSettingsScreen({Key? key, required this.serial}) : super(key: key);

  @override
  State<EditSettingsScreen> createState() => _EditSettingsScreenState();
}

class _EditSettingsScreenState extends State<EditSettingsScreen> {
  late BottomNavBarCubit bottomNavBarCubit;

  @override
  void initState() {
    bottomNavBarCubit = BlocProvider.of<BottomNavBarCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text[chosenLanguage]!['Change station name']!),
      ),
      body: BlocConsumer<BottomNavBarCubit, CommonStates>(
          listener: (context, state) {
        if (state is BottomNavBarDeleteSuccessState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomDashBarScreen(),
              ),
              (route) => false);
          successToast(context, text[chosenLanguage]!['delete suc']!);
        } else if (state is BottomNavBarDeleteFailState) {
          errorToast(context, text[chosenLanguage]!['delete err']!);
        }
      }, builder: (context, state) {
        BottomNavBarCubit myCubit = BottomNavBarCubit.get(context);
        return Center(
          child: state is BottomNavBarDeleteLoadingState
              ? const CircularProgressIndicator()
              : SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Card(
                      color: Colors.white,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MainButton(
                              buttonLabel:
                                  text[chosenLanguage]!['Change station name']!,
                              function: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DeviceSetupScreen(
                                          serial: widget.serial, isEdit: true),
                                    ));
                              }),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          MainButton(
                              color: Colors.red,
                              buttonLabel:
                                  text[chosenLanguage]!['Factory reset']!,
                              function: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    content: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.27,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            text[chosenLanguage]![
                                                'delete msg']!,
                                            style: const TextStyle(
                                                color: Colors.black87),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  myCubit.deleteStation();
                                                },
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.09,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.05,
                                                  child: FittedBox(
                                                    child: Text(
                                                      text[chosenLanguage]![
                                                          'Yes']!,
                                                      style: TextStyle(
                                                          color: iconColor),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.15,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.05,
                                                  child: FittedBox(
                                                    child: Text(
                                                      text[chosenLanguage]![
                                                          'Cancel']!,
                                                      style: const TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })
                        ],
                      )),
                ),
        );
      }),
    );
  }
}
