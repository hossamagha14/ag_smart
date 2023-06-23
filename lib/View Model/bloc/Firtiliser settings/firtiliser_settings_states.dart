import '../commom_states.dart';

abstract class FirtiliserSettingsStates extends CommonStates{}

class FirtiliserSettingsIntialState extends FirtiliserSettingsStates {}

class FirtiliserSettingsAddContainerState extends FirtiliserSettingsStates {}

class FirtiliserSettingsChooseTimeState extends FirtiliserSettingsStates {}

class FirtiliserSettingsChooseDateState extends FirtiliserSettingsStates {}

class FirtiliserSettingsIsDoneState extends FirtiliserSettingsStates {}

class FirtiliserSettingsAccordingToTimeState extends FirtiliserSettingsStates {}

class FirtiliserSettingssAccordingToQuantityState
    extends FirtiliserSettingsStates {}

class FirtiliserSettingssGetDataState extends FirtiliserSettingsStates {}

class FirtiliserSettingsSeriesState extends FirtiliserSettingsStates {}

class FirtiliserSettingssParallelState extends FirtiliserSettingsStates {}

class FirtiliserSettingsSendSuccessState extends FirtiliserSettingsStates {}

class FirtiliserSettingsSendFailState extends FirtiliserSettingsStates {}

class FirtiliserSettingsShowDeleteState extends FirtiliserSettingsStates {}

class FirtiliserSettingsDeleteSuccessState extends FirtiliserSettingsStates {}

class FirtiliserSettingsChooseDayState extends FirtiliserSettingsStates {}

class FirtiliserSettingsDeleteFailState extends FirtiliserSettingsStates {}

class FirtiliserSettingsSendDelSuccessState extends FirtiliserSettingsStates {}

class FirtiliserSettingsGetSuccessState extends FirtiliserSettingsStates {}

class FirtiliserSettingsGetFailState extends FirtiliserSettingsStates {}

class FirtiliserGetSuccessState extends FirtiliserSettingsStates {}

class FirtiliserGetFailState extends FirtiliserSettingsStates {}

class FirtiliserLoadingState extends FirtiliserSettingsStates {}
