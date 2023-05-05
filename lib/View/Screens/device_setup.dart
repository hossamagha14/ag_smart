import 'package:ag_smart/View%20Model/bloc/Stations/station_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Stations/station_states.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/toasts.dart';
import 'package:ag_smart/View/Reusable/main_card.dart';
import 'package:ag_smart/View/Reusable/my_text_field.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Screens/device_features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Reusable/main_icons_row_widget.dart';

// ignore: must_be_immutable
class DeviceSetupScreen extends StatefulWidget {
  final String serial;
  const DeviceSetupScreen({Key? key, required this.serial}) : super(key: key);

  @override
  State<DeviceSetupScreen> createState() => _DeviceSetupScreenState();
}

class _DeviceSetupScreenState extends State<DeviceSetupScreen> {
  TextEditingController changeNameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    changeNameController.text = widget.serial;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(text[chosenLanguage]!['Device Setup']!),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                children: [
                  BlocConsumer<StationsCubit, StationsStates>(
                    listener: (context, state) {
                      if (state is StationsAddToDBSuccessState) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DeviceFeaturesScreen(
                                isEdit: false,
                              ),
                            ));
                      } else if (state is StationsAddToDBSuccessState) {
                        errorToast('An error has occurred');
                      }
                    },
                    builder: (context, state) {
                      StationsCubit myCubit = StationsCubit.get(context);
                      return MainCard(
                        function: () {
                          if (changeNameController.text.isEmpty) {
                            errorToast('Please fill all the data');
                          } else {
                            myCubit.postStation(context,
                                stationName: changeNameController.text);
                          }
                        },
                        //this is the widget from main_card.dart
                        mainWidget: Column(
                          children: [
                            MyTextField(
                              label:
                                  text[chosenLanguage]!['Change network name']!,
                              controller: changeNameController,
                              color: backgroundColor,
                            ),
                          ],
                        ),
                        rowWidget: const MainIconsRowWidget(
                          icon1: 'm',
                        ),
                        buttonColor: greenButtonColor,
                        buttonTitle: 'Next',
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
