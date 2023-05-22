// ignore_for_file: file_names

import 'package:ag_smart/View%20Model/bloc/Scarcrow/scarcrow_states.dart';
import 'package:ag_smart/View%20Model/database/end_points.dart';
import 'package:ag_smart/View/Reusable/toasts.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Model/features_model.dart';
import '../../../View/Reusable/text.dart';
import '../../../View/Screens/scarecrow.dart';
import '../../database/dio_helper.dart';

class ScarecrowCubit extends Cubit<ScarecrowStates> {
  ScarecrowCubit() : super(ScarecrowIntialState());

  static ScarecrowCubit get(context) => BlocProvider.of(context);
  DioHelper dio = DioHelper();
  FeaturesModel? featuresModel;
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

  getFeatures(context) async {
    try {
      Response<dynamic> response =
          await dio.get('$base/$features/$serialNumber');
      if (response.statusCode == 200) {
        featuresModel = FeaturesModel.fromJson(response.data);
        if (featuresModel!.animal == 2) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScarecrowScreen(),
              ));
        } else {
          errorToast(text[chosenLanguage]!['You are not subscribed for this feature']!);
        }
        emit(ScarecrowGetSuccessState());
      }
    } catch (e) {
      emit(ScarecrowGetFailState());
    }
  }

  int checkTime() {
    int startTime = time1.hour * 60 + time1.minute;
    int endTime = time2.hour * 60 + time2.minute;
    if (endTime < startTime) {
      endTime = endTime + 1440;
    }
    return endTime - startTime;
  }
}
