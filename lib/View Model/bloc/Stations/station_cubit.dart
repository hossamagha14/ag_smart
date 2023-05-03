import 'package:ag_smart/View%20Model/bloc/Stations/station_states.dart';
import 'package:ag_smart/View%20Model/database/end_points.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

import '../../../Model/station_model.dart';
import '../../../View/Reusable/text.dart';
import '../../database/dio_helper.dart';

class StationsCubit extends Cubit<StationsStates> {
  StationsCubit() : super(StationsIntialState());

  static StationsCubit get(context) => BlocProvider.of(context);
  Database? dataBase;
  DioHelper dio = DioHelper();
  bool securePassword = true;
  bool secureConfirmPassword = true;
  StationModel? stationModel;
  String barCode = '';
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
    dio.get('$base/$stationInfo/by_user/$userId').then((value) {
      for (var e in value.data) {
        stationModel = StationModel.fromJson(e);
        stations.add(stationModel!);
      }
      emit(StationsGetSuccessState());
    }).catchError((onError) {
      print(onError);
      emit(StationsGetFailState());
    });

    Future scan() async {
      try {
        barCode = await FlutterBarcodeScanner.scanBarcode(
            '#E2BFE8', 'Cancel', true, ScanMode.QR);
      } on PlatformException {
        barCode = 'Failed';
      }
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
