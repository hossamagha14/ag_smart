import 'dart:math';

import 'package:ag_smart/Model/custom_cycle_model.dart';
import 'package:ag_smart/Model/custom_irrigation_model.dart';
import 'package:ag_smart/View%20Model/bloc/Custom%20Irrigation/custom_irrigation_states.dart';
import 'package:ag_smart/View%20Model/database/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Model/custom_period_model.dart';
import '../../../Model/features_model.dart';
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
  FeaturesModel? featuresModel;
  List<int> activeDays = [];
  var dio = Dio();
  List<String> controllersText = [];
  List<String> timeStringList = [];
  List<CustomIrrigationModel> customIrrigationModelList = [];

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

  pickTime(value, int timeIndex, int lineIndex) {
    customIrrigationModelList[lineIndex].timeList[timeIndex] =
        value ?? TimeOfDay.now();
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
  }

  removeContainerFromdb(
      {required int lineIndex,
      required int containerIndex,
      required int stationId,
      required int valveId,
      required int weekday,
      required int periodId}) async {
    emit(CustomIrrigationLoadingState());
    customIrrigationModelList[lineIndex].isBeingDeleted[containerIndex] = true;
    await dio
        .delete('$base/$irrigationPeriods/$stationId/$valveId/$periodId')
        .then((value) {
      if (value.statusCode == 200) {
        removeContainer(lineIndex: lineIndex, containerIndex: containerIndex);
        makeAList(lineIndex: lineIndex, weekday: weekday, valveId: valveId);
        putIrrigationHourAftreDelete(
            valveId: valveId,
            stationId: stationId,
            lineIndex: lineIndex,
            periodsList: periodsList);
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

  putIrrigationSettings(
      {required int irrigationMethod1,
      required int irrigationMethod2,
      required int valveId,
      required int stationId,
      required int lineIndex}) async {
    await dio.put('$base/$customIrrigationSettings/$stationId/$valveId', data: {
      "station_id": stationId,
      "valve_id": valveId,
      "irrigation_method1": irrigationMethod1,
      "irrigation_method2": irrigationMethod2
    }).then((value) {
      if (value.statusCode == 200) {
        emit(CustomIrrigationPutSuccessState());
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(CustomIrrigationPutFailState());
    });
  }

  putIrrigationCycle(
      {required int interval,
      required int valveId,
      required int duration,
      required int quantity,
      required int weekDays,
      required int stationId}) async {
    await dio.put('$base/$irrigationCycle/$stationId/$valveId', data: {
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

  putIrrigationHourAftreDelete({
    required int stationId,
    required int valveId,
    required int lineIndex,
    required List<Map<String, dynamic>> periodsList,
  }) async {
    await dio.put('$base/$irrigationPeriodsList/$stationId',
        data: {'list': periodsList}).then((value) {
      if (value.statusCode == 200) {
        getPeriods(
            stationId: stationId, lineIndex: lineIndex, valveId: valveId);
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(CustomIrrigationPutDeleteFailState());
    });
  }

  getPeriods({
    required int stationId,
    required int lineIndex,
    required int valveId,
  }) async {
    customIrrigationModelList = [];
    int j = 0;
    await dio.get('$base/$irrigationSettings/$stationId').then((value) {
      irrigationSettingsModel = IrrigationSettingsModel.fromJson(value.data);
      for (int i = 0;
          i < irrigationSettingsModel!.customValvesSettings!.length;
          i++) {
        customIrrigationModelList.add(CustomIrrigationModel(
          accordingToHour: irrigationSettingsModel!
                      .customValvesSettings![i].irrigationMethod1 ==
                  2
              ? true
              : false,
          accordingToQuantity: irrigationSettingsModel!
                      .customValvesSettings![i].irrigationMethod2 ==
                  2
              ? true
              : false,
        ));
        if (irrigationSettingsModel!.customValvesSettings![i].valveId ==
            valveId) {
          getActiveDays(
              decimalNumber: irrigationSettingsModel!
                  .customValvesSettings![i].irrigationPeriods![0].weekDays!);
          for (int i = 0; i < activeDays.length; i++) {
            if (activeDays[i] == 1) {
              customIrrigationModelList[lineIndex].days[i].isOn = true;
              customIrrigationModelList[lineIndex].noDayIsChosen--;
            }
          }

          for (int h = 0;
              h <
                  irrigationSettingsModel!
                      .customValvesSettings![i].irrigationPeriods!.length;
              h++) {
            addContainer(lineIndex);
            irrigationSettingsModel!
                        .customValvesSettings![i].irrigationMethod2 ==
                    1
                ? customIrrigationModelList[lineIndex].controllersList[j].text =
                    irrigationSettingsModel!
                        .customValvesSettings![i].irrigationPeriods![h].duration
                        .toString()
                : customIrrigationModelList[lineIndex].controllersList[j].text =
                    irrigationSettingsModel!
                        .customValvesSettings![i].irrigationPeriods![h].quantity
                        .toString();

            j++;
          }
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
      {required int lineIndex, required int weekday, required int valveId}) {
    periodsList = [];
    for (int i = 0;
        i < customIrrigationModelList[lineIndex].controllersList.length;
        i++) {
      periodsList.add({
        "period_id": i + 1,
        "valve_id": valveId,
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
    print('$periodsList periodslist');
    return periodsList;
  }

  int toDecimal({required int lineIndex}) {
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

  getNumberOfValves({required int stationId}) {
    customIrrigationModelList = [];
    dio.get('$base/$features/$stationId').then((value) {
      featuresModel = FeaturesModel.fromJson(value.data);
      for (int i = 0; i < featuresModel!.linesNumber!; i++) {
        customIrrigationModelList.add(CustomIrrigationModel(
            accordingToHour: null, accordingToQuantity: null));
      }
      emit(CustomIrrigationGetSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(CustomIrrigationGetFailState());
    });
  }

  bool checkOpenValveTimeSeriesByCycle({
    required hours,
    required openValveTime,
  }) {
    bool validInput = true;
    double availableOpenValveTime = hours * 60;
    if (openValveTime > availableOpenValveTime || openValveTime == 0) {
      validInput = false;
    }
    return validInput;
  }

  bool checkOpenValveTimeParallel({required int lineIndex}) {
    bool validInput = true;
    for (int i = 0;
        i < customIrrigationModelList[lineIndex].controllersList.length;
        i++) {
      for (int j = i + 1;
          j < customIrrigationModelList[lineIndex].controllersList.length;
          j++) {
        if (customIrrigationModelList[lineIndex].timeList[i].hour * 60 +
                customIrrigationModelList[lineIndex].timeList[i].minute +
                int.parse(customIrrigationModelList[lineIndex]
                    .controllersList[i]
                    .text) >
            customIrrigationModelList[lineIndex].timeList[j].hour * 60 +
                customIrrigationModelList[lineIndex].timeList[j].minute) {
          validInput = false;
        }
      }
    }
    return validInput;
  }

  getActiveDays({required int decimalNumber}) {
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
  }
}
