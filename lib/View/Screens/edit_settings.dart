import 'package:ag_smart/View%20Model/bloc/commom_states.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/main_button.dart';
import 'package:ag_smart/View/Reusable/toasts.dart';
import 'package:ag_smart/View/Screens/device_setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../View Model/bloc/Bottom navigation bar/bottom_nav_bar_cubit.dart';
import '../../View Model/bloc/Bottom navigation bar/bottom_nav_bar_states.dart';
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
        title: const Text('Edit settings'),
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
          successToast(context, 'Station was deleted successfully');
        } else if (state is BottomNavBarDeleteFailState) {
          errorToast(
              context, 'An error has occurred while deleting the station');
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
                              buttonLabel: 'Edit station name',
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
                              buttonLabel: 'Factory reset',
                              function: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    content: Stack(
                                      alignment: AlignmentDirectional.topEnd,
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.27,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          color: Colors.white,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Text(
                                                'Are you sure you want to delete this station?',
                                                style: TextStyle(
                                                    color: Colors.black87),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      myCubit.deleteStation();
                                                    },
                                                    child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.09,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.05,
                                                      child: FittedBox(
                                                        child: Text(
                                                          'Yes',
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
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.15,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.05,
                                                      child: const FittedBox(
                                                        child: Text(
                                                          'Cancel',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Icon(Icons.close)),
                                        )
                                      ],
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
