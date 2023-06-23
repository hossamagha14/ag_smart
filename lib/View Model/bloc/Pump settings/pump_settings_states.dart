import '../commom_states.dart';

abstract class PumpSettingsStates extends CommonStates{}

class PumpSettingIntialState extends PumpSettingsStates {}

class PumpSettingSelectState extends PumpSettingsStates {}

class PumpSettingSendSuccessState extends PumpSettingsStates {}

class PumpSettingSendFailState extends PumpSettingsStates {}

class PumpSettingGetSuccessState extends PumpSettingsStates {}

class PumpSettingGetFailState extends PumpSettingsStates {}

class PumpSettingLoadingState extends PumpSettingsStates {}
