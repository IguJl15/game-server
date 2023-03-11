import 'package:client/pages/cubits/game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/player.dart';
import 'components/game_board.dart';

class GamePage extends StatefulWidget {
  final String playerName;
  final bool isSecondPlayer;
  final String? gameId;

  const GamePage({
    required this.playerName,
    required this.isSecondPlayer,
    this.gameId,
    super.key,
  });

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late GameCubit cubit;

  @override
  void initState() {
    super.initState();

    final Player player = Player.empty(widget.playerName);

    cubit = GameCubit(player);
    cubit.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.playerName),
        centerTitle: true,
      ),
      body: BlocConsumer<GameCubit, GameCubitState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is GameCubitStateInitial) {
            if (widget.gameId == null || widget.gameId!.isEmpty) {
              cubit.createNewGame(widget.playerName);
            } else {
              cubit.joinExistingGame(widget.playerName, widget.gameId!);
            }
          }
        },
        builder: (context, state) {
          if (state is GameCubitStateUninitialized || state is GameCubitStateInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GameCubitStateFinished) return const Text('Acabou!');

          return GameBoard(
            gameState: state.state,
            squarePressed: (index) => cubit.markPosition(index),
            playerValue: cubit.isSecondPlayer ? 'O' : 'X',
            isSecondPlayer: cubit.isSecondPlayer,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    cubit.dispose();
    super.dispose();
  }
}
