import 'package:flutter/material.dart';
import 'package:jemmah_rellish/components/models/carts.dart';

class DisplayCart extends StatelessWidget {
  final Cart cart;
  final void Function()? onTap;
  const DisplayCart({super.key, required this.cart, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: 200,
      decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Image.asset(cart.imagePath),
            ),
            Center(
              child: Text(cart.content),
            ),
            Text(
              cart.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(cart.price),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: onTap,
                            child: const Text(
                              'Add to cart',
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Container cusButton(Function()? onTap, String cusText) {
  return Container(
    decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(Radius.circular(8))),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          GestureDetector(
              onTap: onTap,
              child: Text(
                cusText,
                style: const TextStyle(color: Colors.white),
              ))
        ],
      ),
    ),
  );
}
