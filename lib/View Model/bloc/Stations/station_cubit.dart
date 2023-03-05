import 'package:ag_smart/View%20Model/bloc/Stations/station_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class StationsCubit extends Cubit<StationsStates> {
  StationsCubit() : super(StationsIntialState());

  static StationsCubit get(context) => BlocProvider.of(context);
  Database? dataBase;
  bool securePassword = true;
  bool secureConfirmPassword = true;

  showPassword() {
    securePassword = !securePassword;
    emit(StationsShowPassWordState());
  }

  showConfirmPassword() {
    secureConfirmPassword = !secureConfirmPassword;
    emit(StationsShowConfirmPassWordState());
  }

  createDataBase() async {
    dataBase = await openDatabase(
      'Stations.db',
      version: 1,
      onCreate: (dataBase, version) async {
        print('data base created successfully');
        await dataBase.execute(
            'CREATE TABLE stations (stationID INTEGER PRIMARY KEY,stationName TEXT,password TEXT)');
        print('table created');
      },
      onOpen: (dataBase) {
        print('dataBase opened');
      },
    );
  }

  insertInDatabase({
    required String name,
    required String password,
  }) async {
    await dataBase!.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO stations (stationName,password) VALUES ("$name","$password")')
          .then((value) {
            emit(StationsAddToDBSuccessState());
        print(value);
      }).catchError((onError){
        emit(StationsAddToDBFailState());
      });
    });
  }
}
