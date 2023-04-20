import 'package:ag_smart/View%20Model/bloc/Bottom%20navigation%20bar/bottom_nav_bar_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Bottom%20navigation%20bar/bottom_nav_bar_states.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/toasts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Reusable/main_card02.dart';
import '../Reusable/main_icons_row_widget.dart';
import '../Reusable/text.dart';
import 'edit_settings.dart';

class ManualIrrigationScreen extends StatelessWidget {
  const ManualIrrigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Station info.'),
      ),
      body: BlocConsumer<BottomNavBarCubit, BottomNavBarStates>(
        listener: (context, state) {
          if (state is BottomNavBarPutSuccessState) {
            successToast('Data sent successfully');
          } else if (state is BottomNavBarPutFailState) {
            errorToast('An error has occured');
          }
        },
        builder: (context, state) {
          BottomNavBarCubit myCubit = BottomNavBarCubit.get(context);
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Column(
                children: [
                  MainCard2(
                      cardtitle: 'Manual operation',
                      buttonColor: settingsColor,
                      rowWidget: const MainIconsRowWidget(
                        icon1: 'm',
                        icon2: 'f',
                      ),
                      buttonTitle: const Text('Settings'),
                      mainWidget: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.41,
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                decoration: BoxDecoration(
                                    color: backgroundColor,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.04),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Line ${index + 1}',
                                      ),
                                      const Spacer(),
                                      Center(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.17,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.035,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.next,
                                            controller: myCubit
                                                .manualList[index].controller,
                                                
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: text[chosenLanguage]![
                                                  'Duration'],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                            itemCount: myCubit.manualList.length),
                      ),
                      button: Row(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width * 0.4395,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            settingsColor),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.zero,
                                                topRight: Radius.zero,
                                                bottomLeft: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(0))))),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const EditSettingsScreen(),
                                      ));
                                },
                                child:
                                    Text(text[chosenLanguage]!['Settings']!)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: MediaQuery.of(context).size.width * 0.4395,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.grey),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.zero,
                                                topRight: Radius.zero,
                                                bottomLeft: Radius.circular(0),
                                                bottomRight:
                                                    Radius.circular(20))))),
                                onPressed: () {
                                  bool allFull = true;
                                  for (int i = 0;
                                      i < myCubit.manualList.length;
                                      i++) {
                                    if (myCubit.manualList[i].controller.text
                                        .isEmpty) {
                                      allFull = false;
                                    }
                                  }
                                  if (allFull == true) {
                                    myCubit.putmanualDurationList(statioId: 1);
                                  } else {
                                    errorToast(
                                        'Please put durations for all valves');
                                  }
                                },
                                child: const Text('Start operation')),
                          )
                        ],
                      ),
                      function: () {})
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
