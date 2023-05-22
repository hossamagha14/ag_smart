class PumpModel {
  int? stationId;
  int? pumpEnable;
  double? pumpPower;
  int? pressureSwitch;

  PumpModel(
      {this.stationId, this.pumpEnable, this.pumpPower, this.pressureSwitch});

  PumpModel.fromJson(Map<String, dynamic> json) {
    stationId = json['station_id'];
    pumpEnable = json['pump_enable'];
    pumpPower = json['pump_power'];
    pressureSwitch = json['pressure_switch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['station_id'] = stationId;
    data['pump_enable'] = pumpEnable;
    data['pump_power'] = pumpPower;
    data['pressure_switch'] = pressureSwitch;
    return data;
  }
}