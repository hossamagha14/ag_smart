class UserModel {
  String? message;
  int? userId;
  String? accessToken;
  String? refreshToken;
  List<Routes>? routes;

  UserModel(
      {this.message,
      this.userId,
      this.accessToken,
      this.refreshToken,
      this.routes});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userId = json['user_id'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    if (json['routes'] != null) {
      routes = <Routes>[];
      json['routes'].forEach((v) {
        routes!.add(Routes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['user_id'] = userId;
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    if (routes != null) {
      data['routes'] = routes!.map((v) => v.toJson()).toList();
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