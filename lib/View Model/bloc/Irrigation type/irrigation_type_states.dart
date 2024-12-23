import '../commom_states.dart';

abstract class IrrigationTypesStates extends CommonStates{}

class IrrigationTypeIntialState extends IrrigationTypesStates {}

class IrrigationTypeActivateState extends IrrigationTypesStates {}

class IrrigationTypeSeriesStates extends IrrigationTypesStates {}

class IrrigationTypeManualStates extends IrrigationTypesStates {}

class IrrigationTypeParallelStates extends IrrigationTypesStates {}

class IrrigationTypeCustomStates extends IrrigationTypesStates {}

class IrrigationTypeAutoStates extends IrrigationTypesStates {}

class IrrigationTypeHourState extends IrrigationTypesStates {}

class IrrigationTypePeriodState extends IrrigationTypesStates {}

class IrrigationTypeQuantityState extends IrrigationTypesStates {}

class IrrigationTypeTimeState extends IrrigationTypesStates {}

class IrrigationTypeSendSuccessState extends IrrigationTypesStates {}

class IrrigationTypeSendFailState extends IrrigationTypesStates {}
