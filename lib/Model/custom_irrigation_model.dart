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
  List<TimeOfDay> timeList = [TimeOfDay.now()];
  List<TextEditingController> controllersList = [TextEditingController()];
  List<bool> isBeingDeleted = [false];
  bool? accordingToHour;
  bool? accordingToQuantity;
  
  int noDayIsChosen = 7;
  CustomIrrigationModel(
      {required this.accordingToHour, required this.accordingToQuantity});
}
