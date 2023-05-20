import 'package:flutter/cupertino.dart';

class ValveModel {
  int? valveId;
  double holeDiameter = 0;
  double holeNumber = 0;
  int? valveBinary = 0;
  bool isActive = false;
  TextEditingController diameterController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  ValveModel({this.valveId});

  ValveModel.fromJson(Map<String, dynamic> json) {
    valveId = json['valve_id'];
    holeDiameter = json['hole_diameter'];
    holeNumber = json['hole_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['valve_id'] = valveId;
    data['hole_diameter'] = holeDiameter;
    data['hole_number'] = holeNumber;
    return data;
  }
}
