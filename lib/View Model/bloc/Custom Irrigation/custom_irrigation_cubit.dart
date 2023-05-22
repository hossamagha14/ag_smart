import 'dart:math';

import 'package:ag_smart/Model/custom_cycle_model.dart';
import 'package:ag_smart/Model/custom_irrigation_model.dart';
import 'package:ag_smart/View%20Model/bloc/Custom%20Irrigation/custom_irrigation_states.dart';
import 'package:ag_smart/View%20Model/database/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Model/custom_period_model.dart';
import '../../../Model/features_model.dart';
import '../../../Model/irrigation_settings_model.dart';
import '../../../View/Reusable/text.dart';
import '../../database/dio_helper.dart';

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
  DioHelper dio = DioHelper();
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

  addContainer(int lineIndex, {required int hour, required int minute}) {
    customIrrigationModelList[lineIndex]
        .controllersList
        .add(TextEditingController());
    customIrrigationModelList[lineIndex]
        .timeList
        .add(TimeOfDay(hour: hour, minute: minute));
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
    emit(CustomIrrigationDeleteSuccessState());
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
        emit(CustomIrrigationPutDeleteSuccessState());
      }
    }).catchError((onError) {
      emit(CustomIrrigationPutDeleteFailState());
    });
  }

  getPeriods({
    required int stationId,
    required int lineIndex,
    required int valveId,
    TextEditingController? hours,
    TextEditingController? amount,
  }) async {
    emit(CustomIrrigationLoadingState());
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
          if (irrigationSettingsModel!
              .customValvesSettings![i].irrigationPeriods!.isNotEmpty) {
            getActiveDays(
                decimalNumber: irrigationSettingsModel!
                    .customValvesSettings![i].irrigationPeriods![0].weekDays!);
            for (int p = 0; p < activeDays.length; p++) {
              if (activeDays[p] == 1) {
                customIrrigationModelList[lineIndex].days[p].isOn = true;
                customIrrigationModelList[lineIndex].noDayIsChosen--;
              }
            }
            for (int h = 0;
                h <
                    irrigationSettingsModel!
                        .customValvesSettings![i].irrigationPeriods!.length;
                h++) {
              double doubleHour = irrigationSettingsModel!
                      .customValvesSettings![i]
                      .irrigationPeriods![h]
                      .startingTime! /
                  60;
              int hour = doubleHour.toInt();
              int minute = irrigationSettingsModel!.customValvesSettings![i]
                      .irrigationPeriods![h].startingTime! -
                  hour * 60;
              addContainer(lineIndex, hour: hour, minute: minute);
              irrigationSettingsModel!
                          .customValvesSettings![i].irrigationMethod2 ==
                      1
                  ? customIrrigationModelList[lineIndex]
                          .controllersList[j]
                          .text =
                      irrigationSettingsModel!.customValvesSettings![i]
                          .irrigationPeriods![h].duration
                          .toString()
                  : customIrrigationModelList[lineIndex]
                          .controllersList[j]
                          .text =
                      irrigationSettingsModel!.customValvesSettings![i]
                          .irrigationPeriods![h].quantity
                          .toString();

              j++;
            }
          } else if (irrigationSettingsModel!
              .customValvesSettings![i].irrigationCycles!.isNotEmpty) {
            getActiveDays(
                decimalNumber: irrigationSettingsModel!
                    .customValvesSettings![i].irrigationCycles![0].weekDays!);
            for (int p = 0; p < activeDays.length; p++) {
              if (activeDays[p] == 1) {
                customIrrigationModelList[lineIndex].days[p].isOn = true;
                customIrrigationModelList[lineIndex].noDayIsChosen--;
              }
            }
            hours!.text = irrigationSettingsModel!
                    .customValvesSettings![lineIndex].irrigationCycles!.isEmpty
                ? ''
                : irrigationSettingsModel!.customValvesSettings![lineIndex]
                    .irrigationCycles![0].interval
                    .toString();
            amount!.text = irrigationSettingsModel!
                    .customValvesSettings![lineIndex].irrigationCycles!.isEmpty
                ? ''
                : irrigationSettingsModel!.customValvesSettings![lineIndex]
                            .irrigationCycles![0].interval ==
                        0
                    ? irrigationSettingsModel!.customValvesSettings![lineIndex]
                        .irrigationCycles![0].quantity
                        .toString()
                    : irrigationSettingsModel!.customValvesSettings![lineIndex]
                        .irrigationCycles![0].interval
                        .toString();
          }
        }
      }
      if (value.statusCode == 200) {
        emit(CustomIrrigationGetSuccessState());
      }
    }).catchError((onError) {
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

  getNumberOfValves() {
    customIrrigationModelList = [];
    dio.get('$base/$features/$serialNumber').then((value) {
      featuresModel = FeaturesModel.fromJson(value.data);
      for (int i = 0; i < featuresModel!.linesNumber!; i++) {
        customIrrigationModelList.add(CustomIrrigationModel(
            accordingToHour: null, accordingToQuantity: null));
      }
      emit(CustomIrrigationGetSuccessState());
    }).catchError((onError) {
      emit(CustomIrrigationGetFailState());
    });
  }

  bool checkOpenValveTimeSeriesByCycle({
    required hours,
    required openValveTime,
  }) {
    bool validInput = true;
    double availableOpenValveTime = hours * 60;
    if (openValveTime > availableOpenValveTime ||
        openValveTime == 0 ||
        hours > 24) {
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
                customIrrigationModelList[lineIndex].timeList[i].minute <
            customIrrigationModelList[lineIndex].timeList[j].hour * 60 +
                customIrrigationModelList[lineIndex].timeList[j].minute) {
          if (customIrrigationModelList[lineIndex].timeList[i].hour * 60 +
                  customIrrigationModelList[lineIndex].timeList[i].minute +
                  int.parse(customIrrigationModelList[lineIndex]
                      .controllersList[i]
                      .text) >
              customIrrigationModelList[lineIndex].timeList[j].hour * 60 +
                  customIrrigationModelList[lineIndex].timeList[j].minute) {
            validInput = false;
          }
        } else if (customIrrigationModelList[lineIndex].timeList[i].hour * 60 +
                customIrrigationModelList[lineIndex].timeList[i].minute >
            customIrrigationModelList[lineIndex].timeList[j].hour * 60 +
                customIrrigationModelList[lineIndex].timeList[j].minute) {
          if (customIrrigationModelList[lineIndex].timeList[j].hour * 60 +
                  customIrrigationModelList[lineIndex].timeList[j].minute +
                  int.parse(customIrrigationModelList[lineIndex]
                      .controllersList[j]
                      .text) >
              customIrrigationModelList[lineIndex].timeList[i].hour * 60 +
                  customIrrigationModelList[lineIndex].timeList[i].minute) {
            validInput = false;
          }
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
