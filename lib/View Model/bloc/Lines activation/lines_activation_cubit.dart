import 'dart:math';
import 'package:ag_smart/Model/features_model.dart';
import 'package:ag_smart/Model/valve_model.dart';
import 'package:ag_smart/View%20Model/bloc/Lines%20activation/lines_activation_states.dart';
import 'package:ag_smart/View%20Model/database/cache_helpher.dart';
import 'package:ag_smart/View%20Model/database/end_points.dart';
import 'package:ag_smart/View/Reusable/global.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LinesActivationCubit extends Cubit<LinesActivationStates> {
  LinesActivationCubit() : super(LinesActivationIntialState());

  static LinesActivationCubit get(context) => BlocProvider.of(context);
  List<ValveModel> valves = [];
  var dio = Dio();
  int? statusCode;
  List<int> activeBinary = [];
  FeaturesModel? featuresModel;

  activateLine(int index) {
    valves[index].isActive = !valves[index].isActive;
    emit(LinesActivationActiveState());
  }

  numberOfActivelines() {
    numOfActiveLines = 0;
    for (int i = 0; i < valves.length; i++) {
      if (valves[i].isActive == true) {
        numOfActiveLines++;
      }
    }
    CacheHelper.saveData(key: 'numOfActiveLines', value: numOfActiveLines);
    print('$numOfActiveLines active valves');
  }

  getNumberOfValves({required int stationId}) {
    emit(LinesActivationLoadingState());
    valves = [];
    dio.get('$base/$features/$stationId').then((value) {
      featuresModel = FeaturesModel.fromJson(value.data);
      for (int i = 0; i < featuresModel!.linesNumber!; i++) {
        valves.add(ValveModel());
      }
      emit(LinesActivationGetSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(LinesActivationGetFailState());
    });
  }

  sendValveInfo({
    required int valveId,
    required double valveDiameter,
    required double valveNumber,
  }) async {
    await dio.put('$base$valveInfo/1/$valveId', data: {
      "valve_id": valveId,
      "hole_diameter": valveDiameter,
      "hole_number": valveNumber
    }).then((value) {
      if (value.statusCode == 200) {
        print(value.data);
        emit(LinesActivationSendSuccessState());
      }
    }).catchError((onError) {
      print(onError);
      emit(LinesActivationSendFailState());
    });
  }

  toBinary(int numberOfValves) {
    int activeValves = 0;
    for (int i = 0; i < numberOfValves; i++) {
      valves[i].valveBinary = pow(2, i).toInt();
      if (valves[i].isActive == true) {
        activeValves = activeValves + valves[i].valveBinary!;
      }
    }
    binaryValves = activeValves;
  }
}
