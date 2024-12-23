import 'package:ag_smart/View%20Model/database/cache_helpher.dart';

const base = 'http://192.168.1.106:5000';
String stationInfo = CacheHelper.getData(key: 'stationInfo');
String features = CacheHelper.getData(key: 'features');
String valveInfo = CacheHelper.getData(key: 'valveInfo');
String irrigationSettings = CacheHelper.getData(key: 'irrigationSettings');
String irrigationPeriods = CacheHelper.getData(key: 'irrigationPeriods');
String irrigationCycle = CacheHelper.getData(key: 'irrigationCycle');
String fertilizerPeriods = CacheHelper.getData(key: 'fertilizerPeriods');
String fertilizerSettings = CacheHelper.getData(key: 'fertilizerSettings');
String animalRepellent = CacheHelper.getData(key: 'animalRepellent');
String light = CacheHelper.getData(key: 'light');
String irrigationPeriodsList =
    CacheHelper.getData(key: 'irrigationPeriodsList');
String fertilizerPeriodsList =
    CacheHelper.getData(key: 'fertilizerPeriodsList');
String valveSettingsDelete = CacheHelper.getData(key: 'valveSettingsDelete');
String fertilizerSettingsDelete =
    CacheHelper.getData(key: 'fertilizerSettingsDelete');
String customIrrigationSettings =
    CacheHelper.getData(key: 'customIrrigationSettings');
String getCustomIrrigationSettings =
    CacheHelper.getData(key: 'getCustomIrrigationSettings');
const manualIrrigationSettings = '/station/irrigation_settings/manual';
const customFertilization = '/station/fertilizer_settings/custom';
const stationBySerial = 'station/by_serial';
const refresh = 'refresh';
const dailyRecords = '/daily_records/range';
const yearlyRecords = '/monthly_records/year';
const monthlyRecords = '/daily_records/month';
const monthlyRange = '/monthly_records/range';
const serial = '/serial_number';
const station = '/station';
const logoutCall = '/logout';
const pumpSettings = '/station/pump_info';
