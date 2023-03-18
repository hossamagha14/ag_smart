import 'package:ag_smart/Model/station_model.dart';
import 'package:ag_smart/View%20Model/bloc/Bottom%20navigation%20bar/bottom_nav_bar_states.dart';
import 'package:ag_smart/View/Screens/auto.dart';
import 'package:ag_smart/View/Screens/custom_station_info.dart';
import 'package:ag_smart/View/Screens/report.dart';
import 'package:ag_smart/View/Screens/settings.dart';
import 'package:ag_smart/View/Screens/station_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Model/custom_irrigation_model.dart';
import '../../../Model/days_model.dart';
import '../../database/end_points.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarStates> {
  BottomNavBarCubit() : super(BottomNavBarIntialState());

  static BottomNavBarCubit get(context) => BlocProvider.of(context);
  var dio = Dio();
  static int settingsType = 0;
  StationModel? stationModel;
  List<Widget>? bottomNavBarScreens;
  List<int> activeValves = [];
  List<int> activeDays = [];
  List<List<int>> customActiveDays = [];
  int index = 0;
  List<CustomIrrigationModel> customIrrigationModelList = [];
  List<DaysModel> days = [
    DaysModel(day: 'SAT', isOn: false),
    DaysModel(day: 'SUN', isOn: false),
    DaysModel(day: 'MON', isOn: false),
    DaysModel(day: 'TUE', isOn: false),
    DaysModel(day: 'WED', isOn: false),
    DaysModel(day: 'THU', isOn: false),
    DaysModel(day: 'FRI', isOn: false),
  ];

  chooseIndex(int value) {
    index = value;
    emit(BottomNavBarChooseScreenState());
  }

  getStation(int stationId) async {
    emit(BottomNavBarLoadingState());
    await dio.get('$base/$stationInfo/$stationId').then((value) {
      stationModel = StationModel.fromJson(value.data);
      settingsType = stationModel!.irrigationSettings![0].settingsType!;
      if (settingsType == 1 || settingsType == 2) {
        bottomNavBarScreens = [
          const StationInfoScreen(),
          const ReportScreen(),
          const SettingsScreen()
        ];
      } else if (settingsType == 3) {
        bottomNavBarScreens = [
          const CustomStationInfoScreen(),
          const ReportScreen(),
          const SettingsScreen()
        ];
      } else if (settingsType == 4) {
        bottomNavBarScreens = [
          const AutoScreen(),
          const ReportScreen(),
          const SettingsScreen()
        ];
      }

      if (value.statusCode == 200) {
        customActiveDays = [];
        getActiveValves(
            decimalNumber: stationModel!.irrigationSettings![0].activeValves!);
        if (settingsType == 1 || settingsType == 2) {
          stationModel!.irrigationSettings![0].irrigationPeriods!.isEmpty
              ? getActiveDays(
                  decimalNumber: stationModel!
                      .irrigationSettings![0].irrigationCycles![0].weekDays!)
              : getActiveDays(
                  decimalNumber: stationModel!
                      .irrigationSettings![0].irrigationPeriods![0].weekDays!);
        } else if (settingsType == 3) {
          for (int valve = 0;
              valve <
                  stationModel!
                      .irrigationSettings![0].customValvesSettings!.length;
              valve++) {
            stationModel!.irrigationSettings![0].customValvesSettings![valve]
                    .irrigationPeriods!.isNotEmpty
                ? customActiveDays.add(getActiveDays(
                    decimalNumber: stationModel!
                        .irrigationSettings![0]
                        .customValvesSettings![valve]
                        .irrigationPeriods![0]
                        .weekDays!))
                : stationModel!
                        .irrigationSettings![0]
                        .customValvesSettings![valve]
                        .irrigationCycles!
                        .isNotEmpty
                    ? customActiveDays.add(getActiveDays(
                        decimalNumber: stationModel!
                            .irrigationSettings![0]
                            .customValvesSettings![valve]
                            .irrigationCycles![0]
                            .weekDays!))
                    : customActiveDays.add([]);
          }
        }
        emit(BottomNavBarGetSuccessState());
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(BottomNavBarGetFailState());
    });
  }

  getActiveValves({required int decimalNumber}) {
    activeValves = [];
    while (decimalNumber > 0) {
      int n = (decimalNumber % 2);
      activeValves.add(n);
      double x = decimalNumber / 2;
      decimalNumber = x.toInt();
    }
  }

  List<int> getActiveDays({required int decimalNumber}) {
    activeDays = [];
    while (decimalNumber > 0) {
      int n = (decimalNumber % 2);
      activeDays.add(n);
      double x = decimalNumber / 2;
      decimalNumber = x.toInt();
    }
    while (activeDays.length < 7) {
      activeDays.add(0);
    }
    return activeDays;
  }
}
