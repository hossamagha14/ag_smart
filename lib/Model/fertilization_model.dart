class FertilizationModel {
  int? fertilizationMethod1;
  int? fertilizationMethod2;
  List<FertilizerPeriods>? fertilizerPeriods;
  List<CustomFertilizerSettings>? customFertilizerSettings;

  FertilizationModel(
      {this.fertilizationMethod1,
      this.fertilizationMethod2,
      this.fertilizerPeriods,
      this.customFertilizerSettings});

  FertilizationModel.fromJson(Map<String, dynamic> json) {
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