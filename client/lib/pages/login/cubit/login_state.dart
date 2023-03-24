part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitialized extends LoginState {}
class LoginUninitialized extends LoginState {}

class LoginSuccessful extends LoginState {
  final AuthData authData;

  LoginSuccessful(this.authData);
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure([this.error = '']);
}
