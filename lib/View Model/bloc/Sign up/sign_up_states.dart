abstract class SignUpStates {}

class SignUpIntialState extends SignUpStates {}

class SignUpShowPasswordState extends SignUpStates {}

class SignUpSuccessState extends SignUpStates {
  final String accountCreatedMessage;
  SignUpSuccessState(this.accountCreatedMessage);
}

class SignUpFailState extends SignUpStates {
  final String errorMessage;
  SignUpFailState(this.errorMessage);
}
