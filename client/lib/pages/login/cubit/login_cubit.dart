import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:client/data/client.dart';
import 'package:client/models/auth_data.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final SocketClient _client;

  LoginCubit(this._client) : super(LoginUninitialized());

  void init() async {
    if (_client.initialized) {
      emit(LoginInitialized());
      return;
    }

    await _client.init();

    emit(LoginInitialized());
  }

  loginButtonPressed(String nickName, String password) async {
    final Map<String, dynamic> createGameJson = {
      'Login': {
        'userName': nickName,
        'password': password,
      }
    };

    _client.sendMessage(jsonEncode(createGameJson));

    await _client.stream.first.then((value) {
      final responseJson = jsonDecode(value);

      if (responseJson["User"] == null) emit(LoginFailure('Houve um erro durante a tentativa de login'));

      emit(LoginSuccessful(AuthData.fromJson(responseJson['User'])));
      return;
    });
  }

  dispose() {}
}
