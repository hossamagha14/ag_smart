import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/commom_states.dart';
import 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvents, CommonStates> {
  AuthBloc(CommonStates initialState) : super(initialState) {
    on<StartEvent>(startEvent);
    on<ServerDownEvent>(loadingServerDownEvent);
    on<ExpiredTokenEvent>(tokenExpiredEvent);
  }

  void startEvent(StartEvent event, Emitter<CommonStates> emit) {
    emit(IntialState());
  }

  void loadingServerDownEvent(
      ServerDownEvent event, Emitter<CommonStates> emit) {
    emit(ServerDownState());
  }

  void tokenExpiredEvent(ExpiredTokenEvent event, Emitter<CommonStates> emit) {
    emit(ExpiredTokenState());
  }
}
