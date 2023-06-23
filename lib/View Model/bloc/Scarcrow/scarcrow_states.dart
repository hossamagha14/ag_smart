import '../commom_states.dart';

abstract class ScarecrowStates extends CommonStates{}

class ScarecrowIntialState extends ScarecrowStates {}

class ScarecrowIsDoneState extends ScarecrowStates {}

class ScarecrowChooseTtimeState extends ScarecrowStates {}

class ScarecrowPostSuccessState extends ScarecrowStates {}

class ScarecrowPostFailState extends ScarecrowStates {}

class ScarecrowGetSuccessState extends ScarecrowStates {}

class ScarecrowGetFailState extends ScarecrowStates {}

class ScarecrowLoadingState extends ScarecrowStates {}
