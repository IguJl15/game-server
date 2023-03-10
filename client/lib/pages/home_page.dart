import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final nameFieldController = TextEditingController();

  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "Insira seu nome",
              style: TextStyle(fontSize: 30),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                maxLines: 1,
                maxLength: 20,
                controller: widget.nameFieldController,
              ),
            ),
            ElevatedButton(onPressed: () {}, child: Text("Começar"))
          ],
        ),
      ),
    );
  }
}
