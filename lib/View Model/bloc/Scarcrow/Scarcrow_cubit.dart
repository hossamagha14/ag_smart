// ignore_for_file: file_names

import 'package:ag_smart/View%20Model/bloc/Scarcrow/scarcrow_states.dart';
import 'package:ag_smart/View%20Model/database/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Model/features_model.dart';
import '../../../Model/station_model.dart';
import '../../../View/Reusable/text.dart';
import '../../Repo/auth_bloc.dart';
import '../../database/dio_helper.dart';
import '../commom_states.dart';

class ScarecrowCubit extends Cubit<CommonStates> {
  AuthBloc authBloc;
  late DioHelper dio;
  ScarecrowCubit(this.authBloc) : super(ScarecrowIntialState()) {
    dio = DioHelper(authBloc);
  }

  static ScarecrowCubit get(context) => BlocProvider.of(context);

  FeaturesModel? featuresModel;
  StationModel? stationModel;
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

  put({
    required TimeOfDay startingTime,
    required TimeOfDay finishTime,
    required int onTime,
    required int offTime,
  }) async {
    int firstTime = startingTime.hour * 60 + startingTime.minute;
    int secondTime = finishTime.hour * 60 + finishTime.minute;
    await dio.put('$base/$animalRepellent/$stationId', data: {
      "station_id": stationId,
      "start_time": firstTime,
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

  int checkTime() {
    int startTime = time1.hour * 60 + time1.minute;
    int endTime = time2.hour * 60 + time2.minute;
    if (endTime < startTime) {
      endTime = endTime + 1440;
    }
    return endTime - startTime;
  }

  getData(
      {required TextEditingController onTime,
      required TextEditingController offTime}) {
    emit(ScarecrowLoadingState());
    double startingHour = 0;
    double startingMinute = 0;
    double endingHour = 0;
    double endingMinute = 0;
    dio.get('$base/$stationBySerial/$serialNumber').then((value) {
      stationModel = StationModel.fromJson(value.data);
      if (stationModel!.animalRepellent!.isNotEmpty) {
        startingHour = stationModel!.animalRepellent![0].startTime! / 60;
        startingMinute = stationModel!.animalRepellent![0].startTime! -
            startingHour.toInt() * 60;
        endingHour = stationModel!.animalRepellent![0].finishTime! / 60;
        endingMinute = stationModel!.animalRepellent![0].finishTime! -
            endingHour.toInt() * 60;

        time1 = TimeOfDay(
            hour: startingHour.toInt(), minute: startingMinute.toInt());
        time2 =
            TimeOfDay(hour: endingHour.toInt(), minute: endingMinute.toInt());
        onTime.text = stationModel!.animalRepellent![0].onTime.toString();
        offTime.text = stationModel!.animalRepellent![0].offTime.toString();
      }
      emit(ScarecrowGetSuccessState());
    }).catchError((onError) {
      emit(ScarecrowGetFailState());
    });
  }
}
