import 'package:ag_smart/Model/days_model.dart';
import 'package:ag_smart/Model/durationModel.dart';
import 'package:ag_smart/View%20Model/database/end_points.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'duration_settings_states.dart';

class DurationSettingsCubit extends Cubit<DurationSettingsStates> {
  DurationSettingsCubit() : super(DurationSettingsIntialState());

  static DurationSettingsCubit get(context) => BlocProvider.of(context);

  var dio = Dio();
  DurationModel durationModel = DurationModel();
  List<DurationModel> durations = [DurationModel()];
  bool visible = false;
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

  putIrrigationHour({
    required int stationId,
    required int periodId,
    required int valveId,
    required TimeOfDay startTime,
    required int duration,
    required int quantity,
    required int weekDays,
  }) async {
    int time = startTime.hour * 60 + startTime.minute;
    await dio.put('$base/$irrigationPeriods/$stationId/$valveId/$periodId', data: {
      "period_id": periodId,
      "valve_id": valveId,
      "starting_time": time,
      "duration": duration,
      "quantity": quantity,
      "week_days": weekDays
    }).then((value) {
      if (value.statusCode == 200) {
        print(value.data);
        emit(DurationSettingsSendSuccessState());
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(DurationSettingsSendFailedState());
    });
  }
}
