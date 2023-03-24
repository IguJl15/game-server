import 'dart:convert';
import 'package:client/data/client.dart';
import 'package:client/models/auth_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final SocketClient _client;

  RegisterCubit(this._client) : super(RegisterUninitialized());

  void init() async {
    try {
      if (!_client.initialized) {
        await _client.init();
      }

      emit(RegisterInitialized());
    } catch (e) {
      emit(RegisterFailure("Não foi possível conectar ao servidor"));
    }
  }

  registerButtonPressed(String nickName, String password, String passwordConfirmation) async {
    try {
      if (!_client.initialized) await _client.init();
    } catch (e) {
      emit(RegisterFailure("Não foi possível conectar ao servidor"));
      return;
    }

    final Map<String, dynamic> createGameJson = {
      'Register': {
        'userName': nickName,
        'password': password,
        'confirmedPassword': passwordConfirmation,
      }
    };

    _client.sendMessage(jsonEncode(createGameJson));

    await _client.stream.first.then((value) {
      final responseJson = jsonDecode(value);

      if (responseJson["User"] == null) emit(RegisterFailure('Houve um erro durante a tentativa de register'));

      emit(RegisterSuccessful(AuthData.fromJson(responseJson['User'])));
      return;
    });
  }

  dispose() {}
}
