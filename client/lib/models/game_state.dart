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

  factory GameState.fromJson(Map<String, dynamic> json) => GameState(
        board: Board.fromJson(json),
        player1: Player.fromJson(json['player1'], json['currentPlayer']['id'] == json['player1']['id']),
        player2: json['player2'] == null
            ? null
            : Player.fromJson(json['player2'], json['currentPlayer']['id'] == json['player2']['id']),
        status: GameStatus.parse(json['status']),
      );
}

enum GameStatus {
  waiting,
  inGame,
  finished;

  static GameStatus parse(String string) {
    string
      ..trim()
      ..toLowerCase();

    switch (string) {
      case 'waiting':
        return GameStatus.waiting;
      case 'ingame':
      case 'in game':
        return GameStatus.inGame;
      case 'finished':
        return GameStatus.finished;
      default:
        throw const FormatException();
    }
  }
}
