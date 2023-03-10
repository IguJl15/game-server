import 'package:client/models/game_state.dart';
import 'package:client/pages/cubits/game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

import '../models/player.dart';

class GamePage extends StatefulWidget {
  final Player player;

  const GamePage({
    required this.player,
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

    cubit = GameCubit(widget.player);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.player.name),
      ),
      body: CubitConsumer<GameCubit, GameCubitState>(
        cubit: cubit,
        listener: (context, state) {},
        builder: (context, state) => GameBoard(gameState: state.state),
      ),
    );
  }
}

class GameBoard extends StatelessWidget {
  final GameState gameState;

  const GameBoard({
    required this.gameState,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(gameState.toString());
  }
}
