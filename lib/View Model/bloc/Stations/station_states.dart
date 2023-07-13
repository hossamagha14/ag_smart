import '../commom_states.dart';

abstract class StationsStates extends CommonStates {}

class StationsIntialState extends StationsStates {}

class StationsCreateDBSuccessState extends StationsStates {}

class StationsEditStationNameSuccessState extends StationsStates {}

class StationsEditStationNameFailState extends StationsStates {}

class StationsEditStationNameReapeatedState extends StationsStates {}

class StationsCreateDBFailState extends StationsStates {}

class StationsShowPassWordState extends StationsStates {}

class StationsShowConfirmPassWordState extends StationsStates {}

class StationsAddToDBSuccessState extends StationsStates {}

class StationsAddToDBFailState extends StationsStates {}

class StationsGetSuccessState extends StationsStates {}

class StationsSaveState extends StationsStates {}

class StationsGetFailState extends StationsStates {}

class StationsLoadinglState extends StationsStates {}

class StationsFailQrState extends StationsStates {}

class StationsGetStationFailState extends StationsStates {}
