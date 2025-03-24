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
              widget.cart.image ??
                  'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAJQAmAMBIgACEQEDEQH/xAAZAAEBAQEBAQAAAAAAAAAAAAAABQYHBAL/xAA2EAEAAQMCAgQNAwUBAAAAAAAAAQIDBAURBiESQVHRExYXMTVSU1RhcZSisiMycjORocHhFP/EABQBAQAAAAAAAAAAAAAAAAAAAAD/xAAUEQEAAAAAAAAAAAAAAAAAAAAA/9oADAMBAAIRAxEAPwDsQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHPsNpZ+jAt6jrWpxkXsqItTaiim3kV0RG9PPlEvT4vYXts76y53gr7GyR4vYXts76y53ni9he2zvrLneCvsbSkRw9he2zvrLneeL2H7bO+sud4K/zGfqwLen63psY97Jmm74WK6bl+quJ2pjblMtAAAAAAAAAAAAACTpnpvWf5WfwVknS/Tesfytfgj8ZcVU6dRXg6fXvl1RtXXHOLX/Qaazm417Ju41q/brvWdvCW4q5079r6zJvxh35xf6/g58Hv623JxbB1DKwc2MzHuzTfiZmap59Lt37d3V+HNex9cxPCW9rd+iP1bXXTPbHwBieDrms1cSW4rnKmnpT/AOmLu+223Xv17unJ+t6vjaLhVZGTPPzUW4/dXPZDPcMcZxn5VeLqcU2rlyv9CuOVO3qz/qesFvUvTmkfO9+MKyTqXpzSPne/GFYAAAAAAAAAAAAGB4k4gu6RqWqY+JG2RkTb2uepEU9XxYSqZrqmqqZmqZ3mZ65dU1ng7E1fUK8y/lZFuuuIiaaOjtyjbseLyd6f79l/b3A5w9On52Rp2XbysSuaLtHmntjsn4N95O9P9+y/t7jyd6d77l/b3Aw2sarlaxmTk5dfPzU0R+2iOyIeH/Do/k70737L+3uPJ3p/v2X9vcCfwlreRqeqabiZc9OrGpudG71zT0fNP9nQmb0Xg/D0jUKMyxk37ldNMx0a9tufLqhpAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAf/9k=',
              height: 50,
              width: double.infinity,
            ),
            Center(
              child: Text(widget.cart.deliveryStatus),
            ),
            Text(
              widget.cart.title.length >= 21
                  ? ' ${widget.cart.title.substring(0, 25)}...'
                  : widget.cart.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$${widget.cart.price.toString()}"),
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
    margin: const EdgeInsets.symmetric(vertical: 10),
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
