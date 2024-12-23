import '../commom_states.dart';

abstract class ReportStates extends CommonStates{}

class ReportIntialState extends ReportStates {}

class ReportChooseDropDownValueState extends ReportStates {}

class ReportChooseYearState extends ReportStates {}

class ReportChooseMonthState extends ReportStates {}

class ReportChooseRangeState extends ReportStates {}

class ReportChooseQuarterState extends ReportStates {}

class ReportAddQuarterState extends ReportStates {}

class ReportSubtractQuarterState extends ReportStates {}

class ReportLoadinglState extends ReportStates {}

class ReportGetSuccessState extends ReportStates {}

class ReportGetFailState extends ReportStates {}

class ReportChooseStationState extends ReportStates {}

class ReportPDFSuccessState extends ReportStates {}

class ReportPDFFailState extends ReportStates {}

class ReportEmptyState extends ReportStates {}
