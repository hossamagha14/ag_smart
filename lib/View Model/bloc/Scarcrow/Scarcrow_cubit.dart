// ignore_for_file: file_names

import 'package:ag_smart/View%20Model/bloc/Scarcrow/scarcrow_states.dart';
import 'package:ag_smart/View%20Model/database/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScarecrowCubit extends Cubit<ScarecrowStates> {
  ScarecrowCubit() : super(ScarecrowIntialState());

  static ScarecrowCubit get(context) => BlocProvider.of(context);
  var dio = Dio();
  TimeOfDay time1 = TimeOfDay.now();
  TimeOfDay time2 = TimeOfDay.now();
  bool done = false;

  chooseTime1(value) {
    time1 = value ?? TimeOfDay.now();
    emit(ScarecrowChooseTtimeState());
  }

  chooseTime2(value) {
    time2 = value ?? TimeOfDay.now();
    emit(ScarecrowChooseTtimeState());
  }

  issDone() {
    done = true;
    emit(ScarecrowIsDoneState());
  }

  put({
    required TimeOfDay startingTime,
    required TimeOfDay finishTime,
    required int onTime,
    required int offTime,
  }) async {
    int firstTime = startingTime.hour * 60 + startingTime.minute;
    int secondTime = finishTime.hour * 60 + finishTime.minute;
    await dio.put('$base/$animalRepellent/1', data: {
      "station_id": 1,
      "starting_time": firstTime,
      "finish_time": secondTime,
      "on_time": onTime,
      "off_time": offTime
    }).then((value) {
      if (value.statusCode == 200) {
        emit(ScarecrowPostSuccessState());
      }
    }).catchError((onError) {
      emit(ScarecrowPostFailState());
    });
  }

  int checkTime(){
    int startTime=time1.hour*60+time1.minute;
    int endTime=time2.hour*60+time2.minute;
    return startTime-endTime;
  }

}
