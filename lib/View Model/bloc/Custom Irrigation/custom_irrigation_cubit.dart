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
    irrigationMethod2 = 2;
    emit(CustomIrrigationQuantityState());
  }

  chooseAccordingToTime(int index) {
    customIrrigationModelList[index].accordingToQuantity = false;
    irrigationMethod2 = 2;
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
  }) async {
    emit(CustomIrrigationLoadingState());
    await dio.put('$base/$irrigationSettings/1', data: {
      "station_id": 1,
      "active_valves": activeValves,
      "settings_type": 3,
      "irrigation_method_1": irrigationMethod1,
      "irrigation_method_2": irrigationMethod2
    }).then((value) {
      if (value.statusCode == 200) {
        print(value.data);
        statusCode = value.statusCode;
        emit(CustomIrrigationPutSuccessState());
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
    emit(CustomIrrigationLoadingState());
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
    required int periodId,
    required int valveId,
    required TimeOfDay startTime,
    required int duration,
    required int quantity,
    required int weekDays,
  }) async {
    emit(CustomIrrigationLoadingState());
    int time = startTime.hour * 60 + startTime.minute;
    await dio.put('$base/$irrigationPeriods/1/$valveId/$periodId', data: {
      "period_id": periodId,
      "valve_id": valveId,
      "starting_time": time,
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
}
