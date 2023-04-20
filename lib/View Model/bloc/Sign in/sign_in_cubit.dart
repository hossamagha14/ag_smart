import 'package:ag_smart/View%20Model/bloc/Sign%20in/sign_in_states.dart';
import 'package:ag_smart/View%20Model/database/cache_helpher.dart';
import 'package:ag_smart/View%20Model/database/end_points.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Model/user_model.dart';

class SignInCubit extends Cubit<SignInStates> {
  SignInCubit() : super(SignInIntialState());
  static SignInCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  Dio dio=Dio();

  bool secure = true;

  showPassword() {
    secure = !secure;
    emit(SignInShowPasswordState());
  }

  signIn({required String username, required String password}) {
    dio.post('$base/login',
        data: {'username': username, "password": password}).then((value) {
      print(value.data);
      if (value.statusCode == 200) {
        userModel = UserModel.fromJson(value.data);
        CacheHelper.saveData(key: 'token', value: userModel!.accessToken!);
        CacheHelper.saveData(key: 'refreshToken', value: userModel!.refreshToken!);
        CacheHelper.saveData(key: 'user_id', value: userModel!.userId!);
        CacheHelper.saveData(
            key: 'stationInfo', value: userModel!.routes![0].stationInfo);
        CacheHelper.saveData(
            key: 'features', value: userModel!.routes![0].features);
        CacheHelper.saveData(
            key: 'valveInfo', value: userModel!.routes![0].valveInfo);
        CacheHelper.saveData(
            key: 'irrigationSettings',
            value: userModel!.routes![0].irrigationSettings);
        CacheHelper.saveData(
            key: 'irrigationPeriods',
            value: userModel!.routes![0].irrigationPeriods);
        CacheHelper.saveData(
            key: 'irrigationCycle',
            value: userModel!.routes![0].irrigationCycle);
        CacheHelper.saveData(
            key: 'fertilizerPeriods',
            value: userModel!.routes![0].fertilizerPeriods);
        CacheHelper.saveData(
            key: 'fertilizerSettings',
            value: userModel!.routes![0].fertilizerSettings);
        CacheHelper.saveData(
            key: 'animalRepellent',
            value: userModel!.routes![0].animalRepellent);
        CacheHelper.saveData(key: 'light', value: userModel!.routes![0].light);
        CacheHelper.saveData(
            key: 'irrigationPeriodsList',
            value: userModel!.routes![0].irrigationPeriodsList);
        CacheHelper.saveData(
            key: 'fertilizerPeriodsList',
            value: userModel!.routes![0].fertilizerPeriodsList);
        CacheHelper.saveData(
            key: 'valveSettingsDelete',
            value: userModel!.routes![0].valveSettingsDelete);
        CacheHelper.saveData(
            key: 'fertilizerSettingsDelete',
            value: userModel!.routes![0].fertilizerSettingsDelete);
        CacheHelper.saveData(
            key: 'customIrrigationSettings',
            value: userModel!.routes![0].customIrrigationSettings);
        CacheHelper.saveData(
            key: 'getCustomIrrigationSettings',
            value: userModel!.routes![0].getCustomIrrigationSettings);
        emit(SignInLoginSuccessState());
      }
    }).catchError((onError) {
      print(onError);
      emit(SignInLoginFailState());
    });
  }
}
