import 'package:ag_smart/View%20Model/bloc/Irrigation%20type/irrigation_type_states.dart';
import 'package:ag_smart/View%20Model/database/end_points.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Repo/auth_bloc.dart';
import '../../database/dio_helper.dart';
import '../commom_states.dart';

class IrrigationTypeCubit extends Cubit<CommonStates> {
  AuthBloc authBloc;
  late DioHelper dio;
  IrrigationTypeCubit(this.authBloc) : super(IrrigationTypeIntialState()) {
    dio = DioHelper(authBloc);
  }

  static IrrigationTypeCubit get(context) => BlocProvider.of(context);
  bool active = false;
  int irrigationType = 0;
  bool? isSeries;
  bool? accordingToHour;
  bool? accordingToQuantity;
  int? irrigationMethod1;
  int? irrigationMethod2;

  activate(int pressure) {
    if (pressure == 2) {
      if (irrigationType == 2) {
        active = !active;
      }
    }
    emit(IrrigationTypeActivateState());
  }

  chooseSeriesIrrigation() {
    irrigationType = 1;
    isSeries = true;
    active = false;
    emit(IrrigationTypeSeriesStates());
  }

  chooseParallelIrrigation() {
    irrigationType = 2;
    isSeries = false;
    emit(IrrigationTypeParallelStates());
  }

  chooseCustomIrrigation() {
    irrigationType = 3;
    isSeries = false;
    active = false;
    emit(IrrigationTypeCustomStates());
  }

  chooseAutoIrrigation() {
    irrigationType = 4;
    isSeries = false;
    active = false;
    emit(IrrigationTypeAutoStates());
  }

  chooseAccordingToHour() {
    accordingToHour = true;
    irrigationMethod1 = 2;
    emit(IrrigationTypeHourState());
  }

  chooseAccordingToPeriod() {
    accordingToHour = false;
    irrigationMethod1 = 1;
    emit(IrrigationTypePeriodState());
  }

  chooseAccordingToQuantity() {
    accordingToQuantity = true;
    irrigationMethod2 = 2;
    emit(IrrigationTypeQuantityState());
  }

  chooseAccordingToTime() {
    accordingToQuantity = false;
    irrigationMethod2 = 1;
    emit(IrrigationTypeTimeState());
  }

  putPressureSwitch({required int pressurSwitch}) {
    dio.put('$base/$pumpSettings/$stationId', data: {
      "station_id": stationId,
      "pressure_switch": pressurSwitch
    }).then((value) {
      print(value.data);
      emit(IrrigationTypeSendSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(IrrigationTypeSendFailState());
    });
  }

  putIrrigationType(
      {required int activeValves,
      required int irrigationType,
      required int irrigationMethod1,
      required int irrigationMethod2,
      required int pressureSwitch,
      required int pressure}) async {
    await dio.put('$base/$irrigationSettings/$stationId', data: {
      "station_id": stationId,
      "active_valves": activeValves,
      "settings_type": irrigationType,
      "irrigation_method_1": irrigationMethod1,
      "irrigation_method_2": irrigationMethod2
    }).then((value) {
      if (value.statusCode == 200) {
        putStationConfig(pressure: pressure, pressureSwitch: pressureSwitch);
      }
    }).catchError((onError) {
      emit(IrrigationTypeSendFailState());
    });
  }

  putStationConfig({required int pressure, required int pressureSwitch}) async {
    try {
      Response<dynamic> response = await dio.put('$base/$station',
          data: {"serial_number": serialNumber, "configured": 1});
      if (response.statusCode == 200) {
        if (pressure == 2) {
          putPressureSwitch(pressurSwitch: pressureSwitch);
        } else {
          emit(IrrigationTypeSendSuccessState());
        }
      }
    } catch (e) {
      emit(IrrigationTypeSendFailState());
    }
  }
}
