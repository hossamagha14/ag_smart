import 'dart:math';
import 'package:ag_smart/Model/features_model.dart';
import 'package:ag_smart/Model/valve_model.dart';
import 'package:ag_smart/View%20Model/bloc/Lines%20activation/lines_activation_states.dart';
import 'package:ag_smart/View%20Model/database/cache_helpher.dart';
import 'package:ag_smart/View%20Model/database/end_points.dart';
import 'package:ag_smart/View/Reusable/global.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Model/station_model.dart';
import '../../database/dio_helper.dart';

class LinesActivationCubit extends Cubit<LinesActivationStates> {
  LinesActivationCubit() : super(LinesActivationIntialState());

  static LinesActivationCubit get(context) => BlocProvider.of(context);
  List<ValveModel> valves = [];
  DioHelper dio = DioHelper();
  int? statusCode;
  StationModel? stationModel;
  List<int> activeBinary = [];
  List<int> activeValves = [];
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

  getNumberOfValves() {
    emit(LinesActivationLoadingState());
    valves = [];
    dio.get('$base/$stationBySerial/$serialNumber').then((value) {
      if (value.statusCode == 200) {
        stationModel = StationModel.fromJson(value.data);
        for (int i = 0; i < stationModel!.features![0].linesNumber!; i++) {
          valves.add(ValveModel());
        }
        if (stationModel!.irrigationSettings!.isNotEmpty) {
          activeValves = [];
          int numberOfOnValves = 0;
          int decimalNumber =
              stationModel!.irrigationSettings![0].activeValves!;
          while (decimalNumber > 0) {
            int n = (decimalNumber % 2);
            activeValves.add(n);
            double x = decimalNumber / 2;
            decimalNumber = x.toInt();
          }
          while (
              activeValves.length < stationModel!.features![0].linesNumber!) {
            activeValves.add(0);
          }
          for (int i = 0; i < activeValves.length; i++) {
            if (activeValves[i] == 1) {
              numberOfOnValves++;
            }
          }
          CacheHelper.saveData(
              key: 'numOfActiveLines', value: numberOfOnValves);
        }
        for (int i = 0; i < valves.length; i++) {
          if (activeValves[i] == 1) {
            valves[i].isActive = true;
          }
        }

        emit(LinesActivationGetSuccessState());
      }
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
  await dio.put('$base$valveInfo/$stationId/$valveId', data: {
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
    print(binaryValves);
  }
}
