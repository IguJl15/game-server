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
    if (_client.initialized) {
      emit(RegisterInitialized());
      return;
    }

    await _client.init();

    emit(RegisterInitialized());
  }

  registerButtonPressed(String nickName, String password, String passwordConfirmation) async {
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
