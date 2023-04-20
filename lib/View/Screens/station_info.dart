import 'package:ag_smart/View%20Model/bloc/Bottom%20navigation%20bar/bottom_nav_bar_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Bottom%20navigation%20bar/bottom_nav_bar_states.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/firtilisers_scarcrow_light_widget.dart';
import 'package:ag_smart/View/Reusable/get_choosen_days.dart';
import 'package:ag_smart/View/Reusable/main_card.dart';
import 'package:ag_smart/View/Reusable/main_icons_row_widget.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:ag_smart/View/Screens/edit_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StationInfoScreen extends StatelessWidget {
  const StationInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text[chosenLanguage]!['Station info']!),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: BlocConsumer<BottomNavBarCubit, BottomNavBarStates>(
            listener: (context, state) {},
            builder: (context, state) {
              BottomNavBarCubit myCubit = BottomNavBarCubit.get(context);
              return myCubit.stationModel == null
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        MainCard(
                          function: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const EditSettingsScreen(),
                                ));
                          },
                          mainWidget: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              const GetChooseDyasWidget(),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.36,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: ListView.separated(
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Visibility(
                                          visible:
                                              myCubit.activeValves[index] == 0
                                                  ? false
                                                  : true,
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.05,
                                            decoration: BoxDecoration(
                                                color: backgroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text('Line ${index + 1}'),
                                                  const Spacer()
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return Visibility(
                                          visible:
                                              myCubit.activeValves[index] == 0
                                                  ? false
                                                  : true,
                                          child: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          ),
                                        );
                                      },
                                      itemCount: myCubit.activeValves.length)),
                              const FirScarLightWidget()
                            ],
                          ),
                          rowWidget: MainIconsRowWidget(
                            icon1: 'm',
                            icon2: myCubit.stationModel!.irrigationSettings![0]
                                        .settingsType ==
                                    1
                                ? 'r'
                                : 't',
                            icon3: myCubit.stationModel!.irrigationSettings![0]
                                        .irrigationMethod1 ==
                                    2
                                ? 'u'
                                : 'w',
                            icon4: myCubit.stationModel!.irrigationSettings![0]
                                        .irrigationMethod2 ==
                                    1
                                ? 'x'
                                : 'c',
                          ),
                          buttonColor: settingsColor,
                          buttonTitle: text[chosenLanguage]!['Settings']!,
                          buttonIcon: const Text(
                            'q',
                            style: TextStyle(fontFamily: 'icons', fontSize: 25),
                          ),
                        ),
                      ],
                    );
            }),
      ),
    );
  }
}
