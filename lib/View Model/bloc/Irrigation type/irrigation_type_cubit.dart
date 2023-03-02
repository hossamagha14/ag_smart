import 'package:ag_smart/View%20Model/bloc/Irrigation%20type/irrigation_type_states.dart';
import 'package:ag_smart/View%20Model/database/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IrrigationTypeCubit extends Cubit<IrrigationTypesStates> {
  IrrigationTypeCubit() : super(IrrigationTypeIntialState());

  static IrrigationTypeCubit get(context) => BlocProvider.of(context);
  var dio = Dio();
  bool active = false;
  int irrigationType = 0;
  bool? isSeries;
  bool? accordingToHour;
  bool? accordingToQuantity;
  int? irrigationMethod1;
  int? irrigationMethod2;

  activate() {
    if (irrigationType == 2) {
      active = !active;
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

  putIrrigationType({
    required int activeValves,
    required int irrigationType,
    required int irrigationMethod1,
    required int irrigationMethod2,
  }) async {
    await dio.put('$base/$irrigationSettings/1', data: {
      "station_id": 1,
      "active_valves": activeValves,
      "settings_type": irrigationType,
      "irrigation_method_1": irrigationMethod1,
      "irrigation_method_2": irrigationMethod2
    }).then((value) {
      print(value.data);
      if (value.statusCode == 200) {
        emit(IrrigationTypeSendSuccessState());
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(IrrigationTypeSendFailState());
    });
  }

  postIrrigationType({
    required int activeValves,
    required int irrigationType,
    required int irrigationMethod1,
    required int irrigationMethod2,
  }) async {
    await dio.post('$base/$irrigationSettings/1', data: {
      "station_id": 1,
      "active_valves": activeValves,
      "settings_type": irrigationType,
      "irrigation_method_1": irrigationMethod1,
      "irrigation_method_2": irrigationMethod2
    }).then((value) {
      print(value.data);
      if (value.statusCode == 200) {
        emit(IrrigationTypeSendSuccessState());
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(IrrigationTypeSendFailState());
    });
  }
}
