import 'package:ag_smart/Model/pump_model.dart';

class StationModel {
  int? id;
  int? internetAccess;
  int? configured;
  String? serialNumber;
  String? stationName;
  List<Features>? features;
  List<LinesInfo>? linesInfo;
  List<IrrigationSettings>? irrigationSettings;
  List<FertilizationSettings>? fertilizationSettings;
  List<AnimalRepellent>? animalRepellent;
  List<LightSettings>? lightSettings;
  List<PumpModel>? pumpModel;

  StationModel(
      {this.id,
      this.internetAccess,
      this.configured,
      this.serialNumber,
      this.features,
      this.stationName,
      this.linesInfo,
      this.irrigationSettings,
      this.fertilizationSettings,
      this.animalRepellent,
      this.pumpModel,
      this.lightSettings});

  StationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stationName = json['station_name'];
    internetAccess = json['internet_access'];
    configured = json['configured'];
    serialNumber = json['serial_number'];
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
    if (json['fertilization_settings'] != null) {
      fertilizationSettings = <FertilizationSettings>[];
      json['fertilization_settings'].forEach((v) {
        fertilizationSettings!.add(FertilizationSettings.fromJson(v));
      });
    }
    if (json['animal_repellent'] != null) {
      animalRepellent = <AnimalRepellent>[];
      json['animal_repellent'].forEach((v) {
        animalRepellent!.add(AnimalRepellent.fromJson(v));
      });
    }
    if (json['light_settings'] != null) {
      lightSettings = <LightSettings>[];
      json['light_settings'].forEach((v) {
        lightSettings!.add(LightSettings.fromJson(v));
      });
    }
    if (json['pump_settings'] != null) {
      pumpModel = <PumpModel>[];
      json['pump_settings'].forEach((v) {
        pumpModel!.add(PumpModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['station_name'] = stationName;
    data['internet_access'] = internetAccess;
    data['configured'] = configured;
    data['serial_number'] = serialNumber;
    if (features != null) {
      data['features'] = features!.map((v) => v.toJson()).toList();
    }
    if (linesInfo != null) {
      data['lines_info'] = linesInfo!.map((v) => v.toJson()).toList();
    }
    if (pumpModel != null) {
      data['pump_settings'] = pumpModel!.map((v) => v.toJson()).toList();
    }
    if (irrigationSettings != null) {
      data['irrigation_settings'] =
          irrigationSettings!.map((v) => v.toJson()).toList();
    }
    if (fertilizationSettings != null) {
      data['fertilization_settings'] =
          fertilizationSettings!.map((v) => v.toJson()).toList();
    }
    if (animalRepellent != null) {
      data['animal_repellent'] =
          animalRepellent!.map((v) => v.toJson()).toList();
    }
    if (lightSettings != null) {
      data['light_settings'] = lightSettings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Routes {
  String? stationInfo;
  String? features;
  String? valveInfo;
  String? irrigationSettings;
  String? irrigationPeriods;
  String? irrigationCycle;
  String? fertilizerPeriods;
  String? fertilizerSettings;
  String? animalRepellent;
  String? light;
  String? irrigationPeriodsList;
  String? fertilizerPeriodsList;
  String? valveSettingsDelete;
  String? fertilizerSettingsDelete;
  String? customIrrigationSettings;
  String? getCustomIrrigationSettings;

  Routes(
      {this.stationInfo,
      this.features,
      this.valveInfo,
      this.irrigationSettings,
      this.irrigationPeriods,
      this.irrigationCycle,
      this.fertilizerPeriods,
      this.fertilizerSettings,
      this.animalRepellent,
      this.light,
      this.irrigationPeriodsList,
      this.fertilizerPeriodsList,
      this.valveSettingsDelete,
      this.fertilizerSettingsDelete,
      this.customIrrigationSettings,
      this.getCustomIrrigationSettings});

  Routes.fromJson(Map<String, dynamic> json) {
    stationInfo = json['stationInfo'];
    features = json['features'];
    valveInfo = json['valveInfo'];
    irrigationSettings = json['irrigationSettings'];
    irrigationPeriods = json['irrigationPeriods'];
    irrigationCycle = json['irrigationCycle'];
    fertilizerPeriods = json['fertilizerPeriods'];
    fertilizerSettings = json['fertilizerSettings'];
    animalRepellent = json['animalRepellent'];
    light = json['light'];
    irrigationPeriodsList = json['irrigationPeriodsList'];
    fertilizerPeriodsList = json['fertilizerPeriodsList'];
    valveSettingsDelete = json['valveSettingsDelete'];
    fertilizerSettingsDelete = json['fertilizerSettingsDelete'];
    customIrrigationSettings = json['customIrrigationSettings'];
    getCustomIrrigationSettings = json['getCustomIrrigationSettings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stationInfo'] = stationInfo;
    data['features'] = features;
    data['valveInfo'] = valveInfo;
    data['irrigationSettings'] = irrigationSettings;
    data['irrigationPeriods'] = irrigationPeriods;
    data['irrigationCycle'] = irrigationCycle;
    data['fertilizerPeriods'] = fertilizerPeriods;
    data['fertilizerSettings'] = fertilizerSettings;
    data['animalRepellent'] = animalRepellent;
    data['light'] = light;
    data['irrigationPeriodsList'] = irrigationPeriodsList;
    data['fertilizerPeriodsList'] = fertilizerPeriodsList;
    data['valveSettingsDelete'] = valveSettingsDelete;
    data['fertilizerSettingsDelete'] = fertilizerSettingsDelete;
    data['customIrrigationSettings'] = customIrrigationSettings;
    data['getCustomIrrigationSettings'] = getCustomIrrigationSettings;
    return data;
  }
}

class Features {
  String? version;
  int? internetAccess;
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
      this.internetAccess,
      this.version,
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
    version = json['version'];
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
    data['internet_access'] = internetAccess;
    data['lines_number'] = linesNumber;
    data['fertilizer'] = fertilizer;
    data['light'] = light;
    data['animal'] = animal;
    data['pressure'] = pressure;
    data['water_level'] = waterLevel;
    data['automatic'] = automatic;
    data['flow_meter'] = flowMeter;
    data['leak_sensor'] = leakSensor;
    data['ph_sensor'] = phSensor;
    data['tds_sensor'] = tdsSensor;
    data['temperature_sensor'] = temperatureSensor;
    data['humidity_sensor'] = humiditySensor;
    data['version'] = version;
    data['pump'] = pump;
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
  List<CustomValvesSettings>? customValvesSettings;

  IrrigationSettings(
      {this.activeValves,
      this.settingsType,
      this.irrigationMethod1,
      this.irrigationMethod2,
      this.irrigationPeriods,
      this.irrigationCycles,
      this.customValvesSettings});

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
    if (json['custom_valves_settings'] != null) {
      customValvesSettings = <CustomValvesSettings>[];
      json['custom_valves_settings'].forEach((v) {
        customValvesSettings!.add(CustomValvesSettings.fromJson(v));
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
    if (customValvesSettings != null) {
      data['custom_valves_settings'] =
          customValvesSettings!.map((v) => v.toJson()).toList();
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

class CustomValvesSettings {
  int? stationId;
  int? valveId;
  int? irrigationMethod1;
  int? irrigationMethod2;
  List<IrrigationPeriods>? irrigationPeriods;
  List<IrrigationCycles>? irrigationCycles;

  CustomValvesSettings(
      {this.stationId,
      this.valveId,
      this.irrigationMethod1,
      this.irrigationMethod2,
      this.irrigationPeriods,
      this.irrigationCycles});

  CustomValvesSettings.fromJson(Map<String, dynamic> json) {
    stationId = json['station_id'];
    valveId = json['valve_id'];
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
    data['station_id'] = stationId;
    data['valve_id'] = valveId;
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

class FertilizationSettings {
  int? fertilizationMethod1;
  int? fertilizationMethod2;
  List<FertilizerPeriods>? fertilizerPeriods;
  List<CustomFertilizerSettings>? customFertilizerSettings;

  FertilizationSettings(
      {this.fertilizationMethod1,
      this.fertilizationMethod2,
      this.fertilizerPeriods,
      this.customFertilizerSettings});

  FertilizationSettings.fromJson(Map<String, dynamic> json) {
    fertilizationMethod1 = json['fertilization_method_1'];
    fertilizationMethod2 = json['fertilization_method_2'];
    if (json['fertilizer_periods'] != null) {
      fertilizerPeriods = <FertilizerPeriods>[];
      json['fertilizer_periods'].forEach((v) {
        fertilizerPeriods!.add(FertilizerPeriods.fromJson(v));
      });
    }
    if (json['custom_fertilizer_settings'] != null) {
      customFertilizerSettings = <CustomFertilizerSettings>[];
      json['custom_fertilizer_settings'].forEach((v) {
        customFertilizerSettings!.add(CustomFertilizerSettings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fertilization_method_1'] = fertilizationMethod1;
    data['fertilization_method_2'] = fertilizationMethod2;
    if (fertilizerPeriods != null) {
      data['fertilizer_periods'] =
          fertilizerPeriods!.map((v) => v.toJson()).toList();
    }
    if (customFertilizerSettings != null) {
      data['custom_fertilizer_settings'] =
          customFertilizerSettings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FertilizerPeriods {
  int? periodId;
  int? valveId;
  int? startingTime;
  int? duration;
  int? quantity;
  int? date;

  FertilizerPeriods(
      {this.periodId,
      this.valveId,
      this.startingTime,
      this.duration,
      this.quantity,
      this.date});

  FertilizerPeriods.fromJson(Map<String, dynamic> json) {
    periodId = json['period_id'];
    valveId = json['valve_id'];
    startingTime = json['starting_time'];
    duration = json['duration'];
    quantity = json['quantity'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['period_id'] = periodId;
    data['valve_id'] = valveId;
    data['starting_time'] = startingTime;
    data['duration'] = duration;
    data['quantity'] = quantity;
    data['date'] = date;
    return data;
  }
}

class CustomFertilizerSettings {
  int? stationId;
  int? valveId;
  int? fertilizerMethod1;
  List<FertilizerPeriods>? fertilizerPeriods;

  CustomFertilizerSettings(
      {this.stationId,
      this.valveId,
      this.fertilizerMethod1,
      this.fertilizerPeriods});

  CustomFertilizerSettings.fromJson(Map<String, dynamic> json) {
    stationId = json['station_id'];
    valveId = json['valve_id'];
    fertilizerMethod1 = json['fertilizer_method_1'];
    if (json['fertilizer_periods'] != null) {
      fertilizerPeriods = <FertilizerPeriods>[];
      json['fertilizer_periods'].forEach((v) {
        fertilizerPeriods!.add(FertilizerPeriods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['station_id'] = stationId;
    data['valve_id'] = valveId;
    data['fertilizer_method_1'] = fertilizerMethod1;
    if (fertilizerPeriods != null) {
      data['fertilizer_periods'] =
          fertilizerPeriods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AnimalRepellent {
  int? stationId;
  int? startTime;
  int? finishTime;
  int? onTime;
  int? offTime;

  AnimalRepellent(
      {this.stationId,
      this.startTime,
      this.finishTime,
      this.onTime,
      this.offTime});

  AnimalRepellent.fromJson(Map<String, dynamic> json) {
    stationId = json['station_id'];
    startTime = json['start_time'];
    finishTime = json['finish_time'];
    onTime = json['on_time'];
    offTime = json['off_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['station_id'] = stationId;
    data['start_time'] = startTime;
    data['finish_time'] = finishTime;
    data['on_time'] = onTime;
    data['off_time'] = offTime;
    return data;
  }
}

class LightSettings {
  int? startingTime;
  int? duration;

  LightSettings({this.startingTime, this.duration});

  LightSettings.fromJson(Map<String, dynamic> json) {
    startingTime = json['starting_time'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['starting_time'] = startingTime;
    data['duration'] = duration;
    return data;
  }
}
