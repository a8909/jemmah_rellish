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
                              leading: Image.asset(
                                singlecart.image,
                                height: 50,
                                width: 50,
                              ),
                              title: Text(
                                singlecart.title,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(singlecart.price),
                            ),
                          );
                        },
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
