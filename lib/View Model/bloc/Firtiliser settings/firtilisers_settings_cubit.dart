import 'package:ag_smart/Model/firtiliser_model.dart';
import 'package:ag_smart/View%20Model/database/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firtiliser_settings_states.dart';

class FirtiliserSettingsCubit extends Cubit<FirtiliserSettingsStates> {
  FirtiliserSettingsCubit() : super(FirtiliserSettingsIntialState());

  static FirtiliserSettingsCubit get(context) => BlocProvider.of(context);

  int index = 1;
  List<String> dateStringList = [];
  List<String> timeStringList = [];
  FirtiliserModel firtiliserModel = FirtiliserModel();
  List<String> controllersStringList = [];
  bool done = false;
  bool? accordingToTime;
  bool? seriesFertilization;
  int? method1;
  int? method2;
  var dio = Dio();

  chooseTime(value, int containerIndex) {
    firtiliserModel.timeList[containerIndex] = value;
    emit(FirtiliserSettingsChooseTimeState());
  }

  chooseDate(value, int containerIndex) {
    firtiliserModel.dateList[containerIndex] = value;
    emit(FirtiliserSettingsChooseDateState());
  }

  addContainer() {
    index++;
    firtiliserModel.dateList.add(DateTime.now());
    firtiliserModel.timeList.add(TimeOfDay.now());
    firtiliserModel.controllersList.add(TextEditingController());
    emit(FirtiliserSettingsAddContainerState());
  }

  removeContainer() {
    index--;
    firtiliserModel.dateList.remove(DateTime.now());
    firtiliserModel.timeList.remove(TimeOfDay.now());
    firtiliserModel.controllersList.remove(TextEditingController());
    emit(FirtiliserSettingsAddContainerState());
  }

  issDone() {
    done = true;
    emit(FirtiliserSettingsIsDoneState());
  }

  firtiliseAccordingToTime() {
    accordingToTime = true;
    method2 = 1;
    emit(FirtiliserSettingsAccordingToTimeState());
  }

  firtiliseAccordingToQuantity() {
    accordingToTime = false;
    method2 = 2;
    emit(FirtiliserSettingssAccordingToQuantityState());
  }

  chooseSeriesFertilization() {
    seriesFertilization = true;
    method1 = 1;
    emit(FirtiliserSettingsSeriesState());
  }

  chooseParallelFertilization() {
    seriesFertilization = false;
    method1 = 2;
    emit(FirtiliserSettingssParallelState());
  }

  getData(context) {
    dateStringList = [];
    timeStringList = [];
    controllersStringList = [];
    for (int i = 0; i < index; i++) {
      dateStringList.add(firtiliserModel.dateList[i].toString());
      timeStringList
          .add(firtiliserModel.timeList[i].format(context).toString());
      controllersStringList.add(firtiliserModel.controllersList[i].text);
    }
  }

  putFertilizationSettings({
    required int stationId,
    required int ferMethod1,
    required int ferMethod2,
  }) async {
    await dio.put('$base/$fertilizerSettings/$stationId', data: {
      "station_id": stationId,
      "fertilization_method_1": ferMethod1,
      "fertilization_method_2": ferMethod2
    }).then((value) {
      print(value.data);
      emit(FirtiliserSettingsSendSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(FirtiliserSettingsSendFailState());
    });
  }
}
