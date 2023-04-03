import 'package:ag_smart/Model/manual_moodel.dart';
import 'package:ag_smart/Model/station_model.dart';
import 'package:ag_smart/View%20Model/bloc/Bottom%20navigation%20bar/bottom_nav_bar_states.dart';
import 'package:ag_smart/View%20Model/database/cache_helpher.dart';
import 'package:ag_smart/View/Screens/auto.dart';
import 'package:ag_smart/View/Screens/custom_station_info.dart';
import 'package:ag_smart/View/Screens/manual_irrigation.dart';
import 'package:ag_smart/View/Screens/report.dart';
import 'package:ag_smart/View/Screens/settings.dart';
import 'package:ag_smart/View/Screens/station_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Model/custom_irrigation_model.dart';
import '../../../Model/days_model.dart';
import '../../../View/Reusable/text.dart';
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
  ManualModel? manualModel;
  List<ManualModel> manualList = [];
  List<Map<String, dynamic>> manualDurationsList = [];
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
      } else if (settingsType == 5) {
        bottomNavBarScreens = [
          const ManualIrrigationScreen(),
          const ReportScreen(),
          const SettingsScreen()
        ];
      }

      if (value.statusCode == 200) {
        CacheHelper.saveData(
            key: 'features', value: stationModel!.routes![0].features);
        CacheHelper.saveData(
            key: 'valveInfo', value: stationModel!.routes![0].valveInfo);
        CacheHelper.saveData(
            key: 'irrigationSettings',
            value: stationModel!.routes![0].irrigationSettings);
        CacheHelper.saveData(
            key: 'irrigationPeriods',
            value: stationModel!.routes![0].irrigationPeriods);
        CacheHelper.saveData(
            key: 'irrigationCycle',
            value: stationModel!.routes![0].irrigationCycle);
        CacheHelper.saveData(
            key: 'fertilizerPeriods',
            value: stationModel!.routes![0].fertilizerPeriods);
        CacheHelper.saveData(
            key: 'fertilizerSettings',
            value: stationModel!.routes![0].fertilizerSettings);
        CacheHelper.saveData(
            key: 'animalRepellent',
            value: stationModel!.routes![0].animalRepellent);
        CacheHelper.saveData(
            key: 'light', value: stationModel!.routes![0].light);
        CacheHelper.saveData(
            key: 'irrigationPeriodsList',
            value: stationModel!.routes![0].irrigationPeriodsList);
        CacheHelper.saveData(
            key: 'fertilizerPeriodsList',
            value: stationModel!.routes![0].fertilizerPeriodsList);
        CacheHelper.saveData(
            key: 'valveSettingsDelete',
            value: stationModel!.routes![0].valveSettingsDelete);
        CacheHelper.saveData(
            key: 'fertilizerSettingsDelete',
            value: stationModel!.routes![0].fertilizerSettingsDelete);
        CacheHelper.saveData(
            key: 'customIrrigationSettings',
            value: stationModel!.routes![0].customIrrigationSettings);
        CacheHelper.saveData(
            key: 'getCustomIrrigationSettings',
            value: stationModel!.routes![0].getCustomIrrigationSettings);
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
            customIrrigationModelList.add(CustomIrrigationModel(
                accordingToHour: null, accordingToQuantity: null));
            if (stationModel!.irrigationSettings![0]
                .customValvesSettings![valve].irrigationPeriods!.isNotEmpty) {
              customActiveDays.add(getActiveDays(
                  decimalNumber: stationModel!
                      .irrigationSettings![0]
                      .customValvesSettings![valve]
                      .irrigationPeriods![0]
                      .weekDays!));
              customIrrigationModelList[valve].statusType = 2;
            } else if (stationModel!.irrigationSettings![0]
                .customValvesSettings![valve].irrigationCycles!.isNotEmpty) {
              customActiveDays.add(getActiveDays(
                  decimalNumber: stationModel!
                      .irrigationSettings![0]
                      .customValvesSettings![valve]
                      .irrigationCycles![0]
                      .weekDays!));
              customIrrigationModelList[valve].statusType = 3;
            } else {
              customActiveDays.add([]);
              customIrrigationModelList[valve].statusType = 1;
            }
          }
          for (int valve = 0;
              valve <
                  stationModel!.fertilizationSettings![0]
                      .customFertilizerSettings!.length;
              valve++) {
            if (stationModel!
                .fertilizationSettings![0].customFertilizerSettings![valve].fertilizerPeriods!.isEmpty) {
              customIrrigationModelList[valve].fertilizationStatusType = 2;
            } else {
              customIrrigationModelList[valve].fertilizationStatusType = 1;
            }
          }
        } else if (settingsType == 5) {
          getManualValves(stationId: stationId);
        }
        print('$numOfActiveLines number of active lines');
        emit(BottomNavBarGetSuccessState());
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(BottomNavBarGetFailState());
    });
  }

  getActiveValves({required int decimalNumber}) {
    activeValves = [];
    int numberOfOnValves = 0;
    while (decimalNumber > 0) {
      int n = (decimalNumber % 2);
      activeValves.add(n);
      double x = decimalNumber / 2;
      decimalNumber = x.toInt();
    }
    for (int i = 0; i < activeValves.length; i++) {
      if (activeValves[i] == 1) {
        numberOfOnValves++;
      }
    }
    CacheHelper.saveData(key: 'numOfActiveLines', value: numberOfOnValves);
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

  getManualValves({required int stationId}) {
    dio.get('$base/$manualIrrigationSettings/$stationId').then((value) {
      for (var element in value.data) {
        manualModel = ManualModel.fromJson(element);
        manualList.add(manualModel!);
        print(manualList);
      }
      emit(BottomNavBarGetSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(BottomNavBarGetFailState());
    });
  }

  List<Map<String, dynamic>> makeList() {
    manualDurationsList = [];
    for (int i = 0; i < manualList.length; i++) {
      manualDurationsList
          .add({"valve_id": i + 1, "duration": manualList[i].controller.text});
    }
    return manualDurationsList;
  }

  putmanualDurationList({required int statioId}) {
    dio.put('$base/$manualIrrigationSettings/$stationId',
        data: {"list": makeList()}).then((value) {
      print(value.data);
      emit(BottomNavBarPutSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(BottomNavBarPutFailState());
    });
  }
}
