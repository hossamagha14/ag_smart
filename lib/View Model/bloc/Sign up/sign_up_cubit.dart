import 'package:ag_smart/View%20Model/bloc/Sign%20up/sign_up_states.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../database/end_points.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpIntialState());
  static SignUpCubit get(context) => BlocProvider.of(context);

  bool secure = true;
  bool rePasswordSecure = true;
  Dio dio = Dio();

  showPassword() {
    secure = !secure;
    emit(SignUpShowPasswordState());
  }

  showRePassword() {
    rePasswordSecure = !rePasswordSecure;
    emit(SignUpShowPasswordState());
  }

  createAccount({required String username, required String password}) {
    dio.post('$base/register',
        data: {'username': username, 'password': password}).then((value) {
      emit(SignUpSuccessState(value.data['message']));
    }).catchError((onError) {
      emit(SignUpFailState('User with that username already exists.'));
    });
  }
}
