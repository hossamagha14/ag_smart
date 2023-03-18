class IrrigationSettingsModel {
  int? activeValves;
  int? settingsType;
  int? irrigationMethod1;
  int? irrigationMethod2;
  List<IrrigationPeriods>? irrigationPeriods;
  List<IrrigationCycles>? irrigationCycles;
  List<CustomValvesSettings>? customValvesSettings;

  IrrigationSettingsModel(
      {this.activeValves,
      this.settingsType,
      this.irrigationMethod1,
      this.irrigationMethod2,
      this.irrigationPeriods,
      this.irrigationCycles,
      this.customValvesSettings});

  IrrigationSettingsModel.fromJson(Map<String, dynamic> json) {
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
