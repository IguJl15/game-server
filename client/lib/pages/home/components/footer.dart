import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  final String code;

  const Footer(this.code, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[50],
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [const Text('Código da partida:'), Text(code)],
      ),
    );
  }
}
