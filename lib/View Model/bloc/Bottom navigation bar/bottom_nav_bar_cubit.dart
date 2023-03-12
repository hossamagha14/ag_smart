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

import '../../database/end_points.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarStates> {
  BottomNavBarCubit() : super(BottomNavBarIntialState());

  static BottomNavBarCubit get(context) => BlocProvider.of(context);
  var dio = Dio();
  static int settingsType = 0;
  StationModel? stationModel;
  List<Widget>? bottomNavBarScreens;
  List<int> activeValves = [];
  int index = 0;

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
      print(value.data);
      print(settingsType);
      if (value.statusCode == 200) {
        getActiveValves(decimalNumber: stationModel!.irrigationSettings![0].activeValves!);
        emit(BottomNavBarGetSuccessState());
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(BottomNavBarGetFailState());
    });
  }

  List<int> getActiveValves({required int decimalNumber}) {
    activeValves=[];
    while (decimalNumber > 0) {
      int n = (decimalNumber % 2);
      activeValves.add(n);
      double x = decimalNumber / 2;
      decimalNumber = x.toInt();
    }
    
    print(activeValves);
    return activeValves;
  }
}
