class StationModel {
  int? id;
  String? email;
  String? password;
  List<Features>? features;
  List<LinesInfo>? linesInfo;
  List<IrrigationSettings>? irrigationSettings;

  StationModel(
      {this.id,
      this.email,
      this.password,
      this.features,
      this.linesInfo,
      this.irrigationSettings});

  StationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(Features.fromJson(v));
      });
    }
    if (json['lines_info'] != null) {
      linesInfo = <LinesInfo>[];
      json['lines_info'].forEach((v) {
        linesInfo!.add(LinesInfo.fromJson(v));
      });
    }
    if (json['irrigation_settings'] != null) {
      irrigationSettings = <IrrigationSettings>[];
      json['irrigation_settings'].forEach((v) {
        irrigationSettings!.add(IrrigationSettings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['password'] = password;
    if (features != null) {
      data['features'] = features!.map((v) => v.toJson()).toList();
    }
    if (linesInfo != null) {
      data['lines_info'] = linesInfo!.map((v) => v.toJson()).toList();
    }
    if (irrigationSettings != null) {
      data['irrigation_settings'] =
          irrigationSettings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Features {
  int? light;
  int? animal;
  int? pump;
  int? linesNumber;
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

  Features(
      {this.light,
      this.animal,
      this.pump,
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

  Features.fromJson(Map<String, dynamic> json) {
    light = json['light'];
    animal = json['animal'];
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
    data['animal'] = animal;
    data['pump'] = pump;
    data['lines_number'] = linesNumber;
    data['fertilizer'] = fertilizer;
    data['pressure'] = pressure;
    data['water_level'] = waterLevel;
    data['automatic'] = automatic;
    data['flow_meter'] = flowMeter;
    data['leak_sensor'] = leakSensor;
    data['ph_sensor'] = phSensor;
    data['tds_sensor'] = tdsSensor;
    data['temperature_sensor'] = temperatureSensor;
    data['humidity_sensor'] = humiditySensor;
    return data;
  }
}

class LinesInfo {
  int? valveId;
  double? holeDiameter;
  double? holeNumber;

  LinesInfo({this.valveId, this.holeDiameter, this.holeNumber});

  LinesInfo.fromJson(Map<String, dynamic> json) {
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

class IrrigationSettings {
  int? activeValves;
  int? settingsType;
  int? irrigationMethod1;
  int? irrigationMethod2;
  List<IrrigationPeriods>? irrigationPeriods;
  List<IrrigationCycles>? irrigationCycles;

  IrrigationSettings(
      {this.activeValves,
      this.settingsType,
      this.irrigationMethod1,
      this.irrigationMethod2,
      this.irrigationPeriods,
      this.irrigationCycles});

  IrrigationSettings.fromJson(Map<String, dynamic> json) {
    activeValves = json['active_valves'];
    settingsType = json['settings_type'];
    irrigationMethod1 = json['irrigation_method_1'];
    irrigationMethod2 = json['irrigation_method_2'];
    if (json['irrigation_periods'] != null) {
      irrigationPeriods = <IrrigationPeriods>[];
      json['irrigation_periods'].forEach((v) {
        irrigationPeriods!.add(IrrigationPeriods.fromJson(v));
      });
    }
    if (json['irrigation_cycles'] != null) {
      irrigationCycles = <IrrigationCycles>[];
      json['irrigation_cycles'].forEach((v) {
        irrigationCycles!.add(IrrigationCycles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['active_valves'] = activeValves;
    data['settings_type'] = settingsType;
    data['irrigation_method_1'] = irrigationMethod1;
    data['irrigation_method_2'] = irrigationMethod2;
    if (irrigationPeriods != null) {
      data['irrigation_periods'] =
          irrigationPeriods!.map((v) => v.toJson()).toList();
    }
    if (irrigationCycles != null) {
      data['irrigation_cycles'] =
          irrigationCycles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IrrigationPeriods {
  int? periodId;
  int? valveId;
  int? startingTime;
  int? duration;
  int? quantity;
  int? weekDays;

  IrrigationPeriods(
      {this.periodId,
      this.valveId,
      this.startingTime,
      this.duration,
      this.quantity,
      this.weekDays});

  IrrigationPeriods.fromJson(Map<String, dynamic> json) {
    periodId = json['period_id'];
    valveId = json['valve_id'];
    startingTime = json['starting_time'];
    duration = json['duration'];
    quantity = json['quantity'];
    weekDays = json['week_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['period_id'] = periodId;
    data['valve_id'] = valveId;
    data['starting_time'] = startingTime;
    data['duration'] = duration;
    data['quantity'] = quantity;
    data['week_days'] = weekDays;
    return data;
  }
}

class IrrigationCycles {
  int? valveId;
  int? interval;
  int? duration;
  int? quantity;
  int? weekDays;

  IrrigationCycles(
      {this.valveId,
      this.interval,
      this.duration,
      this.quantity,
      this.weekDays});

  IrrigationCycles.fromJson(Map<String, dynamic> json) {
    valveId = json['valve_id'];
    interval = json['interval'];
    duration = json['duration'];
    quantity = json['quantity'];
    weekDays = json['week_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['valve_id'] = valveId;
    data['interval'] = interval;
    data['duration'] = duration;
    data['quantity'] = quantity;
    data['week_days'] = weekDays;
    return data;
  }
}