import '../commom_states.dart';

abstract class LinesActivationStates extends CommonStates{}

class LinesActivationIntialState extends LinesActivationStates {}

class LinesActivationLoadingState extends LinesActivationStates {}

class LinesActivationActiveState extends LinesActivationStates {}

class LinesActivationGetSuccessState extends LinesActivationStates {}

class LinesActivationGetFailState extends LinesActivationStates {}

class LinesActivationSendSuccessState extends LinesActivationStates {}

class LinesActivationSendFailState extends LinesActivationStates {}

class LinesActivationNoPumpState extends LinesActivationStates {}
