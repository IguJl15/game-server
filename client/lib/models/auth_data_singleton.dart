import 'package:client/models/auth_data.dart';

class AuthDataSingleton {
  AuthDataSingleton._(this._authData);

  // ignore: unused_field
  AuthData _authData;

  static AuthData get authData => _instance._authData;

  static AuthDataSingleton _instance = AuthDataSingleton._(AuthData(sessionId: '', nickName: ''));

  static setAuthData(AuthData authData) => _instance._authData = authData;
}
