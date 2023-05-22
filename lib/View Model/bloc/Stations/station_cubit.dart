import 'package:ag_smart/View%20Model/bloc/Stations/station_states.dart';
import 'package:ag_smart/View%20Model/database/cache_helpher.dart';
import 'package:ag_smart/View%20Model/database/end_points.dart';
import 'package:ag_smart/View/Reusable/toasts.dart';
import 'package:ag_smart/View/Screens/device_setup.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../../../Model/station_model.dart';
import '../../../View/Reusable/text.dart';
import '../../../View/Screens/bottom_dash_bar_screen.dart';
import '../../../View/Screens/device_features.dart';
import '../../database/dio_helper.dart';

class StationsCubit extends Cubit<StationsStates> {
  StationsCubit() : super(StationsIntialState());

  static StationsCubit get(context) => BlocProvider.of(context);
  Database? dataBase;
  DioHelper dio = DioHelper();
  bool securePassword = true;
  bool secureConfirmPassword = true;
  StationModel? stationModel;
  String? barCode;
  String? x;
  List<StationModel> stations = [];

  showPassword() {
    securePassword = !securePassword;
    emit(StationsShowPassWordState());
  }

  showConfirmPassword() {
    secureConfirmPassword = !secureConfirmPassword;
    emit(StationsShowConfirmPassWordState());
  }

  getStations() {
    emit(StationsLoadinglState());
    stations = [];
    dio.get('$base/$stationInfo/by_user/$userId').then((value) {
      for (var e in value.data) {
        stationModel = StationModel.fromJson(e);
        stations.add(stationModel!);
      }
      emit(StationsGetSuccessState());
    }).catchError((onError) {
      emit(StationsGetFailState());
    });
  }

  Future scan(context) async {
    try {
      barCode = await FlutterBarcodeScanner.scanBarcode(
          '#E2BFE8', 'Cancel', true, ScanMode.QR);

      if (barCode != null && barCode != '-1') {
        barCode = barCode!.split('=')[1];
        try {
          Response<dynamic> response = await dio.get('$base/$serial/$barCode');
          if (response.statusCode == 200) {
            CacheHelper.saveData(key: 'stationName', value: barCode);
            stationName = CacheHelper.getData(key: 'stationName');
            CacheHelper.saveData(key: 'serialNumber', value: barCode);
            serialNumber = CacheHelper.getData(key: 'serialNumber');
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DeviceSetupScreen(
                    serial: barCode!,
                  ),
                ));
          }
        } catch (e) {
          emit(StationsFailQrState());
        }
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomDashBarScreen(),
            ),
            (route) => false);
      }
    } on PlatformException {
      barCode = 'Failed';
      emit(StationsFailQrState());
    }
  }

  postStation(context, {required String stationName}) async {
    try {
      Response<dynamic> response = await dio.post('$base/$stationInfo', data: {
        "serial_number": barCode,
        "user_id": userId,
        'station_name': stationName
      });
      if (response.statusCode == 200) {
        stationModel = StationModel.fromJson(response.data);
        CacheHelper.saveData(key: 'stationId', value: stationModel!.id);
        CacheHelper.saveData(
            key: 'serialNumber', value: stationModel!.serialNumber);
        stationId = CacheHelper.getData(key: 'stationId');
        serialNumber = CacheHelper.getData(key: 'serialNumber');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const DeviceFeaturesScreen(isEdit: false),
            ),
            (route) => false);
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response!.statusCode == 409) {
          errorToast(e.response!.data['message']);
        } else if (e.response!.statusCode == 500) {
          errorToast(e.response!.data['message']);
        }
      }
      emit(StationsGetStationFailState());
    }
  }

  // createDataBase() async {
  //   dataBase = await openDatabase(
  //     'Stations.db',
  //     version: 1,
  //     onCreate: (dataBase, version) async {
  //       print('data base created successfully');
  //       await dataBase.execute(
  //           'CREATE TABLE stations (stationID INTEGER PRIMARY KEY,email TEXT,stationName TEXT,password TEXT,irrigationType INTEGER)');
  //       print('table created');
  //     },
  //     onOpen: (dataBase) {
  //       getData(dataBase);
  //       print('dataBase opened');
  //     },
  //   );
  // }

  // insertInDatabase({
  //   required String name,
  //   required String password,
  //   required String email,
  //   required int irrigationType,
  // }) async {
  //   await dataBase!.transaction((txn) async {
  //     await txn
  //         .rawInsert(
  //             'INSERT INTO stations (email,stationName,password,irrigationType) VALUES ("$email","$name","$password","$irrigationType")')
  //         .then((value) {
  //       getData(dataBase!);
  //       emit(StationsAddToDBSuccessState());
  //       print(value);
  //     }).catchError((onError) {
  //       emit(StationsAddToDBFailState());
  //     });
  //   });
  // }

  // getData(Database database) async {
  //   stations = await database.rawQuery('SELECT * FROM stations WHERE email=?',['hossam']);
  //   print(stations);
  //   emit(StationsGetSuccessState());
  // }

  // saveVariables(int index) {
  //   CacheHelper.remove(key: 'stationId');
  //   CacheHelper.remove(key: 'stationName');
  //   CacheHelper.saveData(key: 'stationId', value: index + 1);
  //   CacheHelper.saveData(
  //       key: 'stationName', value: stations[index]['stationName']);
  //   emit(StationsSaveState());
  // }

  // Future<void> deleteDatabase(String path) =>
  //     databaseFactory.deleteDatabase(path);
}
