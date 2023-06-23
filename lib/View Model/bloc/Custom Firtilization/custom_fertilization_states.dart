import '../commom_states.dart';

abstract class CustomFertilizationStates extends CommonStates {}

class CustomFertilizationIntialState extends CustomFertilizationStates {}

class CustomFertilizationChooseDurationState
    extends CustomFertilizationStates {}

class CustomFertilizationChooseQuantityState
    extends CustomFertilizationStates {}

class CustomFertilizationPutSuccessState extends CustomFertilizationStates {}

class CustomFertilizationLoadingState extends CustomFertilizationStates {}

class CustomFertilizationPutDelSuccessState extends CustomFertilizationStates {}

class CustomFertilizationPutFailState extends CustomFertilizationStates {}

class CustomFertilizationGetSuccessState extends CustomFertilizationStates {}

class CustomFertilizationGetValvesFailState extends CustomFertilizationStates {}

class CustomFertilizationGetValvesSuccessState
    extends CustomFertilizationStates {}

class CustomFertilizationGetFailState extends CustomFertilizationStates {}

class CustomFertilizationDeleteSuccessState extends CustomFertilizationStates {}

class CustomFertilizationDeleteFailState extends CustomFertilizationStates {}

class CustomFertilizationShowDeleteButtonState
    extends CustomFertilizationStates {}

class CustomFirtiliserSettingsAddContainerState
    extends CustomFertilizationStates {}

class CustomFirtiliserSettingsRemoveContainerState
    extends CustomFertilizationStates {}

class CustomFirtiliserSettingsChooseDayState
    extends CustomFertilizationStates {}

class CustomFirtilizationSettingsChooseTimeState
    extends CustomFertilizationStates {}
