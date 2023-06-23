import 'package:equatable/equatable.dart';

class AuthEvents extends Equatable{
  @override
  List<Object> get props => [];
}

class StartEvent extends AuthEvents {}

class LoginButtonPressed extends AuthEvents{
  final String username;
  final String password;
  LoginButtonPressed({required this.username,required this.password});
}

class LogoutButtonPressed extends AuthEvents{}

class RefreshEvent extends AuthEvents{}

class ServerDownEvent extends AuthEvents{}

class ExpiredTokenEvent extends AuthEvents{}