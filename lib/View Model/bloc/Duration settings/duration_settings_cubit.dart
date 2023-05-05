import 'dart:math';

import 'package:ag_smart/Model/days_model.dart';
import 'package:ag_smart/Model/durationModel.dart';
import 'package:ag_smart/View%20Model/database/end_points.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Model/irrigation_settings_model.dart';
import '../../database/dio_helper.dart';
import 'duration_settings_states.dart';

class DurationSettingsCubit extends Cubit<DurationSettingsStates> {
  DurationSettingsCubit() : super(DurationSettingsIntialState());

  static DurationSettingsCubit get(context) => BlocProvider.of(context);

  DioHelper dio = DioHelper();
  DurationModel durationModel = DurationModel();
  List<Map<String, dynamic>> periodsList = [];
  bool visible = false;
  IrrigationSettingsModel? irrigationSettingsModel;
  int noDayIsChosen = 7;
  List<int> activeDays = [];
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
    durationModel.time[containerIndex] = value ?? TimeOfDay.now();
    emit(DurationSettingsPickTimeState());
  }

  addContainer({required int hour, required int minute}) {
    durationModel.time.add(TimeOfDay(hour: hour, minute: minute));
    durationModel.controller.add(TextEditingController());
    emit(DurationSettingsAddContainerState());
  }

  removeContainerFromdb(
      {required int containerIndex,
      required int valveId,
      required int weekday,
      required int periodId}) async {
    await dio
        .delete('$base/$irrigationPeriods/$stationId/$valveId/$periodId')
        .then((value) {
      if (value.statusCode == 200) {
        removeContainer(
          containerIndex: containerIndex,
        );
        makeAList(weekday: weekday);
        putIrrigationHourListAfterDelete(periodsList: periodsList);
      }
    }).catchError((onError) {
      emit(DurationSettingsDelFailState());
    });
  }

  removeContainer({required int containerIndex}) {
    durationModel.time.removeAt(containerIndex);
    durationModel.controller.removeAt(containerIndex);
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

  checkOpenValveTimeParallelByCycle({
    required hours,
    required openValveTime,
  }) {
    double availableOpenValveTime = hours * 60;
    if (availableOpenValveTime < openValveTime || openValveTime == 0) {
      emit(DurationSettingsErrorState());
    } else {
      emit(DurationSettingsMoveToNextPageState());
    }
  }

  bool checkOpenValveTimeParallel() {
    bool validInput = true;
    for (int i = 0; i < durationModel.controller.length; i++) {
      for (int j = i + 1; j < durationModel.controller.length; j++) {
        if (durationModel.time[i].hour * 60 + durationModel.time[i].minute <
            durationModel.time[j].hour * 60 + durationModel.time[j].minute) {
          if (durationModel.time[i].hour * 60 +
                  durationModel.time[i].minute +
                  int.parse(durationModel.controller[i].text) >
              durationModel.time[j].hour * 60 + durationModel.time[j].minute) {
            validInput = false;
          }
        } else if (durationModel.time[i].hour * 60 +
                durationModel.time[i].minute >
            durationModel.time[j].hour * 60 + durationModel.time[j].minute) {
          if (durationModel.time[j].hour * 60 +
                  durationModel.time[j].minute +
                  int.parse(durationModel.controller[j].text) >
              durationModel.time[i].hour * 60 + durationModel.time[i].minute) {
            validInput = false;
          }
        }
      }
    }
    return validInput;
  }

  bool checkOpenValveTimeSeriesByTime() {
    bool validInput = true;
    for (int i = 0; i < durationModel.controller.length; i++) {
      int irrigationTime =
          int.parse(durationModel.controller[i].text) * numOfActiveLines;
      int startTime1 =
          durationModel.time[i].hour * 60 + durationModel.time[i].minute;
      for (int j = i + 1; j < durationModel.controller.length; j++) {
        int startTime2 =
            durationModel.time[j].hour * 60 + durationModel.time[j].minute;
        int irrigationTime2 =
            int.parse(durationModel.controller[j].text) * numOfActiveLines;
        if (startTime1 < startTime2) {
          if (startTime1 + irrigationTime > startTime2) {
            validInput = false;
          }
        } else if (startTime1 < startTime2) {
          if (startTime2 + irrigationTime2 > startTime1) {
            validInput = false;
          }
        }
      }
    }
    return validInput;
  }

  putIrrigationCycle({
    required int valveId,
    required int interval,
    required int duration,
    required int quantity,
    required int weekDays,
  }) async {
    await dio.put('$base/$irrigationCycle/$stationId/0', data: {
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
    periodsList = [];
    for (int i = 0; i < durationModel.controller.length; i++) {
      periodsList.add({
        "period_id": i + 1,
        "valve_id": 0,
        "starting_time":
            durationModel.time[i].hour * 60 + durationModel.time[i].minute,
        "duration": irrigationSettingsModel!.irrigationMethod2 == 1
            ? int.parse(durationModel.controller[i].text)
            : 0,
        "quantity": irrigationSettingsModel!.irrigationMethod2 == 2
            ? int.parse(durationModel.controller[i].text)
            : 0,
        "week_days": weekday
      });
    }
    return periodsList;
  }

  putIrrigationHourListAfterDelete({
    required List<Map<String, dynamic>> periodsList,
  }) async {
    await dio.put('$base/$irrigationPeriodsList/$stationId',
        data: {'list': periodsList}).then((value) {
      if (value.statusCode == 200) {
        print(value.data);
        emit(DurationSettingsSendDelSuccessState());
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(DurationSettingsSendFailedState());
    });
  }

  putIrrigationHourList({
    required List<Map<String, dynamic>> periodsList,
  }) async {
    await dio.put('$base/$irrigationPeriodsList/$stationId',
        data: {'list': periodsList}).then((value) {
      if (value.statusCode == 200) {
        print(value.data);
        emit(DurationSettingsSendSuccessState());
        durationModel.controller = [];
        durationModel.time = [];
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(DurationSettingsSendFailedState());
    });
  }

  int toDecimal() {
    int activeDays = 0;
    for (int i = 0; i < 7; i++) {
      days[i].binaryDays = pow(2, i).toInt();
      if (days[i].isOn == true) {
        activeDays = activeDays + days[i].binaryDays;
      }
    }
    return activeDays;
  }

  getPeriods() async {
    durationModel.controller = [];
    durationModel.time = [];
    await dio.get('$base/$irrigationSettings/$stationId').then((value) {
      irrigationSettingsModel = IrrigationSettingsModel.fromJson(value.data);
      getActiveDays(
          decimalNumber:
              irrigationSettingsModel!.irrigationPeriods![0].weekDays!);
      for (int i = 0; i < activeDays.length; i++) {
        if (activeDays[i] == 1) {
          days[i].isOn = true;
          noDayIsChosen--;
        }
      }
      for (int i = 0;
          i < irrigationSettingsModel!.irrigationPeriods!.length;
          i++) {
        double hourDouble =
            irrigationSettingsModel!.irrigationPeriods![i].startingTime! / 60;
        int hour = hourDouble.toInt();
        int minute =
            irrigationSettingsModel!.irrigationPeriods![i].startingTime! -
                hour * 60;
        addContainer(hour: hour, minute: minute);
        irrigationSettingsModel!.irrigationMethod2 == 1
            ? durationModel.controller[i].text = irrigationSettingsModel!
                .irrigationPeriods![i].duration
                .toString()
            : durationModel.controller[i].text = irrigationSettingsModel!
                .irrigationPeriods![i].quantity
                .toString();
      }
      if (value.statusCode == 200) {
        print('${value.data} get');
        emit(DurationSettingsGetSuccessState());
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(DurationSettingsGetFailState());
    });
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
