import 'package:flutter/material.dart';

import 'days_model.dart';

class CustomIrrigationModel {
  List<DaysModel> days = [
    DaysModel(day: 'SAT', isOn: false),
    DaysModel(day: 'SUN', isOn: false),
    DaysModel(day: 'MON', isOn: false),
    DaysModel(day: 'TUE', isOn: false),
    DaysModel(day: 'WED', isOn: false),
    DaysModel(day: 'THU', isOn: false),
    DaysModel(day: 'FRI', isOn: false),
  ];
  List<TimeOfDay> timeList = [];
  List<TextEditingController> controllersList = [];
  List<bool> isBeingDeleted = [];
  bool? accordingToHour;
  bool? accordingToQuantity;
  String? intial;
  int noDayIsChosen = 7;
  int statusType = 0;
  int fertilizationStatusType = 0;
  CustomIrrigationModel(
      {required this.accordingToHour, required this.accordingToQuantity});
}
