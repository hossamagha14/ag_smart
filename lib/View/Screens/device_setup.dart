import 'package:ag_smart/View%20Model/bloc/Stations/station_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/commom_states.dart';
import 'package:ag_smart/View%20Model/database/cache_helpher.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/toasts.dart';
import 'package:ag_smart/View/Reusable/main_card.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../View Model/Repo/auth_bloc.dart';
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
  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
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
                  BlocConsumer<StationsCubit, CommonStates>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      StationsCubit myCubit = StationsCubit.get(context);
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
                        child: MainCard(
                          function: () {
                            if (changeNameController.text.isEmpty) {
                              errorToast('Please put the station name');
                            } else {
                              CacheHelper.saveData(
                                  key: 'stationName',
                                  value: changeNameController.text);
                              stationName =
                                  CacheHelper.getData(key: 'stationName');
                              myCubit.postStation(context,
                                  stationName: changeNameController.text);
                            }
                          },
                          //this is the widget from main_card.dart
                          mainWidget: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  decoration: BoxDecoration(
                                      color: backgroundColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    child: Row(
                                      textDirection: chosenLanguage == 'ar'
                                          ? TextDirection.rtl
                                          : TextDirection.ltr,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.635,
                                          child: TextFormField(
                                            textDirection:
                                                chosenLanguage == 'ar'
                                                    ? TextDirection.rtl
                                                    : TextDirection.ltr,
                                            controller: changeNameController,
                                            textAlign: TextAlign.start,
                                            // the widget between the top row (Agritopia1) and the next button
                                            decoration: InputDecoration(
                                              hintTextDirection:
                                                  chosenLanguage == 'ar'
                                                      ? TextDirection.rtl
                                                      : TextDirection.ltr,
                                              label: Text(text[chosenLanguage]![
                                                  'Station name']!),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          rowWidget: const MainIconsRowWidget(
                            icon1: 'm',
                          ),
                          buttonColor: greenButtonColor,
                          buttonTitle: text[chosenLanguage]!['Next']!,
                        ),
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
