import 'package:flutter/material.dart';
import 'package:jemmah_rellish/components/localStorage.dart';
import 'package:jemmah_rellish/components/services/server.dart';
import 'package:jemmah_rellish/main.dart';
import 'package:jemmah_rellish/practical/login.dart';
import 'package:jemmah_rellish/practical/screens.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

Localstorage _localstorage = Localstorage();
ServiceWorker  _endpoint = ServiceWorker();


class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _onWelcome();
  }

  _onWelcome() async {
    await Future.delayed(const Duration(seconds: 2), () async {
      if(await _localstorage.getData("auth") != 'empty' || await _localstorage.getData("auth") != null){
        onNavigate(const Screens());
      }
      onNavigate(const Login());
    });
  }

  void onNavigate(Widget newScreen) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => newScreen,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 5),
          child: Text(
            'JEMMAH r e l i s h...',
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
