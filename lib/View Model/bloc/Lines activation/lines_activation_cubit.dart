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
  List<Map<String, dynamic>> valveDetails = [];

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
  }

  getNumberOfValves({required bool isEdit}) {
    emit(LinesActivationLoadingState());
    valves = [];
    dio.get('$base/$stationBySerial/$serialNumber').then((value) {
      if (value.statusCode == 200) {
        stationModel = StationModel.fromJson(value.data);
        if (stationModel!.pumpModel![0].pumpEnable == 1) {
          emit(LinesActivationNoPumpState());
        }
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
        if (isEdit == true) {
          for (int i = 0; i < valves.length; i++) {
            valves[i].diameterController.text =
                stationModel!.linesInfo![i].holeDiameter.toString();
            valves[i].numberController.text =
                stationModel!.linesInfo![i].holeNumber.toString();
          }
        }

        emit(LinesActivationGetSuccessState());
      }
    }).catchError((onError) {
      emit(LinesActivationGetFailState());
    });
  }

  sendValveInfo() async {
    await dio.put('$base/station/valve_info/list/$stationId',
        data: {"list": makeAList()}).then((value) {
      if (value.statusCode == 200) {
        emit(LinesActivationSendSuccessState());
      }
    }).catchError((onError) {
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

  List<Map<String, dynamic>> makeAList() {
    valveDetails = [];
    for (int i = 0; i < stationModel!.linesInfo!.length; i++) {
      valveDetails.add({
        "valve_id": i + 1,
        "hole_diameter": double.parse(valves[i].diameterController.text),
        "hole_number": double.parse(valves[i].numberController.text)
      });
    }
    return valveDetails;
  }

  postIrrigationType({
    required int activeValves,
  }) async {
    await dio.post('$base/$irrigationSettings/$stationId', data: {
      "station_id": stationId,
      "active_valves": activeValves,
      "settings_type": 0,
      "irrigation_method_1": 0,
      "irrigation_method_2": 0
    }).then((value) {
      if (value.statusCode == 200) {
        emit(LinesActivationSendSuccessState());
      }
    }).catchError((onError) {
      emit(LinesActivationSendFailState());
    });
  }

  putIrrigationType({required int activeValves}) async {
    await dio.put('$base/$irrigationSettings/$stationId', data: {
      "station_id": stationId,
      "active_valves": activeValves
    }).then((value) {
      if (value.statusCode == 200) {
        emit(LinesActivationSendSuccessState());
      }
    }).catchError((onError) {
      emit(LinesActivationSendFailState());
    });
  }
}
