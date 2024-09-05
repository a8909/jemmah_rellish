import 'package:flutter/material.dart';
import 'package:jemmah_rellish/components/models/carts.dart';

class DisplayCart extends StatelessWidget {
  final Cart cart;
  final void Function()? onTap;
  const DisplayCart({super.key, required this.cart, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8, right: 5),
      width: 100,
      decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              cart.imagePath,
              height: 50,
              width: double.infinity,
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
                Text('\$${cart.price}'),
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
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
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
      padding: const EdgeInsets.all(5),
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
