import 'package:flutter/material.dart';
import 'package:jemmah_rellish/components/models/carts.dart';
import 'package:jemmah_rellish/components/models/colors.dart';

class DisplayCart extends StatefulWidget {
  final Cart cart;
  final void Function()? onTap;
  const DisplayCart({super.key, required this.cart, this.onTap});

  @override
  State<DisplayCart> createState() => _DisplayCartState();
}

class _DisplayCartState extends State<DisplayCart> {
  final GlobalColors _color = GlobalColors();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8, right: 5),
      width: 100,
      decoration: const BoxDecoration(
          color: Color.fromRGBO(189, 189, 189, 1),
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.cart.image,
              height: 50,
              width: double.infinity,
            ),
            Center(
              child: Text(widget.cart.deliveryStatus),
            ),
            Text(
              widget.cart.title.length >= 20
                  ? ' ${widget.cart.title.substring(0, 25)}...'
                  : widget.cart.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.cart.price),
                Container(
                  decoration: BoxDecoration(
                      color: _color.success,
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: widget.onTap,
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

Container cusButton(Function()? onTap, String cusText, Color color) {
  return Container(
    decoration: BoxDecoration(
        color: color, borderRadius: const BorderRadius.all(Radius.circular(8))),
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
