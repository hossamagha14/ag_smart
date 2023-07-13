import 'package:ag_smart/Model/custom_fertilization_model.dart';
import 'package:ag_smart/Model/features_model.dart';
import 'package:ag_smart/View%20Model/bloc/Custom%20Firtilization/custom_fertilization_states.dart';
import 'package:ag_smart/View%20Model/database/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Model/fertilization_model.dart';
import '../../../View/Reusable/text.dart';
import '../../Repo/auth_bloc.dart';
import '../../database/dio_helper.dart';
import '../commom_states.dart';

class CustomFertilizationCubit extends Cubit<CommonStates> {
  AuthBloc authBloc;
  late DioHelper dio;
  CustomFertilizationCubit(this.authBloc)
      : super(CustomFertilizationIntialState()) {
    dio = DioHelper(authBloc);
  }

  static CustomFertilizationCubit get(context) => BlocProvider.of(context);
  bool? isDuration;
  int? choosenValue;
  int? quantityDayValue;
  int dayValue = 0;
  FeaturesModel? featuresModel;
  TimeOfDay quantityTime = TimeOfDay.now();
  List<Map<String, dynamic>> periodsList = [];
  List<Map<String, dynamic>> getPeriodsList = [];
  int fertilizationType = 0;
  bool visible = false;
  FertilizationModel? fertilizationModel;
  List<CustomFertilizationModel> customFertilizationModelList = [];

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
    if (value != null) {
      customFertilizationModelList[lineIndex].time[containerIndex] = value;
    }
    emit(CustomFirtilizationSettingsChooseTimeState());
  }

  chooseQuantityDay(int value) {
    quantityDayValue = value;
    emit(CustomFirtiliserSettingsChooseDayState());
  }

  addContainer(int lineIndex, {required int hour, required int minute}) {
    customFertilizationModelList[lineIndex]
        .time
        .add(TimeOfDay(hour: hour, minute: minute));
    customFertilizationModelList[lineIndex]
        .controllers
        .add(TextEditingController());
    emit(CustomFirtiliserSettingsAddContainerState());
  }

  removeContainerFromdb(
      {required int lineIndex,
      required int containerIndex,
      required int stationId,
      required int valveId,
      required int ferMethod1,
      required int periodId}) async {
    await dio
        .delete('$base/$fertilizerPeriods/$stationId/$valveId/$periodId')
        .then((value) {
      if (value.statusCode == 200) {
        removeContainer(
          lineIndex: lineIndex,
          containerIndex: containerIndex,
        );
        makeAList(
            lineIndex: lineIndex, valveId: valveId, ferMethod1: ferMethod1);
        putFertilizationPeriodsAfterDelete(
            stationId: stationId, periodsList: periodsList);
      }
    }).catchError((onError) {
      emit(CustomFertilizationDeleteFailState());
    });
  }

  removeContainer({required int lineIndex, required int containerIndex}) {
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
    await dio.put('$base/$customFertilization/$stationId/$valveId', data: {
      "station_id": stationId,
      "valve_id": valveId,
      "fertilizer_method1": fertilizationMethod,
    }).then((value) {
      if (value.statusCode == 200) {
        emit(CustomFertilizationPutSuccessState());
        getNumberOfValvesandperiods(
            serialNumber: serialNumber, lineIndex: lineIndex, valveId: valveId);
      }
    }).catchError((onError) {
      emit(CustomFertilizationPutFailState());
    });
  }

  putFertilizationPeriodsAfterDelete({
    required int stationId,
    required List<Map<String, dynamic>> periodsList,
  }) async {
    await dio.put('$base/$fertilizerPeriodsList/$stationId',
        data: {'list': periodsList}).then((value) {
      if (value.statusCode == 200) {
        emit(CustomFertilizationPutDelSuccessState());
      }
    }).catchError((onError) {
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
      emit(CustomFertilizationPutFailState());
    });
  }

  List<Map<String, dynamic>> makeAList(
      {required int lineIndex, required int valveId, required int ferMethod1}) {
    periodsList = [];
    for (int i = 0;
        i < customFertilizationModelList[lineIndex].controllers.length;
        i++) {
      periodsList.add({
        "period_id": i + 1,
        "valve_id": valveId,
        "starting_time":
            customFertilizationModelList[lineIndex].time[i].hour * 60 +
                customFertilizationModelList[lineIndex].time[i].minute,
        "duration": ferMethod1 == 1
            ? int.parse(
                customFertilizationModelList[lineIndex].controllers[i].text)
            : 0,
        "quantity": ferMethod1 == 2
            ? int.parse(
                customFertilizationModelList[lineIndex].controllers[i].text)
            : 0,
        "date": customFertilizationModelList[lineIndex].daysList[i]
      });
    }
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
    await dio.get('$base/$fertilizerSettings/$stationId').then((value) {
      fertilizationModel = FertilizationModel.fromJson(value.data);
      for (int i = 0;
          i < fertilizationModel!.customFertilizerSettings!.length;
          i++) {
        if (fertilizationModel!.customFertilizerSettings![i].valveId ==
            valveId) {
          for (int j = 0;
              j <
                  fertilizationModel!
                      .customFertilizerSettings![i].fertilizerPeriods!.length;
              j++) {
            double hourDouble = fertilizationModel!.customFertilizerSettings![i]
                    .fertilizerPeriods![j].startingTime! /
                60;
            int hour = hourDouble.toInt();
            int minute = fertilizationModel!.customFertilizerSettings![i]
                    .fertilizerPeriods![j].startingTime! -
                hour * 60;
            addContainer(lineIndex, hour: hour, minute: minute);
            customFertilizationModelList[lineIndex].daysList.add(1);
            customFertilizationModelList[lineIndex].controllers[j].text =
                fertilizationModel!
                            .customFertilizerSettings![i].fertilizerMethod1 ==
                        1
                    ? fertilizationModel!.customFertilizerSettings![i]
                        .fertilizerPeriods![j].duration
                        .toString()
                    : fertilizationModel!.customFertilizerSettings![i]
                        .fertilizerPeriods![j].quantity
                        .toString();
            customFertilizationModelList[lineIndex].daysList[j] =
                fertilizationModel!
                    .customFertilizerSettings![i].fertilizerPeriods![j].date!;
          }
        }
      }
      if (value.statusCode == 200) {
        emit(CustomFertilizationGetSuccessState());
      }
    }).catchError((onError) {
      emit(CustomFertilizationGetFailState());
    });
  }

  delete({
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

  getNumberOfValvesOnly({
    required String serialNumber,
  }) {
    customFertilizationModelList = [];
    dio.get('$base/$features/$serialNumber').then((value) {
      featuresModel = FeaturesModel.fromJson(value.data);
      for (int i = 0; i < featuresModel!.linesNumber!; i++) {
        customFertilizationModelList.add(CustomFertilizationModel());
      }
      emit(CustomFertilizationGetValvesSuccessState());
    }).catchError((onError) {
      emit(CustomFertilizationGetValvesFailState());
    });
  }

  getNumberOfValvesandperiods({
    required String serialNumber,
    required int lineIndex,
    required int valveId,
  }) {
    emit(CustomFertilizationLoadingState());
    customFertilizationModelList = [];
    dio.get('$base/$features/$serialNumber').then((value) {
      featuresModel = FeaturesModel.fromJson(value.data);
      for (int i = 0; i < featuresModel!.linesNumber!; i++) {
        customFertilizationModelList.add(CustomFertilizationModel());
        for (int j = 0;
            j < customFertilizationModelList[i].daysList.length;
            j++) {
          customFertilizationModelList[i].controllers[j].text = '';
        }
      }
      getPeriods(stationId: stationId, lineIndex: lineIndex, valveId: valveId);
    }).catchError((onError) {
      emit(CustomFertilizationGetValvesFailState());
    });
  }

  bool checkOpenValveTimeParallel({required int lineIndex}) {
    bool validInput = true;
    for (int i = 0;
        i < customFertilizationModelList[lineIndex].controllers.length;
        i++) {
      for (int j = i + 1;
          j < customFertilizationModelList[lineIndex].controllers.length;
          j++) {
        if (customFertilizationModelList[lineIndex].daysList[i] ==
            customFertilizationModelList[lineIndex].daysList[j]) {
          if (customFertilizationModelList[lineIndex].time[i].hour * 60 +
                  customFertilizationModelList[lineIndex].time[i].minute <
              customFertilizationModelList[lineIndex].time[j].hour * 60 +
                  customFertilizationModelList[lineIndex].time[j].minute) {
            if (customFertilizationModelList[lineIndex].time[i].hour * 60 +
                    customFertilizationModelList[lineIndex].time[i].minute +
                    int.parse(customFertilizationModelList[lineIndex]
                        .controllers[i]
                        .text) >
                customFertilizationModelList[lineIndex].time[j].hour * 60 +
                    customFertilizationModelList[lineIndex].time[j].minute) {
              validInput = false;
            }
          } else if (customFertilizationModelList[lineIndex].time[i].hour * 60 +
                  customFertilizationModelList[lineIndex].time[i].minute >
              customFertilizationModelList[lineIndex].time[j].hour * 60 +
                  customFertilizationModelList[lineIndex].time[j].minute) {
            if (customFertilizationModelList[lineIndex].time[j].hour * 60 +
                    customFertilizationModelList[lineIndex].time[j].minute +
                    int.parse(customFertilizationModelList[lineIndex]
                        .controllers[j]
                        .text) >
                customFertilizationModelList[lineIndex].time[i].hour * 60 +
                    customFertilizationModelList[lineIndex].time[i].minute) {
              validInput = false;
            }
          }
        }
      }
    }
    return validInput;
  }
}
