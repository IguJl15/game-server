import 'dart:math';

import 'package:client/pages/login/cubit/login_cubit.dart';
import 'package:client/pages/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/client.dart';
import '../../models/auth_data_singleton.dart';
import '../components/failure_dialog.dart';
import '../home/home_page.dart';

class LoginPage extends StatelessWidget {
  late SocketClient socketClient;
  late LoginCubit cubit;

  final TextEditingController nickNameFieldController = TextEditingController();
  final TextEditingController passwordFieldController = TextEditingController();

  LoginPage({super.key}) {
    socketClient = SocketClient();
    cubit = LoginCubit(socketClient);
    cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginCubit, LoginState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is LoginUninitialized) cubit.init();

          if (state is LoginSuccessful) {
            AuthDataSingleton.setAuthData(state.authData);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(client: socketClient),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is LoginUninitialized) return const Center(child: CircularProgressIndicator());
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // const AnimatedAvatar(),
                  // const SizedBox(
                  //   height: 40,
                  // ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 70),
                    child: Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  TextField(
                    controller: nickNameFieldController,
                    decoration: const InputDecoration(
                      hintText: 'Nickname',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: passwordFieldController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () =>
                        cubit.loginButtonPressed(nickNameFieldController.text, passwordFieldController.text),
                    child: const Text('Login'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'OR',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ));
                    },
                    child: const Text('Register'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class AnimatedAvatar extends StatefulWidget {
  const AnimatedAvatar({super.key});

  @override
  State<AnimatedAvatar> createState() => _AnimatedAvatarState();
}

class _AnimatedAvatarState extends State<AnimatedAvatar> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
      lowerBound: 80,
      upperBound: 120,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: controller.value * 2.0 * pi,
            child: CircleAvatar(
              backgroundImage: const AssetImage('assets/avatar.png'),
              maxRadius: controller.value.toDouble(),
            ),
          );
        });
  }
}
