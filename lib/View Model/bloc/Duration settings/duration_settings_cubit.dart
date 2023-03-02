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
  int index = 1;
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
    index++;
    durations.add(DurationModel());
    emit(DurationSettingsAddContainerState());
  }

  removeContainer(int containerIndex) {
    index--;
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

  postIrrigationPeriod({
    required int valveId,
    required TimeOfDay time,
    required int duration,
    required int quantity,
    required int weekDays,
    required int periodId,
  }) async {
    int startTime = time.hour * 60 + time.minute;
    await dio.post('$base/$irrigationPeriods/1/$valveId/$periodId', data: {
      "valve_id": valveId,
      "starting_time": startTime,
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

  putIrrigationPeriod({
    required TimeOfDay time,
    required int duration,
    required int quantity,
    required int weekDays,
    required int periodId,
  }) async {
    int startTime = time.hour * 60 + time.minute;
    await dio.put('$base/$irrigationPeriods/1/1/$periodId', data: {
      "starting_time": startTime,
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

  postIrrigationCycle({
    required int valveId,
    required int interval,
    required int duration,
    required int quantity,
    required int weekDays,
  }) async {
    await dio.post('$base/$irrigationCycle/1/$valveId', data: {
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
}
