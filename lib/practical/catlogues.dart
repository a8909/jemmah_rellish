import 'package:flutter/material.dart';
import 'package:jemmah_rellish/components/localStorage.dart';
import 'package:jemmah_rellish/components/models/cartItems.dart';
import 'package:jemmah_rellish/components/models/carts.dart';
import 'package:jemmah_rellish/components/models/songsModel.dart';
import 'package:jemmah_rellish/practical/cartList.dart';
import 'package:jemmah_rellish/practical/diisplayCart.dart';

class Cartlogues extends StatefulWidget {
  const Cartlogues({super.key});

  @override
  State<Cartlogues> createState() => _CartloguesState();
}

class _CartloguesState extends State<Cartlogues> {
  final clr = SongModel();
  Localstorage storage = Localstorage();
  var savedItems;

  CartItems crt = CartItems();
  bool isCartAdded = false;
  int cartCount = 0;
  get _itemcount => cartCount;
  var tipCount;

  void addToCart(index) async {
    setState(() {
      isCartAdded = true;
      cartCount = cartCount + 1;
      var addItem = crt.categories[index];
      final cart = Cart(
          imagePath: addItem.imagePath,
          name: addItem.name,
          price: addItem.price,
          content: addItem.content);

      crt.onAdd(cart);
      print(crt.shopCart);
    });

    savedItems = await Localstorage()
        .saveTooltip(key: 'tooltipCount', value: cartCount++);
    tipCount = Localstorage().savedTooltips('tooltipCount');
  }

  void showCart() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const CartList();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        foregroundColor: Colors.white,
        elevation: 1,
        title: const Center(
            child: Text(
          'C A T L O G U E S',
          style: TextStyle(color: Colors.black),
        )),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/carts');
                  // showCart();
                },
                icon: const Icon(Icons.trolley),
                tooltip: _itemcount.toString(),
              ),
              isCartAdded
                  ? Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        height: 23,
                        width: 23,
                        decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(3, 2, 3, 5),
                          child: Center(
                            child: Text(savedItems == null
                                ? _itemcount.toString()
                                : tipCount.toString()),
                          ),
                        ),
                      ))
                  : const Text('')
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Row(
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                Text('to jehmma rellish big store...')
              ],
            ),
            AspectRatio(
              aspectRatio: 0.81,
              child: SizedBox(
                width: double.infinity,
                child: GridView.builder(
                  itemCount: crt.categories.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return DisplayCart(
                      cart: crt.categories[index],
                      onTap: () {
                        addToCart(index);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
