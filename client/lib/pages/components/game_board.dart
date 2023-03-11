import 'package:flutter/material.dart';

import '../../models/game_state.dart';
import 'board_square.dart';
import 'footer.dart';

class GameBoard extends StatelessWidget {
  final GameState gameState;
  final String playerValue;
  final bool isSecondPlayer;

  final void Function(int index) squarePressed;

  const GameBoard({
    required this.gameState,
    required this.playerValue,
    required this.isSecondPlayer,
    required this.squarePressed,
    super.key,
  });

  String _getStatusTitle(GameStatus status, bool canPlay) {
    switch (status) {
      case GameStatus.waiting:
        return 'Esperando...';

      case GameStatus.inGame:
        return canPlay ? 'Sua vez' : 'Vez do oponente';

      case GameStatus.finished:
        return 'Acabou!';

      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final canPlay =
        isSecondPlayer ? gameState.player2 != null && gameState.player2!.isCurrent : gameState.player1.isCurrent;

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                _getStatusTitle(gameState.status, canPlay),
                style: const TextStyle(fontSize: 40),
              ),
            ),
            _Board(
              gameState: gameState,
              playerValue: playerValue,
              squarePressed: squarePressed,
              enabled: canPlay && gameState.status == GameStatus.inGame,
            ),
            Footer(gameState.board.id),
          ],
        ),
      ),
    );
  }
}

class _Board extends StatelessWidget {
  final GameState gameState;
  final String playerValue;
  final bool enabled;
  final void Function(int) squarePressed;

  const _Board({
    required this.gameState,
    required this.playerValue,
    required this.squarePressed,
    this.enabled = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final board = gameState.board;

    return Column(
      children: [
        SizedBox.square(
          dimension: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BoardSquare(board.positions[0], enabled: enabled, onTap: () => squarePressed(0)),
                  BoardSquare(board.positions[1], enabled: enabled, onTap: () => squarePressed(1)),
                  BoardSquare(board.positions[2], enabled: enabled, onTap: () => squarePressed(2))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BoardSquare(board.positions[3], enabled: enabled, onTap: () => squarePressed(3)),
                  BoardSquare(board.positions[4], enabled: enabled, onTap: () => squarePressed(4)),
                  BoardSquare(board.positions[5], enabled: enabled, onTap: () => squarePressed(5))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BoardSquare(board.positions[6], enabled: enabled, onTap: () => squarePressed(6)),
                  BoardSquare(board.positions[7], enabled: enabled, onTap: () => squarePressed(7)),
                  BoardSquare(board.positions[8], enabled: enabled, onTap: () => squarePressed(8))
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text('Você joga com $playerValue')
      ],
    );
  }
}
