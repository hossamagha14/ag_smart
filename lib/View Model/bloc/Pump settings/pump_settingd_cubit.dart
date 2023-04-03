import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pump_settings_states.dart';

class PumpSettingsCubit extends Cubit<PumpSettingsStates> {
  PumpSettingsCubit() : super(PumpSettingIntialState());
  static PumpSettingsCubit get(context) => BlocProvider.of(context);

  int groupValue = 0;
  bool isPressed=false;

  choosePumpSettings(int value,TextEditingController controller) {
    groupValue = value;
    if(groupValue==1){
      isPressed=true;
    }
    else{
      isPressed=false;
      controller.text='';
    }
    emit(PumpSettingSelectState());
  }

}
