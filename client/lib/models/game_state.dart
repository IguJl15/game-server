import 'board.dart';
import 'player.dart';

class GameState {
  Player player1;
  Player? player2;
  Board board;
  GameStatus status;

  GameState({
    required this.player1,
    required this.player2,
    required this.board,
    required this.status,
  });

  factory GameState.initial(Player player1) => GameState(
        player1: player1,
        player2: null,
        board: Board.empty(),
        status: GameStatus.waiting,
      );
}

enum GameStatus {
  waiting,
  inGame,
  finished;
}
