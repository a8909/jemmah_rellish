import 'package:flutter/material.dart';

class Items extends StatefulWidget {
  // final String child;
  final String image;
  final String recepie;
  final String price;

  Items({required this.image, required this.recepie, required this.price});

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  //  Class({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(widget.image),
            radius: 20,
          ),
          const SizedBox(width: 5),
          Text(widget.recepie),
          const Spacer(),
          Text(widget.price)
        ],
      ),
    );
  }
}
