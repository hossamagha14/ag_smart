import 'package:ag_smart/View%20Model/bloc/light/light_states.dart';
import 'package:ag_smart/View%20Model/database/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Model/days_model.dart';

class LightCubit extends Cubit<LightStates> {
  LightCubit() : super(LightIntialState());

  static LightCubit get(context) => BlocProvider.of(context);

  int noDayIsChosen = 7;
  var dio = Dio();
  bool done = false;
  List<DaysModel> days = [
    DaysModel(day: 'SAT', isOn: false),
    DaysModel(day: 'SUN', isOn: false),
    DaysModel(day: 'MON', isOn: false),
    DaysModel(day: 'TUE', isOn: false),
    DaysModel(day: 'WED', isOn: false),
    DaysModel(day: 'THU', isOn: false),
    DaysModel(day: 'FRI', isOn: false),
  ];
  TimeOfDay lightTime = TimeOfDay.now();

  chooseTime(value) {
    lightTime = value??TimeOfDay.now();
    emit(LightChooseTimeState());
  }

  issDone() {
    done = true;
    emit(LightIsDoneState());
  }

  chooseThisDay(int dayIndex) {
    days[dayIndex].isOn = !days[dayIndex].isOn!;
    if (days[dayIndex].isOn == true) {
      noDayIsChosen--;
    } else if (days[dayIndex].isOn == false) {
      noDayIsChosen++;
    }
    emit(LightChooseDayState());
  }

  putLight(
      {required int stationId,
      required TimeOfDay startTime,
      required int duration}) async {
    int time = startTime.hour * 60 + startTime.minute;
    await dio.put('$base/$light/$stationId',
        data: {"starting_time": time, "duration": duration}).then((value) {
      if (value.statusCode == 200) {
        print(value.data);
        emit(LightPutSuccessState());
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(LightPutFailState());
    });
  }
}
