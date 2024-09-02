import 'package:flutter/material.dart';
import 'package:jemmah_rellish/components/localStorage.dart';
import 'package:jemmah_rellish/components/models/cartItems.dart';
import 'package:jemmah_rellish/practical/diisplayCart.dart';

class CartList extends StatefulWidget {
  const CartList({super.key});

  @override
  State<CartList> createState() => _CartListState();
}

final itms = CartItems();
Localstorage storage = Localstorage();
void payNow() {}

class _CartListState extends State<CartList> {
  @override
  void initState() {
    super.initState;
    print(itms.shop);
    // final key = await storage.getPost('cartKey');
    // print('cartKey: $key');
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
            : Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: itms.shopCart.length,
                    itemBuilder: (context, index) {
                      final itm = itms.shopCart[index];
                      return ListTile(
                        leading: Image.asset(itm.imagePath),
                        title: Text(itm.name),
                        subtitle: Text(itm.price),
                      );
                    },
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [cusButton(payNow, 'Pay Now')],
                    ),
                  )
                ],
              ));
  }
}
