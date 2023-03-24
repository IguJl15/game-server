part of 'game_cubit.dart';

abstract class GameCubitState {
  final GameState state;

  const GameCubitState(this.state);
}

class GameCubitStateUninitialized extends GameCubitState {
  GameCubitStateUninitialized(Player player1) : super(GameState.initial(player1));
}

class GameCubitStateInitial extends GameCubitState {
  GameCubitStateInitial(Player player1) : super(GameState.initial(player1));
}

class GameCubitStateInGame extends GameCubitState {
  GameCubitStateInGame(super.state);
}

class GameCubitStateFinished extends GameCubitState {
  GameCubitStateFinished(super.state);
}
