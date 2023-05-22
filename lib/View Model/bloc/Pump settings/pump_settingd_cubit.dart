import 'package:ag_smart/View%20Model/database/end_points.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Model/pump_model.dart';
import '../../database/dio_helper.dart';
import 'pump_settings_states.dart';

class PumpSettingsCubit extends Cubit<PumpSettingsStates> {
  PumpSettingsCubit() : super(PumpSettingIntialState());
  static PumpSettingsCubit get(context) => BlocProvider.of(context);

  int groupValue = 0;
  bool isPressed = false;
  PumpModel? pumpModel;
  DioHelper dio = DioHelper();

  choosePumpSettings(int value, TextEditingController controller) {
    groupValue = value;
    if (groupValue == 2) {
      isPressed = true;
    } else {
      isPressed = false;
      controller.text = '';
    }
    emit(PumpSettingSelectState());
  }

  putPumpSettings(
      {required double pumpPower,
      required int pumpEnabled,
      required int pressureSwitch}) {
    dio.put('$base/$pumpSettings/$stationId', data: {
      "station_id": stationId,
      "pump_enable": pumpEnabled,
      "pump_power": pumpPower,
      "pressure_switch": pressureSwitch
    }).then((value) {
      emit(PumpSettingSendSuccessState());
    }).catchError((onError) {
      emit(PumpSettingSendFailState());
    });
  }

  getPumpSettings({required TextEditingController power}) {
    emit(PumpSettingLoadingState());
    dio.get('$base/station/pump_info/$stationId').then((value) {
      pumpModel = PumpModel.fromJson(value.data);
      groupValue = pumpModel!.pumpEnable!;
      if (pumpModel!.pumpEnable == 2) {
        power.text = pumpModel!.pumpPower.toString();
      }
      emit(PumpSettingGetSuccessState());
    }).catchError((onError) {
      emit(PumpSettingGetFailState());
    });
  }
}
