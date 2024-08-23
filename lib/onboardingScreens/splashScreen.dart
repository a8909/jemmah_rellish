import 'package:flutter/material.dart';
import 'package:jemmah_rellish/practical/login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _onWelcome();
  }

  _onWelcome() async {
    await Future.delayed(
        const Duration(seconds: 2000),
        () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ))
            });
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'JEMMAH r e l i s h...',
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
