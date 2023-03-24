import 'package:client/data/client.dart';
import 'package:client/models/auth_data_singleton.dart';
import 'package:client/pages/home/game_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final nameFieldController = TextEditingController();
  final gameIdFieldController = TextEditingController();
  final SocketClient client;

  HomePage({
    required this.client,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AuthDataSingleton.authData.nickName), centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 600,
            child: Column(
              children: [
                const SizedBox(height: 100),
                EnterGameWidget(
                  gameIdFieldController: gameIdFieldController,
                  client: client,
                ),
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
  final SocketClient client;

  const EnterGameWidget({super.key, required this.gameIdFieldController, required this.client});

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
              decoration: const InputDecoration(label: Text('Código da partida')),
              validator: (value) => value?.length != 5 ? 'id do jogo deve conter 5 caracteres' : null,
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
                        isSecondPlayer: true,
                        gameId: gameIdFieldController.text,
                        socketClient: client,
                      ),
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
                        isSecondPlayer: false,
                        socketClient: client,
                      ),
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
