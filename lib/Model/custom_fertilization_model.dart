import 'package:flutter/material.dart';

class CustomFertilizationModel {
  List<TextEditingController> controllers = [];
  List<TimeOfDay> time = [];
  List<int> daysList = [];
  List<int> days = [for (int i = 1; i <= 28; i++) i];
}
