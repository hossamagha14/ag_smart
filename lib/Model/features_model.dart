class FeaturesModel {
  String? version;
  int? light;
  int? internetAccess;
  int? pump;
  int? linesNumber;
  int? animal;
  int? fertilizer;
  int? pressure;
  int? waterLevel;
  int? automatic;
  int? flowMeter;
  int? leakSensor;
  int? phSensor;
  int? tdsSensor;
  int? temperatureSensor;
  int? humiditySensor;

  FeaturesModel(
      {this.light,
      this.pump,
      this.animal,
      this.internetAccess,
      this.version,
      this.linesNumber,
      this.fertilizer,
      this.pressure,
      this.waterLevel,
      this.automatic,
      this.flowMeter,
      this.leakSensor,
      this.phSensor,
      this.tdsSensor,
      this.temperatureSensor,
      this.humiditySensor});

  FeaturesModel.fromJson(Map<String, dynamic> json) {
    light = json['light'];
    version = json['version'];
    animal = json['animal'];
    internetAccess = json['internet_access'];
    pump = json['pump'];
    linesNumber = json['lines_number'];
    fertilizer = json['fertilizer'];
    pressure = json['pressure'];
    waterLevel = json['water_level'];
    automatic = json['automatic'];
    flowMeter = json['flow_meter'];
    leakSensor = json['leak_sensor'];
    phSensor = json['ph_sensor'];
    tdsSensor = json['tds_sensor'];
    temperatureSensor = json['temperature_sensor'];
    humiditySensor = json['humidity_sensor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['light'] = light;
    data['version'] = version;
    data['internet_access'] = internetAccess;
    data['pump'] = pump;
    data['lines_number'] = linesNumber;
    data['fertilizer'] = fertilizer;
    data['pressure'] = pressure;
    data['water_level'] = waterLevel;
    data['automatic'] = automatic;
    data['flow_meter'] = flowMeter;
    data['leak_sensor'] = leakSensor;
    data['ph_sensor'] = phSensor;
    data['animal'] = animal;
    data['tds_sensor'] = tdsSensor;
    data['temperature_sensor'] = temperatureSensor;
    data['humidity_sensor'] = humiditySensor;
    return data;
  }
}
