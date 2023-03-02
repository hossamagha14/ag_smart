import 'package:ag_smart/View%20Model/bloc/Device%20setup/device_setup_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeviceSetupCubit extends Cubit<DeviceSetupStates>{
  DeviceSetupCubit():super(DeviceSetupIntialState());

  static DeviceSetupCubit get(context)=>BlocProvider.of(context);
  bool securePassword=true;
  bool secureConfirmPassword=true;

  showPassword(){
    securePassword =! securePassword;
    emit(DeviceSetupShowPassWordState());
  }

  showConfirmPassword(){
    secureConfirmPassword =! secureConfirmPassword;
    emit(DeviceSetupShowConfirmPassWordState());
  }
}