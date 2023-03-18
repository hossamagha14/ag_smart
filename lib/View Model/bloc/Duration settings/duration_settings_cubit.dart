import 'dart:math';

import 'package:ag_smart/Model/days_model.dart';
import 'package:ag_smart/Model/durationModel.dart';
import 'package:ag_smart/View%20Model/database/end_points.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Model/irrigation_settings_model.dart';
import 'duration_settings_states.dart';

class DurationSettingsCubit extends Cubit<DurationSettingsStates> {
  DurationSettingsCubit() : super(DurationSettingsIntialState());

  static DurationSettingsCubit get(context) => BlocProvider.of(context);

  var dio = Dio();
  DurationModel durationModel = DurationModel();
  List<DurationModel> durations = [];
  List<Map<String, dynamic>> periodsList = [];
  bool visible = false;
  IrrigationSettingsModel? irrigationSettingsModel;
  int noDayIsChosen = 7;
  List<DaysModel> days = [
    DaysModel(day: 'SAT', isOn: false),
    DaysModel(day: 'SUN', isOn: false),
    DaysModel(day: 'MON', isOn: false),
    DaysModel(day: 'TUE', isOn: false),
    DaysModel(day: 'WED', isOn: false),
    DaysModel(day: 'THU', isOn: false),
    DaysModel(day: 'FRI', isOn: false),
  ];

  pickTime(value, int containerIndex) {
    durations[containerIndex].time = value;
    emit(DurationSettingsPickTimeState());
  }

  addContainer() {
    durations.add(DurationModel());
    emit(DurationSettingsAddContainerState());
  }

  removeContainer(int containerIndex) {
    durations.removeAt(containerIndex);
    emit(DurationSettingsAddContainerState());
  }

  showDeleteButton() {
    visible = !visible;
    emit(DurationSettingsShowDeleteButtonState());
  }

  chooseThisDay(int dayIndex) {
    days[dayIndex].isOn = !days[dayIndex].isOn!;
    if (days[dayIndex].isOn == true) {
      noDayIsChosen--;
    } else if (days[dayIndex].isOn == false) {
      noDayIsChosen++;
    }

    emit(DurationSettingsChooseDayState());
  }

  checkOpenValveTimeSeriesByCycle({
    required hours,
    required openValveTime,
  }) {
    double minutes = hours * 60;
    double availableOpenValveTime = minutes / numOfActiveLines;
    if (openValveTime > availableOpenValveTime || openValveTime == 0) {
      emit(DurationSettingsErrorState());
    } else {
      emit(DurationSettingsMoveToNextPageState());
    }
  }

  checkOpenValveTimeParallel({
    required hours,
    required openValveTime,
  }) {
    double availableOpenValveTime = hours * 60;
    if (openValveTime > availableOpenValveTime || openValveTime == 0) {
      emit(DurationSettingsErrorState());
    } else {
      emit(DurationSettingsMoveToNextPageState());
    }
  }

  putIrrigationCycle({
    required int valveId,
    required int interval,
    required int duration,
    required int quantity,
    required int weekDays,
  }) async {
    await dio.put('$base/$irrigationCycle/1/1', data: {
      "valve_id": valveId,
      "interval": interval,
      "duration": duration,
      "quantity": quantity,
      "week_days": weekDays
    }).then((value) {
      print(value.data);
      if (value.statusCode == 200) {
        emit(DurationSettingsSendSuccessState());
      }
    }).catchError((onError) {
      print(onError);
      emit(DurationSettingsSendFailedState());
    });
  }

  List<Map<String, dynamic>> makeAList({required weekday}) {
    for (int i = 0; i < durations.length; i++) {
      periodsList.add({
        "period_id": i + 1,
        "valve_id": 0,
        "starting_time": durations[i].time.hour * 60 + durations[i].time.minute,
        "duration": irrigationSettingsModel!.irrigationMethod2 == 1
            ? int.parse(durations[i].controller.text)
            : 0,
        "quantity": irrigationSettingsModel!.irrigationMethod2 == 2
            ? int.parse(durations[i].controller.text)
            : 0,
        "week_days": weekday
      });
    }
    return periodsList;
  }

  putIrrigationHourList({
    required int stationId,
    required List<Map<String, dynamic>> periodsList,
  }) async {
    await dio.put('$base/$irrigationPeriodsList/$stationId',
        data: {'list': periodsList}).then((value) {
      if (value.statusCode == 200) {
        print(value.data);
        emit(DurationSettingsSendSuccessState());
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(DurationSettingsSendFailedState());
    });
  }

  int toBinary() {
    int activeDays = 0;
    for (int i = 0; i < 7; i++) {
      days[i].binaryDays = pow(2, i).toInt();
      if (days[i].isOn == true) {
        activeDays = activeDays + days[i].binaryDays;
      }
    }
    return activeDays;
  }

  getPeriods({
    required int stationId,
  }) async {
    durations = [];
    await dio.get('$base/$irrigationSettings/$stationId').then((value) {
      irrigationSettingsModel = IrrigationSettingsModel.fromJson(value.data);
      for (int i = 0;
          i < irrigationSettingsModel!.customValvesSettings!.length;
          i++) {
        addContainer();
        irrigationSettingsModel!.irrigationMethod2 == 1
            ? durations[i].controller.text = irrigationSettingsModel!
                .irrigationPeriods![i].duration
                .toString()
            : durations[i].controller.text = irrigationSettingsModel!
                .irrigationPeriods![i].quantity
                .toString();
      }
      if (value.statusCode == 200) {
        emit(DurationSettingsGetSuccessState());
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(DurationSettingsGetFailState());
    });
  }
}
