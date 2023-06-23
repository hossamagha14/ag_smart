import 'package:ag_smart/View%20Model/bloc/light/light_states.dart';
import 'package:ag_smart/View%20Model/database/end_points.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Model/features_model.dart';
import '../../../Model/station_model.dart';
import '../../Repo/auth_bloc.dart';
import '../../database/dio_helper.dart';
import '../commom_states.dart';

class LightCubit extends Cubit<CommonStates> {
  AuthBloc authBloc;
  late DioHelper dio;
  LightCubit(this.authBloc) : super(LightIntialState()) {
    dio = DioHelper(authBloc);
  }

  static LightCubit get(context) => BlocProvider.of(context);

  FeaturesModel? featuresModel;
  StationModel? stationModel;
  List<int> activeDays = [];
  TimeOfDay lightTime = TimeOfDay.now();

  chooseTime(value) {
    lightTime = value ?? TimeOfDay.now();
    emit(LightChooseTimeState());
  }

  putLight(
      {required int stationId,
      required TimeOfDay startTime,
      required int duration}) async {
    int time = startTime.hour * 60 + startTime.minute;
    await dio.put('$base/$light/$stationId',
        data: {"starting_time": time, "duration": duration}).then((value) {
      if (value.statusCode == 200) {
        emit(LightPutSuccessState());
      }
    }).catchError((onError) {
      emit(LightPutFailState());
    });
  }

  getData({required TextEditingController duration}) {
    emit(LightLoadingState());
    double startingHour = 0;
    double startingMinute = 0;
    dio.get('$base/$stationBySerial/$serialNumber').then((value) {
      stationModel = StationModel.fromJson(value.data);
      if (stationModel!.lightSettings!.isNotEmpty) {
        startingHour = stationModel!.lightSettings![0].startingTime! / 60;
        startingMinute = stationModel!.lightSettings![0].startingTime! -
            startingHour.toInt() * 60;

        lightTime = TimeOfDay(
            hour: startingHour.toInt(), minute: startingMinute.toInt());
        duration.text = stationModel!.lightSettings![0].duration.toString();
      }
      emit(LightGetSuccessState());
    }).catchError((onError) {
      emit(LightGetFailState());
    });
  }
}
