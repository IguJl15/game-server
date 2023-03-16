import 'package:client/pages/game_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final nameFieldController = TextEditingController();
  final gameIdFieldController = TextEditingController();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 600,
            child: Column(
              children: [
                NameWidget(nameFieldController: nameFieldController),
                const SizedBox(height: 100),
                EnterGameWidget(
                    gameIdFieldController: gameIdFieldController,
                    nameFieldController: nameFieldController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NameWidget extends StatelessWidget {
  final TextEditingController nameFieldController;

  const NameWidget({
    super.key,
    required this.nameFieldController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[50],
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Text(
            'Insira seu nome',
            style: TextStyle(fontSize: 20),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              maxLines: 1,
              maxLength: 20,
              decoration: const InputDecoration(label: Text('Nome')),
              controller: nameFieldController,
            ),
          ),
        ],
      ),
    );
  }
}

class EnterGameWidget extends StatelessWidget {
  final TextEditingController gameIdFieldController;
  final TextEditingController nameFieldController;

  const EnterGameWidget(
      {super.key,
      required this.gameIdFieldController,
      required this.nameFieldController});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[50],
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Text(
            'Para entrar em uma partida insira o id',
            style: TextStyle(fontSize: 20),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              maxLines: 1,
              maxLength: 5,
              decoration:
                  const InputDecoration(label: Text('Código da partida')),
              validator: (value) => value?.length != 5
                  ? 'id do jogo deve conter 5 caracteres'
                  : null,
              controller: gameIdFieldController,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: const Text('Entrar no jogo'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GamePage(
                          playerName: nameFieldController.text,
                          isSecondPlayer: true,
                          gameId: gameIdFieldController.text),
                    ),
                  );
                },
              ),
              ElevatedButton(
                child: const Text('Criar novo jogo'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GamePage(
                          playerName: nameFieldController.text,
                          isSecondPlayer: false),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
