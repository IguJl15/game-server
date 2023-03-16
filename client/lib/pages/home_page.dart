import 'package:client/pages/game_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final nameFieldController = TextEditingController();
  final gameIdFieldController = TextEditingController();

  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 600,
            child: Column(
              children: [
                Container(
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
                          controller: widget.nameFieldController,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
                Container(
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
                          controller: widget.gameIdFieldController,
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
                                      playerName: widget.nameFieldController.text,
                                      isSecondPlayer: true,
                                      gameId: widget.gameIdFieldController.text),
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
                                  builder: (context) =>
                                      GamePage(playerName: widget.nameFieldController.text, isSecondPlayer: false),
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
