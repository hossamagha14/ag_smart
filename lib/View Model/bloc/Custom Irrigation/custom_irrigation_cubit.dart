import 'dart:math';

import 'package:ag_smart/Model/custom_cycle_model.dart';
import 'package:ag_smart/Model/custom_irrigation_model.dart';
import 'package:ag_smart/View%20Model/bloc/Custom%20Irrigation/custom_irrigation_states.dart';
import 'package:ag_smart/View%20Model/database/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Model/custom_period_model.dart';
import '../../../Model/irrigation_settings_model.dart';

class CustomIrrigationCubit extends Cubit<CustomIrrigationStates> {
  CustomIrrigationCubit() : super(CustomIrrigationIntialState());

  static CustomIrrigationCubit get(context) => BlocProvider.of(context);
  CustomIrrigationModel? customIrrigationModel;
  CustomCycleModel? customCycleModel;
  CustomPeriodModel? customPeriodModel;
  IrrigationSettingsModel? irrigationSettingsModel;
  bool visible = false;
  bool allSent = false;
  List<Map<String, dynamic>> periodsList = [];
  int? statusCode;
  int? irrigationMethod1;
  int? irrigationMethod2;
  var dio = Dio();
  List<String> controllersText = [];
  List<String> timeStringList = [];
  List<CustomIrrigationModel> customIrrigationModelList = [
    CustomIrrigationModel(accordingToHour: null, accordingToQuantity: null),
    CustomIrrigationModel(accordingToHour: null, accordingToQuantity: null),
    CustomIrrigationModel(accordingToHour: null, accordingToQuantity: null),
    CustomIrrigationModel(accordingToHour: null, accordingToQuantity: null),
  ];

  chooseAccordingToHour(int index) {
    customIrrigationModelList[index].accordingToHour = true;
    irrigationMethod1 = 2;
    emit(CustomIrrigationHourState());
  }

  chooseAccordingToPeriod(int index) {
    customIrrigationModelList[index].accordingToHour = false;
    irrigationMethod1 = 1;
    emit(CustomIrrigationPeriodState());
  }

  chooseAccordingToQuantity(int index) {
    customIrrigationModelList[index].accordingToQuantity = true;
    print(customIrrigationModelList[index].accordingToQuantity);
    irrigationMethod2 = 2;
    emit(CustomIrrigationQuantityState());
  }

  chooseAccordingToTime(int index) {
    customIrrigationModelList[index].accordingToQuantity = false;
    print(customIrrigationModelList[index].accordingToQuantity);
    irrigationMethod2 = 1;
    emit(CustomIrrigationTimeState());
  }

  chooseThisDay(int lineIndex, int dayIndex) {
    customIrrigationModelList[lineIndex].days[dayIndex].isOn =
        !customIrrigationModelList[lineIndex].days[dayIndex].isOn!;
    if (customIrrigationModelList[lineIndex].days[dayIndex].isOn == true) {
      customIrrigationModelList[lineIndex].noDayIsChosen--;
    } else if (customIrrigationModelList[lineIndex].days[dayIndex].isOn ==
        false) {
      customIrrigationModelList[lineIndex].noDayIsChosen++;
    }
    emit(CustomIrrigationChooseDayState());
  }

  pickTime(TimeOfDay value, int timeIndex, int lineIndex) {
    customIrrigationModelList[lineIndex].timeList[timeIndex] = value;
    emit(CustomIrrigationPickTimeState());
  }

  addContainer(int lineIndex) {
    customIrrigationModelList[lineIndex]
        .controllersList
        .add(TextEditingController());
    customIrrigationModelList[lineIndex].timeList.add(TimeOfDay.now());
    customIrrigationModelList[lineIndex].isBeingDeleted.add(false);
    emit(CustomIrrigationAddContainerState());
  }

  removeContainer({required int lineIndex, required int containerIndex}) {
    customIrrigationModelList[lineIndex]
        .controllersList
        .removeAt(containerIndex);
    customIrrigationModelList[lineIndex].timeList.removeAt(containerIndex);
    customIrrigationModelList[lineIndex]
        .isBeingDeleted
        .removeAt(containerIndex);
    emit(CustomIrrigationAddContainerState());
  }

  removeContainerFromdb(
      {required int lineIndex,
      required int containerIndex,
      required int stationId,
      required int valveId,
      required int periodId}) async {
    customIrrigationModelList[lineIndex].isBeingDeleted[containerIndex] = true;
    await dio
        .delete('$base/$irrigationPeriods/$stationId/$valveId/$periodId')
        .then((value) {
      if (value.statusCode == 200) {
        print(value.data);
        if (value.data == {"message": "valve period deleted"}) {
          print('a7a');
        }
        removeContainer(lineIndex: lineIndex, containerIndex: containerIndex);
        emit(CustomIrrigationDeleteSuccessState());
      }
    }).catchError((onError) {
      customIrrigationModelList[lineIndex].isBeingDeleted[containerIndex] =
          true;
      print(onError.toString());
      emit(CustomIrrigationDeleteFailedState());
    });
  }

  showDeleteButton() {
    visible = !visible;
    emit(CustomIrrigationShowDeleteButtonState());
  }

  putIrrigationSettings({
    required int activeValves,
    required int irrigationMethod1,
    required int irrigationMethod2,
    required int deleteIrrigationMethod1,
    required int deleteIrrigationMethod2,
    required int valveId,
    required int stationId,
    required int lineIndex,
  }) async {
    await dio.put('$base/$irrigationSettings/$stationId', data: {
      "station_id": 1,
      "active_valves": activeValves,
      "settings_type": 3,
      "irrigation_method_1": irrigationMethod1,
      "irrigation_method_2": irrigationMethod2
    }).then((value) {
      if (value.statusCode == 200) {
        delete(
            valveId: valveId,
            stationId: stationId,
            method1: deleteIrrigationMethod1,
            method2: deleteIrrigationMethod2,
            lineIndex: lineIndex);
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(CustomIrrigationPutFailState());
    });
  }

  putIrrigationCycle({
    required int interval,
    required int valveId,
    required int duration,
    required int quantity,
    required int weekDays,
  }) async {
    await dio.put('$base/$irrigationCycle/1/$valveId', data: {
      "valve_id": valveId,
      "interval": interval,
      "duration": duration,
      "quantity": quantity,
      "week_days": weekDays
    }).then((value) {
      if (value.statusCode == 200) {
        print(value.data);

        emit(CustomIrrigationPutSuccessState());
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(CustomIrrigationPutFailState());
    });
  }

  putIrrigationHour({
    required int stationId,
    required List<Map<String, dynamic>> periodsList,
  }) async {
    await dio.put('$base/$irrigationPeriodsList/$stationId',
        data: {'list': periodsList}).then((value) {
      if (value.statusCode == 200) {
        emit(CustomIrrigationPutSuccessState());
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(CustomIrrigationPutFailState());
    });
  }

  getPeriods({
    required int stationId,
    required int lineIndex,
  }) async {
    customIrrigationModelList[lineIndex].timeList = [];
    customIrrigationModelList[lineIndex].controllersList = [];
    int j = 0;
    await dio.get('$base/$irrigationSettings/$stationId').then((value) {
      irrigationSettingsModel = IrrigationSettingsModel.fromJson(value.data);
      print(lineIndex + 1);
      for (int i = 0;
          i < irrigationSettingsModel!.irrigationPeriods!.length;
          i++) {
        if (irrigationSettingsModel!.irrigationPeriods![i].valveId ==
            lineIndex + 1) {
          addContainer(lineIndex);
          customIrrigationModelList[lineIndex].controllersList[j].text =
              irrigationSettingsModel!.irrigationPeriods![i].duration
                  .toString();
          j++;
        }
      }
      if (value.statusCode == 200) {
        print(value.data);

        emit(CustomIrrigationGetSuccessState());
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(CustomIrrigationGetFailState());
    });
  }

  List<Map<String, dynamic>> makeAList(
      {required int lineIndex, required weekday}) {
    for (int i = 0;
        i < customIrrigationModelList[lineIndex].controllersList.length;
        i++) {
      periodsList.add({
        "period_id": i + 1,
        "valve_id": lineIndex + 1,
        "starting_time":
            customIrrigationModelList[lineIndex].timeList[i].hour * 60 +
                customIrrigationModelList[lineIndex].timeList[i].minute,
        "duration": customIrrigationModelList[lineIndex].accordingToQuantity ==
                false
            ? int.parse(
                customIrrigationModelList[lineIndex].controllersList[i].text)
            : 0,
        "quantity": customIrrigationModelList[lineIndex].accordingToQuantity ==
                true
            ? int.parse(
                customIrrigationModelList[lineIndex].controllersList[i].text)
            : 0,
        "week_days": weekday
      });
    }
    return periodsList;
  }

  delete(
      {required int valveId,
      required int stationId,
      required int method1,
      required int method2,
      required int lineIndex}) async {
    await dio.delete('$base/$valveSettingsDelete/$stationId', data: {
      "valve_id": valveId,
      "station_id": stationId,
      "method_1": method1,
      "method_2": method2
    }).then((value) {
      if (value.statusCode == 200) {
        getPeriods(stationId: stationId, lineIndex: lineIndex);
        emit(CustomIrrigationDeleteSuccessState());
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(CustomIrrigationDeleteFailedState());
    });
  }

  int toBinary({required int lineIndex}) {
    int activeDays = 0;
    for (int i = 0; i < 7; i++) {
      customIrrigationModelList[lineIndex].days[i].binaryDays =
          pow(2, i).toInt();
      if (customIrrigationModelList[lineIndex].days[i].isOn == true) {
        activeDays = activeDays +
            customIrrigationModelList[lineIndex].days[i].binaryDays;
      }
    }
    return activeDays;
  }
}
