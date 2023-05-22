import 'package:ag_smart/View%20Model/bloc/light/light_states.dart';
import 'package:ag_smart/View%20Model/database/end_points.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Model/days_model.dart';
import '../../../Model/features_model.dart';
import '../../../View/Reusable/toasts.dart';
import '../../../View/Screens/light.dart';
import '../../database/dio_helper.dart';

class LightCubit extends Cubit<LightStates> {
  LightCubit() : super(LightIntialState());

  static LightCubit get(context) => BlocProvider.of(context);

  int noDayIsChosen = 7;
  DioHelper dio = DioHelper();
  bool done = false;
  FeaturesModel? featuresModel;
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
    lightTime = value ?? TimeOfDay.now();
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

  getFeatures(context) async {
    try {
      Response<dynamic> response =
          await dio.get('$base/$features/$serialNumber');
      if (response.statusCode == 200) {
        featuresModel = FeaturesModel.fromJson(response.data);
        if (featuresModel!.light == 2) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LightScreen(),
              ));
        } else {
          errorToast(text[chosenLanguage]!['You are not subscribed for this feature']!);
        }
        emit(LightGetSuccessState());
      }
    } catch (e) {
      emit(LightGetFailState());
    }
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
