import 'package:ag_smart/Model/custom_fertilization_model.dart';
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
    choosenValue = value;
    if (customFertilizationModelList[lineIndex].daysList.length - 1 <
        containerIndex) {
      customFertilizationModelList[lineIndex].daysList.add(choosenValue!);
    } else {
      customFertilizationModelList[lineIndex].daysList[containerIndex] =
          choosenValue!;
    }

    emit(CustomFirtiliserSettingsChooseDayState());
  }

  putFertilizationType({
    required int stationId,
    required int fertilizationMethod,
  }) async {
    await dio.put('$base/$fertilizerSettings/$stationId', data: {
      "station_id": stationId,
      "fertilization_method_1": 3,
      "fertilization_method_2": fertilizationMethod,
    }).then((value) {
      print(value.data);
      emit(CustomFertilizationPutSuccessState());
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
      print(value.data);
      emit(CustomFertilizationPutSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      print(makeAList(lineIndex: 1));
      emit(CustomFertilizationPutFailState());
    });
  }

  List<Map<String, dynamic>> makeAList({required int lineIndex}) {
    for (int i = 0;
        i < customFertilizationModelList[lineIndex].controllers.length;
        i++) {
      periodsList.add({
        "period_id": i + 1,
        "valve_id": lineIndex + 1,
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
    return periodsList;
  }

  getPeriods({
    required int stationId,
    required int lineIndex,
  }) async {
    customFertilizationModelList[lineIndex].time = [];
    customFertilizationModelList[lineIndex].controllers = [];
    customFertilizationModelList[lineIndex].days = [];
    int j = 0;
    await dio.get('$base/$fertilizerSettings/$stationId').then((value) {
      fertilizationModel = FertilizationModel.fromJson(value.data);
      print(value.data);
      for (int i = 0; i < fertilizationModel!.fertilizerPeriods!.length; i++) {
        if (fertilizationModel!.fertilizerPeriods![i].valveId ==
            lineIndex + 1) {
          addContainer(lineIndex);
          customFertilizationModelList[lineIndex].daysList.add(1);
          customFertilizationModelList[lineIndex].controllers[j].text =
              fertilizationModel!.fertilizerPeriods![i].duration.toString();
          customFertilizationModelList[lineIndex].daysList[j] =
              fertilizationModel!.fertilizerPeriods![i].date!;

          print(
              '${customFertilizationModelList[lineIndex].daysList} ahmed ahmed ahmed');
          print(
              '${customFertilizationModelList[lineIndex].time} ahmed ahmed ahmed');

          j++;
        }
      }
      if (value.statusCode == 200) {
        print(value.data);

        emit(CustomFertilizationGetSuccessState());
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(CustomFertilizationGetFailState());
    });
  }
}
