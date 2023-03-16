import 'dart:convert';
import 'dart:io';

import 'package:client/data/client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/game_state.dart';
import '../../models/player.dart';

part 'game_cubit_state.dart';

class GameCubit extends Cubit<GameCubitState> {
  late SocketClient _client;

  Player player;
  late bool isSecondPlayer;

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

  void createNewGame(String playerName) async {
    final Map<String, dynamic> createGameJson = {
      'CreateGame': {
        'playerName': playerName,
        'symbol': 'X',
      }
    };

    _client.sendMessage(jsonEncode(createGameJson));

    isSecondPlayer = false;
    await _setPlayerFromState();
  }

  void joinExistingGame(String playerName, String boardId) async {
    if (state is! GameCubitStateInitial) return;

    final Map<String, dynamic> createGameJson = {
      'JoinGame': {
        'playerName': playerName,
        'boardId': boardId,
      }
    };

    _client.sendMessage(jsonEncode(createGameJson));

    isSecondPlayer = true;
    _setPlayerFromState();
  }

  void markPosition(int position) {
    assert(0 <= position && position < 9);

    final playerId = player.id!;

    Map<String, dynamic> markPositionJson = {
      'MarkPosition': {
        'playerId': playerId,
        'boardId': state.state.board.id,
        'position': position,
      }
    };

    _client.sendMessage(jsonEncode(markPositionJson));
  }

  void dispose() {
    _client.dispose();
  }

  Future<void> _setPlayerFromState() {
    return stream.first.then((value) => player = isSecondPlayer ? value.state.player2! : value.state.player1);
  }
}
