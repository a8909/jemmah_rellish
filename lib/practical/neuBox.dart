import 'package:flutter/material.dart';

class NeuBox extends StatelessWidget {
  final Widget? child;
  NeuBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.grey.shade500,
              blurRadius: 15,
              offset: const Offset(4, 4)),
          const BoxShadow(
              color: Colors.white, blurRadius: 15, offset: Offset(-2, -2))
        ]),
        child: child,
      ),
    );
  }
}
