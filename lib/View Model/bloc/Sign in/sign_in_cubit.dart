import 'package:ag_smart/View%20Model/bloc/Sign%20in/sign_in_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<SignInStates>{
  SignInCubit():super(SignInIntialState());
  static SignInCubit get(context)=>BlocProvider.of(context);

  bool secure=true;

  showPassword(){
    secure=!secure;
    emit(SignInShowPasswordState());
  }
}