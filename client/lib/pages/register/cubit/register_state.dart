part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitialized extends RegisterState {}
class RegisterUninitialized extends RegisterState {}

class RegisterSuccessful extends RegisterState {
  final AuthData authData;

  RegisterSuccessful(this.authData);
}

class RegisterFailure extends RegisterState {
  final String error;

  RegisterFailure([this.error = '']);
}
