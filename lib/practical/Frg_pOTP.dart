import 'package:flutter/material.dart';

class Fgtpotp extends StatelessWidget {
  const Fgtpotp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Text("Let's confirm its you, OTP has been sent to +234909**55"),
          Text(
            'Enter OTP',
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
