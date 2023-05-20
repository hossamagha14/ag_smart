class PumpModel {
  final int stationId;
  final int pumpEnable;
  final double pumpPower;
  final int pressureSwitch;

  PumpModel({
    required this.stationId,
    required this.pumpEnable,
    required this.pumpPower,
    required this.pressureSwitch,
  });

  factory PumpModel.fromJson(Map<String, dynamic> json) {
    return PumpModel(
      stationId: json['station_id'],
      pumpEnable: json['pump_enable'],
      pumpPower: json['pump_power'].toDouble(),
      pressureSwitch: json['pressure_switch'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'station_id': stationId,
      'pump_enable': pumpEnable,
      'pump_power': pumpPower,
      'pressure_switch': pressureSwitch,
    };
  }
}
