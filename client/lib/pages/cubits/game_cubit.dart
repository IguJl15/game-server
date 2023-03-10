import 'dart:convert';

import 'package:client/data/client.dart';
import 'package:cubit/cubit.dart';

import '../../models/game_state.dart';
import '../../models/player.dart';

part 'game_cubit_state.dart';

class GameCubit extends Cubit<GameCubitState> {
  late SocketClient _client;

  GameCubit(Player player) : super(GameCubitStateInitial(player)) {
    _client = SocketClient(onData: onSocketData);
    _client.init();
  }

  void onSocketData(String data) {
    print("data");

    final json = jsonDecode(data);

    if (json["GameState"]) {}
  }
}
