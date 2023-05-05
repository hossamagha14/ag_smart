// ignore_for_file: file_names

import 'package:ag_smart/View%20Model/bloc/Stations/station_cubit.dart';
import 'package:ag_smart/View%20Model/bloc/Stations/station_states.dart';
import 'package:ag_smart/View%20Model/database/cache_helpher.dart';
import 'package:ag_smart/View/Reusable/colors.dart';
import 'package:ag_smart/View/Reusable/toasts.dart';
import 'package:ag_smart/View/Screens/bottom_nav_bar.dart';
import 'package:ag_smart/View/Screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashsboardScreen extends StatelessWidget {
  const DashsboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: SafeArea(
          child: BlocConsumer<StationsCubit, StationsStates>(
        listener: (context, state) {
          if (state is StationsGetFailState) {
            errorToast('Something went wrong');
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => SignInScreen(),
                ),
                (route) => false);
          }else if(state is StationsFailQrState){
            errorToast('Serial number couldn\'t be found');
          }
        },
        builder: (context, state) {
          StationsCubit myCubit = StationsCubit.get(context);
          return state is StationsLoadinglState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.95,
                            height: MediaQuery.of(context).size.height * 0.075,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              elevation: 10,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30))),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              const Color(0xFF42C4FF))),
                                  onPressed: () {
                                    myCubit.scan(context);
                                  },
                                  child: const Text(
                                    '[ + ]  Add Device',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  )),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.95,
                          height: MediaQuery.of(context).size.height,
                          child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    CacheHelper.saveData(
                                        key: 'serialNumber',
                                        value: myCubit
                                            .stations[index].serialNumber!);
                                    CacheHelper.saveData(
                                        key: 'stationId',
                                        value: myCubit.stations[index].id!);
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const BottomNavBarScreen(),
                                        ),
                                        (route) => false);
                                  },
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    child: Card(
                                      elevation: 8,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 30),
                                            child: Text(
                                                myCubit.stations[index].stationName!),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 30),
                                            child: Row(
                                              children: [
                                                Text(
                                                  myCubit
                                                              .stations[index]
                                                              .irrigationSettings![
                                                                  0]
                                                              .settingsType ==
                                                          1
                                                      ? 'r'
                                                      : myCubit
                                                                  .stations[
                                                                      index]
                                                                  .irrigationSettings![
                                                                      0]
                                                                  .settingsType ==
                                                              2
                                                          ? 't'
                                                          : 'f',
                                                  style: TextStyle(
                                                      fontFamily: 'icons',
                                                      color: iconColor,
                                                      fontSize: 25),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.025,
                                                ),
                                                Text(
                                                  'm',
                                                  style: TextStyle(
                                                      fontFamily: 'icons',
                                                      color: iconColor,
                                                      fontSize: 25),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.007,
                                );
                              },
                              itemCount: myCubit.stations.length),
                        ),
                      ],
                    ),
                  ),
                );
        },
      )),
    );
  }
}
