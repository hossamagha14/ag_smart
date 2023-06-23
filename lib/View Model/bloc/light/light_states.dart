import '../commom_states.dart';

abstract class LightStates extends CommonStates{}

class LightIntialState extends LightStates {}

class LightAddContainerState extends LightStates {}

class LightChooseTimeState extends LightStates {}

class LightIsDoneState extends LightStates {}

class LightChooseDayState extends LightStates {}

class LightPutSuccessState extends LightStates {}

class LightPutFailState extends LightStates {}

class LightGetSuccessState extends LightStates {}

class LightGetFailState extends LightStates {}

class LightLoadingState extends LightStates {}
