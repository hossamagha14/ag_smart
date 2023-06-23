import 'package:ag_smart/Model/fertilization_model.dart';
import 'package:ag_smart/Model/firtiliser_model.dart';
import 'package:ag_smart/Model/station_model.dart';
import 'package:ag_smart/View%20Model/database/end_points.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Repo/auth_bloc.dart';
import '../../database/dio_helper.dart';
import '../commom_states.dart';
import 'firtiliser_settings_states.dart';

class FirtiliserSettingsCubit extends Cubit<CommonStates> {
  AuthBloc authBloc;
  late DioHelper dio;
  FirtiliserSettingsCubit(this.authBloc)
      : super(FirtiliserSettingsIntialState()) {
    dio = DioHelper(authBloc);
  }

  static FirtiliserSettingsCubit get(context) => BlocProvider.of(context);

  List<String> dateStringList = [];
  List<String> timeStringList = [];
  FirtiliserModel firtiliserModel = FirtiliserModel();
  FertilizationModel? fertilizationModel;
  bool done = false;
  bool deleteVisibile = false;
  int dayValue = 0;
  StationModel? stationModel;
  List<Map<String, dynamic>> periodsList = [];
  bool? accordingToTime;
  bool? seriesFertilization;
  int? method1;
  int? method2;

  chooseTime(value, int containerIndex) {
    firtiliserModel.timeList[containerIndex] = value ?? TimeOfDay.now();
    emit(FirtiliserSettingsChooseTimeState());
  }

  chooseDay(int value, int containerIndex) {
    dayValue = value;
    if (firtiliserModel.dateList.length - 1 < containerIndex) {
      firtiliserModel.dateList.add(dayValue);
    } else {
      firtiliserModel.dateList[containerIndex] = dayValue;
    }
    emit(FirtiliserSettingsChooseDayState());
  }

  addContainer({required int hour, required int minute}) {
    firtiliserModel.timeList.add(TimeOfDay(hour: hour, minute: minute));
    firtiliserModel.controllersList.add(TextEditingController());
    emit(FirtiliserSettingsAddContainerState());
  }

  removeContainerFromdb(
      {required int containerIndex,
      required int valveId,
      required int method2,
      required int periodId}) async {
    await dio
        .delete('$base/$fertilizerPeriods/$stationId/$valveId/$periodId')
        .then((value) {
      if (value.statusCode == 200) {
        removeContainer(
          containerIndex: containerIndex,
        );
        makeAList(method2);
        putFerListAfterDelete(periodsList: periodsList);
      }
    }).catchError((onError) {
      emit(FirtiliserSettingsDeleteFailState());
    });
  }

  removeContainer({required int containerIndex}) {
    firtiliserModel.timeList.removeAt(containerIndex);
    firtiliserModel.controllersList.removeAt(containerIndex);
    firtiliserModel.dateList.removeAt(containerIndex);
    emit(FirtiliserSettingsAddContainerState());
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

  putFertilizationSettings({
    required int ferMethod1,
    required int ferMethod2,
  }) async {
    await dio.put('$base/$fertilizerSettings/$stationId', data: {
      "station_id": stationId,
      "fertilization_method_1": ferMethod1,
      "fertilization_method_2": ferMethod2
    }).then((value) {
      if (value.statusCode == 200) {
        getPeriods();
      }
    }).catchError((onError) {
      emit(FirtiliserSettingsSendFailState());
    });
  }

  delete({
    required int valveId,
    required int method1,
  }) async {
    await dio.delete('$base/$fertilizerSettingsDelete/$stationId',
        data: {}).then((value) {
      if (value.statusCode == 200) {
        emit(FirtiliserSettingsDeleteSuccessState());
      }
    }).catchError((onError) {
      emit(FirtiliserSettingsDeleteFailState());
    });
  }

  showDeleteButton() {
    deleteVisibile = !deleteVisibile;
    emit(FirtiliserSettingsShowDeleteState());
  }

  getPeriods() async {
    emit(FirtiliserLoadingState());
    firtiliserModel.controllersList = [];
    firtiliserModel.timeList = [];
    firtiliserModel.dateList = [];
    await dio.get('$base/$fertilizerSettings/$stationId').then((value) {
      fertilizationModel = FertilizationModel.fromJson(value.data);
      for (int i = 0; i < fertilizationModel!.fertilizerPeriods!.length; i++) {
        double hourDouble =
            fertilizationModel!.fertilizerPeriods![i].startingTime! / 60;
        int hour = hourDouble.toInt();
        int minute =
            fertilizationModel!.fertilizerPeriods![i].startingTime! - hour * 60;
        addContainer(hour: hour, minute: minute);
        firtiliserModel.dateList.add(1);

        firtiliserModel.controllersList[i].text =
            fertilizationModel!.fertilizerPeriods![i].duration == 0
                ? fertilizationModel!.fertilizerPeriods![i].quantity.toString()
                : fertilizationModel!.fertilizerPeriods![i].duration.toString();
        firtiliserModel.dateList[i] =
            fertilizationModel!.fertilizerPeriods![i].date!;
      }
      if (value.statusCode == 200) {
        emit(FirtiliserSettingsGetSuccessState());
      }
    }).catchError((onError) {
      emit(FirtiliserSettingsGetFailState());
    });
  }

  putFertilizationPeriods({
    required List<Map<String, dynamic>> periodsList,
  }) async {
    await dio.put('$base/$fertilizerPeriodsList/$stationId',
        data: {'list': periodsList}).then((value) {
      if (value.statusCode == 200) {
        emit(FirtiliserSettingsSendSuccessState());
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(FirtiliserSettingsSendFailState());
    });
  }

  putFerListAfterDelete({
    required List<Map<String, dynamic>> periodsList,
  }) async {
    await dio.put('$base/$fertilizerPeriodsList/$stationId',
        data: {'list': periodsList}).then((value) {
      if (value.statusCode == 200) {
        emit(FirtiliserSettingsSendDelSuccessState());
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(FirtiliserSettingsSendFailState());
    });
  }

  List<Map<String, dynamic>> makeAList(int method2) {
    periodsList = [];
    for (int i = 0; i < firtiliserModel.controllersList.length; i++) {
      periodsList.add({
        "period_id": i + 1,
        "valve_id": 0,
        "starting_time": firtiliserModel.timeList[i].hour * 60 +
            firtiliserModel.timeList[i].minute,
        "duration": method2 == 1
            ? int.parse(firtiliserModel.controllersList[i].text)
            : 0,
        "quantity": method2 == 2
            ? int.parse(firtiliserModel.controllersList[i].text)
            : 0,
        "date": firtiliserModel.dateList[i]
      });
    }
    return periodsList;
  }

  bool checkOpenValveTimeParallel() {
    bool validInput = true;
    for (int i = 0; i < firtiliserModel.controllersList.length; i++) {
      for (int j = i + 1; j < firtiliserModel.controllersList.length; j++) {
        if (firtiliserModel.dateList[i] == firtiliserModel.dateList[j]) {
          if (firtiliserModel.timeList[i].hour * 60 +
                  firtiliserModel.timeList[i].minute <
              firtiliserModel.timeList[j].hour * 60 +
                  firtiliserModel.timeList[j].minute) {
            if (firtiliserModel.timeList[i].hour * 60 +
                    firtiliserModel.timeList[i].minute +
                    int.parse(firtiliserModel.controllersList[i].text) >
                firtiliserModel.timeList[j].hour * 60 +
                    firtiliserModel.timeList[j].minute) {
              validInput = false;
            }
          } else if (firtiliserModel.timeList[i].hour * 60 +
                  firtiliserModel.timeList[i].minute >
              firtiliserModel.timeList[j].hour * 60 +
                  firtiliserModel.timeList[j].minute) {
            if (firtiliserModel.timeList[j].hour * 60 +
                    firtiliserModel.timeList[j].minute +
                    int.parse(firtiliserModel.controllersList[j].text) >
                firtiliserModel.timeList[i].hour * 60 +
                    firtiliserModel.timeList[i].minute) {
              validInput = false;
            }
          }
        }
      }
    }
    return validInput;
  }

  bool checkOpenValveTimeSeriesByTime() {
    bool validInput = true;
    for (int i = 0; i < firtiliserModel.controllersList.length; i++) {
      int irrigationTime =
          int.parse(firtiliserModel.controllersList[i].text) * numOfActiveLines;
      int startTime1 = firtiliserModel.timeList[i].hour * 60 +
          firtiliserModel.timeList[i].minute;
      for (int j = i + 1; j < firtiliserModel.controllersList.length; j++) {
        int startTime2 = firtiliserModel.timeList[j].hour * 60 +
            firtiliserModel.timeList[j].minute;
        if (firtiliserModel.dateList[i] == firtiliserModel.dateList[j]) {
          if (startTime1 + irrigationTime > startTime2) {
            validInput = false;
            print(startTime1 + irrigationTime);
            print(startTime2);
          }
        }
      }
    }
    return validInput;
  }
}
