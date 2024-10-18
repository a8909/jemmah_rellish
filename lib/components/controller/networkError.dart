import 'package:flutter/material.dart';

class NetworkError extends StatelessWidget {
  const NetworkError({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/no_connection.avif',
              width: 500,
              height: 500,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            const Text(
              'Check your internet connection and try again or pull down to refresh page.',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    ));
  }
}
