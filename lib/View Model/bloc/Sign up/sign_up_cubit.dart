import 'package:ag_smart/View%20Model/bloc/Sign%20up/sign_up_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpIntialState());
  static SignUpCubit get(context) => BlocProvider.of(context);

  bool secure = true;
  bool rePasswordSecure = true;

  showPassword() {
    secure = !secure;
    emit(SignUpShowPasswordState());
  }

  showRePassword() {
    rePasswordSecure = !rePasswordSecure;
    emit(SignUpShowPasswordState());
  }
}
