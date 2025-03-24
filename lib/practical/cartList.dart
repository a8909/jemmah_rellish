import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jemmah_rellish/components/localStorage.dart';
import 'package:jemmah_rellish/components/models/cartItems.dart';
import 'package:jemmah_rellish/components/models/carts.dart';
import 'package:jemmah_rellish/components/models/colors.dart';
import 'package:jemmah_rellish/practical/diisplayCart.dart';

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => _CartListState();
}

final itms = CartItems();
Localstorage _storage = Localstorage();
void payNow() {}
final GlobalColors _color = GlobalColors();

class _CartListState extends State<CartList> {
  @override
  void initState() {
    super.initState;
    _productCartList();
  }

  _productCartList() async {
    List<String>? cartList = await _storage.getPost('productKey');
    print('cartList is : $cartList');
    if (cartList == null) {
      return cartList = [];
    } else {
      setState(() {
        itms.shopCart =
            cartList!.map((p) => Cart.fromJson(jsonDecode(p))).toList();
      });
      return itms.shopCart;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new_sharp)),
          title: const Text('C A R T S'),
        ),
        body: itms.shopCart.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_checkout_outlined,
                      size: 60,
                      color: Colors.grey.shade800,
                    ),
                    const Text('cart is empty'),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Expanded(
                        child: ListView.builder(
                          itemCount: itms.shopCart.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final singlecart = itms.shopCart[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12))),
                              child: ListTile(
                                leading: Image.network(
                                  singlecart.image ??
                                      "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAJQAmAMBIgACEQEDEQH/xAAZAAEBAQEBAQAAAAAAAAAAAAAABQYHBAL/xAA2EAEAAQMCAgQNAwUBAAAAAAAAAQIDBAURBiESQVHRExYXMTVSU1RhcZSisiMycjORocHhFP/EABQBAQAAAAAAAAAAAAAAAAAAAAD/xAAUEQEAAAAAAAAAAAAAAAAAAAAA/9oADAMBAAIRAxEAPwDsQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHPsNpZ+jAt6jrWpxkXsqItTaiim3kV0RG9PPlEvT4vYXts76y53gr7GyR4vYXts76y53ni9he2zvrLneCvsbSkRw9he2zvrLneeL2H7bO+sud4K/zGfqwLen63psY97Jmm74WK6bl+quJ2pjblMtAAAAAAAAAAAAACTpnpvWf5WfwVknS/Tesfytfgj8ZcVU6dRXg6fXvl1RtXXHOLX/Qaazm417Ju41q/brvWdvCW4q5079r6zJvxh35xf6/g58Hv623JxbB1DKwc2MzHuzTfiZmap59Lt37d3V+HNex9cxPCW9rd+iP1bXXTPbHwBieDrms1cSW4rnKmnpT/AOmLu+223Xv17unJ+t6vjaLhVZGTPPzUW4/dXPZDPcMcZxn5VeLqcU2rlyv9CuOVO3qz/qesFvUvTmkfO9+MKyTqXpzSPne/GFYAAAAAAAAAAAAGB4k4gu6RqWqY+JG2RkTb2uepEU9XxYSqZrqmqqZmqZ3mZ65dU1ng7E1fUK8y/lZFuuuIiaaOjtyjbseLyd6f79l/b3A5w9On52Rp2XbysSuaLtHmntjsn4N95O9P9+y/t7jyd6d77l/b3Aw2sarlaxmTk5dfPzU0R+2iOyIeH/Do/k70737L+3uPJ3p/v2X9vcCfwlreRqeqabiZc9OrGpudG71zT0fNP9nQmb0Xg/D0jUKMyxk37ldNMx0a9tufLqhpAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAf/9k=",
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(
                                  singlecart.title,
                                  style: const TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text('\$${singlecart.price.toString()}'),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          cusButton(payNow, 'Pay Now', _color.success)
                        ],
                      ),
                    )
                  ],
                ),
              ));
  }
}
