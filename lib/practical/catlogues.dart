import 'package:flutter/material.dart';
import 'package:jemmah_rellish/components/localStorage.dart';
import 'package:jemmah_rellish/components/models/cartItems.dart';
import 'package:jemmah_rellish/components/models/carts.dart';
import 'package:jemmah_rellish/components/models/colors.dart';
import 'package:jemmah_rellish/components/models/pagination.dart';
import 'package:jemmah_rellish/components/models/songsModel.dart';

import 'package:jemmah_rellish/practical/diisplayCart.dart';

class Cartlogues extends StatefulWidget {
  const Cartlogues({super.key});

  @override
  State<Cartlogues> createState() => _CartloguesState();
}

class _CartloguesState extends State<Cartlogues> {
  final clr = SongModel();
  Localstorage storage = Localstorage();
  final Pagination pagination = Pagination();
  final GlobalColors color = GlobalColors();
  final TextEditingController _serchController = TextEditingController();
  // final GlobalColors _color = GlobalColors();

  CartItems crt = CartItems();
  bool isCartAdded = false;
  int cartCount = 0;
  get _itemcount => cartCount;
  List items = [];

  void showModal(String productImage, String productName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Container(
            height: 350,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(productImage),
                Text('$productName has been successfully added to cart'),
                const SizedBox(height: 5),
                MaterialButton(
                  color: color.success,
                  child: const Text('ok'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void addToCart(index) async {
    setState(() {
      isCartAdded = true;
      cartCount = cartCount + 1;
      crt.currentShop = index;
      var addItem = crt.categories[index];
      final cart = Cart(
          imagePath: addItem.imagePath,
          name: addItem.name,
          price: addItem.price,
          content: addItem.content);

      crt.onAdd(cart);
      showModal(addItem.imagePath, addItem.name);
    });
  }

  void showCart() {
    Navigator.pushNamed(context, '/carts');
  }

  void onPrevious() {
    setState(() {
      pagination.pageIndex = pagination.initialPage - 1;
    });
  }

  void onNext() {
    setState(() {
      pagination.pageIndex = pagination.initialPage + 1;
    });
  }

  int _startpage = 0;
  int _endpage = 0;
  List pageCount = [];

  @override
  void initState() {
    super.initState();
    items = crt.categories;
    _startpage = (pagination.initialPage - 1) * pagination.perPage + 1;
    _endpage = _startpage + pagination.perPage;
  }

  void onSearch(String search) {
    setState(() {
      if (search.isEmpty) {
        items = crt.categories;
      } else {
        items = crt.categories.where((s) {
          final queryList = s.name.toLowerCase().contains(search.toLowerCase());
          print('query of ${s.name}: $queryList');
          return queryList;
        }).toList();
      }
    });
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
                  showCart();
                },
                icon: const Icon(
                  Icons.trolley,
                  size: 30,
                ),
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
                            child: Text(_itemcount.toString()),
                          ),
                        ),
                      ))
                  : const SizedBox.shrink()
            ],
          )
        ],
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 10.0, left: 10, right: 10, bottom: 10),
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
            TextField(
                controller: _serchController,
                onChanged: (value) {
                  onSearch(value);
                },
                decoration: const InputDecoration(
                    hintText: 'Search to filter product',
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))))),
            const SizedBox(height: 10),
            items.isEmpty
                ? const AnimatedOpacity(
                    opacity: 0.5,
                    curve: Curves.ease,
                    duration: Duration(seconds: 2000),
                    child: Text(
                      'Enter a vaild search entry',
                    ))
                : Expanded(
                    child: GridView.builder(
                      itemCount: items.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return DisplayCart(
                          cart: items[index],
                          // cart: pagination.totalPage[index],
                          onTap: () {
                            addToCart(index);
                          },
                        );
                      },
                    ),
                  ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     cusButton(
            //         pagination.initialPage == 1
            //             ? null
            //             : () {
            //                 onPrevious();
            //               },
            //         'Previous',
            //         pagination.initialPage == 1
            //             ? _color.disable
            //             : _color.success),
            //     // GestureDetector(
            //     //     onTap: () {
            //     //       for (var p in pageCount) {
            //     //         setState(() {
            //     //           currentPageIndex = pagination.pageIndex = p;
            //     //         });
            //     //       }
            //     //     },
            //     //     child: Container(
            //     //       decoration: BoxDecoration(
            //     //           color: pagination.currentPage == currentPageIndex
            //     //               ? _color.success
            //     //               : Colors.transparent,
            //     //           borderRadius:
            //     //               const BorderRadius.all(Radius.circular(10))),
            //     //       child: Text(
            //     //         '$currentPageIndex',
            //     //       ),
            //     //     )),
            //     cusButton(
            //         pagination.initialPage == pageCount.length - 1
            //             ? null
            //             : () {
            //                 onNext();
            //               },
            //         'Next',
            //         pagination.initialPage == pageCount.length - 1
            //             ? _color.disable
            //             : _color.success)
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
