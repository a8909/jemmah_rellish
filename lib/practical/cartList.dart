import 'package:flutter/material.dart';
import 'package:jemmah_rellish/components/models/cartItems.dart';

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => _CartListState();
}

final itms = CartItems();

class _CartListState extends State<CartList> {
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
                    const Text('cart is empty')
                  ],
                ),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  final itm = itms.shopCart[index];
                  return ListTile(
                    leading: Image.asset(itm.imagePath),
                    title: Text(itm.name),
                    subtitle: Text(itm.price),
                  );
                },
              ));
  }
}
