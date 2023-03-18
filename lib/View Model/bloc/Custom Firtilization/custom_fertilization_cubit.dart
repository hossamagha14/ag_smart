import 'package:ag_smart/Model/custom_fertilization_model.dart';
import 'package:ag_smart/Model/features_model.dart';
import 'package:ag_smart/View%20Model/bloc/Custom%20Firtilization/custom_fertilization_states.dart';
import 'package:ag_smart/View%20Model/database/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Model/fertilizationModel.dart';

class CustomFertilizationCubit extends Cubit<CustomFertilizationStates> {
  CustomFertilizationCubit() : super(CustomFertilizationIntialState());

  static CustomFertilizationCubit get(context) => BlocProvider.of(context);
  bool? isDuration;
  int? choosenValue;
  int? quantityDayValue;
  int dayValue = 0;
  FeaturesModel? featuresModel;
  TimeOfDay quantityTime = TimeOfDay.now();
  List<Map<String, dynamic>> periodsList = [];
  List<Map<String, dynamic>> getPeriodsList = [];
  int? fertilizationType;
  bool visible = false;
  FertilizationModel? fertilizationModel;
  var dio = Dio();
  List<CustomFertilizationModel> customFertilizationModelList = [
    CustomFertilizationModel(),
    CustomFertilizationModel(),
    CustomFertilizationModel()
  ];

  chooseDuration() {
    isDuration = true;
    fertilizationType = 1;
    emit(CustomFertilizationChooseDurationState());
  }

  chooseQuantity() {
    isDuration = false;
    fertilizationType = 2;
    emit(CustomFertilizationChooseQuantityState());
  }

  chooseTime(value, int containerIndex, int lineIndex) {
    customFertilizationModelList[lineIndex].time[containerIndex] = value;
    emit(CustomFirtilizationSettingsChooseTimeState());
  }

  chooseQuantityTime(value) {
    quantityTime = value;
    emit(CustomFirtilizationSettingsChooseTimeState());
  }

  chooseQuantityDay(int value) {
    quantityDayValue = value;
    emit(CustomFirtiliserSettingsChooseDayState());
  }

  addContainer(int lineIndex) {
    customFertilizationModelList[lineIndex].time.add(TimeOfDay.now());
    customFertilizationModelList[lineIndex]
        .controllers
        .add(TextEditingController());
    emit(CustomFirtiliserSettingsAddContainerState());
  }

  // removeContainerFromdb(
  //     {required int lineIndex,
  //     required int containerIndex,
  //     required int stationId,
  //     required int valveId,
  //     required int weekday,
  //     required int periodId}) async {
  //   customIrrigationModelList[lineIndex].isBeingDeleted[containerIndex] = true;
  //   await dio
  //       .delete('$base/$irrigationPeriods/$stationId/$valveId/$periodId')
  //       .then((value) {
  //     if (value.statusCode == 200) {
  //       removeContainer(lineIndex: lineIndex, containerIndex: containerIndex);
  //       makeAList(lineIndex: lineIndex, weekday: weekday, valveId: valveId);
  //       putIrrigationHourAftreDelete(
  //           valveId: valveId,
  //           stationId: stationId,
  //           lineIndex: lineIndex,
  //           periodsList: periodsList);
  //     }
  //   }).catchError((onError) {
  //     customIrrigationModelList[lineIndex].isBeingDeleted[containerIndex] =
  //         true;
  //     print(onError.toString());
  //     emit(CustomIrrigationDeleteFailedState());
  //   });
  // }

  removeContainer(int lineIndex, int containerIndex) {
    customFertilizationModelList[lineIndex].time.removeAt(containerIndex);
    customFertilizationModelList[lineIndex]
        .controllers
        .removeAt(containerIndex);
    customFertilizationModelList[lineIndex].daysList.removeAt(containerIndex);
    emit(CustomFirtiliserSettingsRemoveContainerState());
  }

  showDeleteButton() {
    visible = !visible;
    emit(CustomFertilizationShowDeleteButtonState());
  }

  chooseDay(int value, int lineIndex, int containerIndex) {
    dayValue = value;
    if (customFertilizationModelList[lineIndex].daysList.length - 1 <
        containerIndex) {
      customFertilizationModelList[lineIndex].daysList.add(dayValue);
    } else {
      customFertilizationModelList[lineIndex].daysList[containerIndex] =
          dayValue;
    }

    emit(CustomFirtiliserSettingsChooseDayState());
  }

  putFertilizationType(
      {required int stationId,
      required int fertilizationMethod,
      required int valveId,
      required int lineIndex}) async {
    await dio.put('$base/$fertilizerSettings/$stationId', data: {
      "station_id": stationId,
      "fertilization_method_1": 3,
      "fertilization_method_2": fertilizationMethod,
    }).then((value) {
      if (value.statusCode == 200) {
        delete(
            stationId: stationId,
            lineIndex: lineIndex,
            valveId: valveId,
            method1: fertilizationMethod);
        emit(CustomFertilizationPutSuccessState());
      }
    }).catchError((onError) {
      print(onError);
      emit(CustomFertilizationPutFailState());
    });
  }

  putFertilizationPeriods({
    required int stationId,
    required List<Map<String, dynamic>> periodsList,
  }) async {
    await dio.put('$base/$fertilizerPeriodsList/$stationId',
        data: {'list': periodsList}).then((value) {
      if (value.statusCode == 200) {
        emit(CustomFertilizationPutSuccessState());
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(CustomFertilizationPutFailState());
    });
  }

  List<Map<String, dynamic>> makeAList(
      {required int lineIndex, required int valveId}) {
        periodsList=[];
    for (int i = 0;
        i < customFertilizationModelList[lineIndex].controllers.length;
        i++) {
      periodsList.add({
        "period_id": i + 1,
        "valve_id": valveId,
        "starting_time":
            customFertilizationModelList[lineIndex].time[i].hour * 60 +
                customFertilizationModelList[lineIndex].time[i].minute,
        "duration": fertilizationType == 1
            ? int.parse(
                customFertilizationModelList[lineIndex].controllers[i].text)
            : 0,
        "quantity": fertilizationType == 2
            ? int.parse(
                customFertilizationModelList[lineIndex].controllers[i].text)
            : 0,
        "date": customFertilizationModelList[lineIndex].daysList[i]
      });
    }
    print(periodsList);
    return periodsList;
  }

  getPeriods({
    required int stationId,
    required int lineIndex,
    required int valveId,
  }) async {
    customFertilizationModelList[lineIndex].time = [];
    customFertilizationModelList[lineIndex].controllers = [];
    customFertilizationModelList[lineIndex].daysList = [];
    int j = 0;
    await dio.get('$base/$fertilizerSettings/$stationId').then((value) {
      fertilizationModel = FertilizationModel.fromJson(value.data);
      print(value.data);
      for (int i = 0; i < fertilizationModel!.fertilizerPeriods!.length; i++) {
        if (fertilizationModel!.fertilizerPeriods![i].valveId == valveId) {
          addContainer(lineIndex);
          customFertilizationModelList[lineIndex].daysList.add(1);
          customFertilizationModelList[lineIndex].controllers[j].text =
              fertilizationModel!.fertilizerPeriods![i].duration.toString();
          customFertilizationModelList[lineIndex].daysList[j] =
              fertilizationModel!.fertilizerPeriods![i].date!;
          j++;
        }
      }
      if (value.statusCode == 200) {
        emit(CustomFertilizationGetSuccessState());
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(CustomFertilizationGetFailState());
    });
  }

  delete({
    required int stationId,
    required int valveId,
    required int lineIndex,
    required int method1,
  }) async {
    await dio.delete('$base/$fertilizerSettingsDelete/$stationId', data: {
      "valve_id": valveId,
      "station_id": stationId,
      "method_1": method1
    }).then((value) {
      if (value.statusCode == 200) {
        getPeriods(
            lineIndex: lineIndex, valveId: valveId, stationId: stationId);
        emit(CustomFertilizationDeleteSuccessState());
      }
    }).catchError((onError) {
      emit(CustomFertilizationDeleteFailState());
    });
  }

  getFertilizationSettings({required int stationId}) async {
    await dio.get('$base/$fertilizerSettings/$stationId').then((value) {
      print(value.data);
      fertilizationModel = FertilizationModel.fromJson(value.data);
      if (value.statusCode == 200) {
        emit(CustomFertilizationGetSuccessState());
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(CustomFertilizationGetFailState());
    });
  }

  getNumberOfValves({required int stationId}) {
    customFertilizationModelList = [];
    dio.get('$base/$features/$stationId').then((value) {
      featuresModel = FeaturesModel.fromJson(value.data);
      for (int i = 0; i < featuresModel!.linesNumber!; i++) {
        customFertilizationModelList.add(CustomFertilizationModel());
      }
      emit(CustomFertilizationGetValvesSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(CustomFertilizationGetValvesFailState());
    });
  }
}
