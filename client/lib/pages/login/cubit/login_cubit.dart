import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/client.dart';
import '../../../models/auth_data.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final SocketClient _client;

  LoginCubit(this._client) : super(LoginUninitialized());

  void init() async {
    try {
      if (!_client.initialized) {
        await _client.init();
      }

      emit(LoginInitialized());
    } catch (e) {
      emit(LoginFailure("Não foi possível conectar ao servidor"));
    }
  }

  loginButtonPressed(String nickName, String password) async {
    try {
      if (!_client.initialized) {
        await _client.init();
      }

      emit(LoginInitialized());
    } catch (e) {
      emit(LoginFailure("Não foi possível conectar ao servidor"));
    }

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
