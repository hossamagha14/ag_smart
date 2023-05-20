import 'package:ag_smart/View%20Model/database/end_points.dart';
import 'package:ag_smart/View/Reusable/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/dio_helper.dart';
import 'pump_settings_states.dart';

class PumpSettingsCubit extends Cubit<PumpSettingsStates> {
  PumpSettingsCubit() : super(PumpSettingIntialState());
  static PumpSettingsCubit get(context) => BlocProvider.of(context);

  int groupValue = 0;
  bool isPressed = false;
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
      "pump_enable": pumpEnabled,
      "pump_power": pumpPower,
      "pressure_switch": pressureSwitch
    }).then((value) {
      emit(PumpSettingSendSuccessState());
    }).catchError((onError) {
      emit(PumpSettingSendFailState());
    });
  }
}
