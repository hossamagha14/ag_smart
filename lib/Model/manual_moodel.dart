import 'package:flutter/material.dart';

class ManualModel {
  int? valveId;
  int? duration;
  TextEditingController controller=TextEditingController();

  ManualModel({this.valveId, this.duration});

  ManualModel.fromJson(Map<String, dynamic> json) {
    valveId = json['valve_id'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['valve_id'] = valveId;
    data['duration'] = duration;
    return data;
  }
}