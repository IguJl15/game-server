import 'dart:convert';

import 'package:client/data/client.dart';
import 'package:cubit/cubit.dart';

import '../../models/game_state.dart';
import '../../models/player.dart';

part 'game_cubit_state.dart';

class GameCubit extends Cubit<GameCubitState> {
  late SocketClient _client;

  GameCubit(this.player) : super(GameCubitStateUninitialized(player)) {
    _client = SocketClient(onData: _onSocketData, onError: _onError);
  }

  void initialize() async {
    try {
      await _client.init();
    } on SocketException catch (e) {
      if (e.message.startsWith('Connection refused')) {
        emit(GameCubitStateFinished(state.state));
      } else {
        rethrow;
      }
    }
    emit(GameCubitStateInitial(state.state.player1));
  }

  void _onSocketData(String data) {
    print('Data from server :$data');
    try {
      final Map<String, dynamic> json = jsonDecode(data);

      if (json['GameState'] != null) {
        emit(GameCubitStateInGame(GameState.fromJson(json['GameState'])));
      }
    } catch (e, st) {
      print('Exception: $e');
      print('$st');
      emit(GameCubitStateFinished(state.state));
    }
  }

  void _onError(dynamic error) {
    print('ERROR: $error');
    emit(GameCubitStateFinished(state.state));
  }
  }

  void onSocketData(String data) {
    print("data");

    final json = jsonDecode(data);

    if (json["GameState"]) {}
  }
}
