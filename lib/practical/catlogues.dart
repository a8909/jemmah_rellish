import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jemmah_rellish/components/localStorage.dart';
import 'package:jemmah_rellish/components/models/cartItems.dart';
import 'package:jemmah_rellish/components/models/carts.dart';
import 'package:jemmah_rellish/components/models/colors.dart';
import 'package:jemmah_rellish/components/models/pagination.dart';
import 'package:jemmah_rellish/components/models/songsModel.dart';
import 'package:jemmah_rellish/components/services/server.dart';

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
  final GlobalColors _color = GlobalColors();
  final TextEditingController _serchController = TextEditingController();
  final ServiceWorker _endPoint = ServiceWorker();

  CartItems crt = CartItems();
  bool isCartAdded = false;
  int cartCount = 0;
  get _itemcount => cartCount;
  List items = [];
  int pageCount = 0;
  List populatedProduct = [];

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
                  color: _color.success,
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
          product_photo: addItem.product_photo,
          product_title: addItem.product_title,
          product_price: addItem.product_price,
          delivery: addItem.delivery);
      crt.onAdd(cart);
      showModal(addItem.product_photo, addItem.product_title);
    });
    List<String> product =
        crt.shopCart.map((p) => jsonEncode(p.toJson())).toList();
    final productKey = crt.saveProduct(product);
    _onTooltipSave(_itemcount);
    debugPrint('productKey : $productKey');
  }

  _onTooltipSave(int value) async {
    await storage.saveTooltip(key: 'tipsKey', value: value);
  }

  _onLoadtoolTip() async {
    int? savedCount = await storage.savedTooltips('tipsKey');
    setState(() {
      cartCount = savedCount ?? 0;
    });
  }

  void showCart() {
    Navigator.pushNamed(context, '/carts');
  }

  @override
  void initState() {
    super.initState();
    _updateProducts();
    // items = crt.categories;
    items = populatedProduct;
    _updatePagination();
    _onLoadtoolTip();
  }

  void _updateProducts() async {
    populatedProduct = await _endPoint.getProducts();
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

  void _updatePagination() {
    pagination.totalItem = items.length;
    pageCount = pagination.totalPage =
        (pagination.totalItem / pagination.perPage).ceil();
  }

  List getPaginatedItem() {
    int start = (pagination.initialPage - 1) * pagination.perPage;
    int end = start + pagination.perPage;
    return items.sublist(start, end > items.length ? items.length : end);
  }

  void onSearch(String search) {
    setState(() {
      if (search.isEmpty) {
        // items = crt.categories;
        items = populatedProduct;
      } else {
        items = populatedProduct.where((q) {
          final queryList =
              q['product_title'].toLowerCase().contains(search.toLowerCase());
          return queryList;
        }).toList();
      }
      _updatePagination();
    });
  }

  @override
  Widget build(BuildContext context) {
    List paginatedItems = getPaginatedItem();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
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
                  size: 20,
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
                    curve: Curves.easeIn,
                    duration: Duration(seconds: 2),
                    child: Text(
                      'Enter a vaild search entry',
                    ))
                : Expanded(
                    child: FutureBuilder(
                        future: _endPoint.getProducts(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return GridView.builder(
                              itemCount: paginatedItems.length,
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                final productItems = snapshot.data;
                                return DisplayCart(
                                  cart: productItems[index],
                                  onTap: () {
                                    addToCart(index);
                                  },
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                  ),
            items.isEmpty
                ? const SizedBox.shrink()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      cusButton(
                          pagination.initialPage == 1
                              ? null
                              : () {
                                  onPrevious();
                                },
                          'Previous',
                          pagination.initialPage == 1
                              ? _color.disable
                              : _color.success),
                      Text('${pagination.initialPage} of $pageCount'),
                      cusButton(
                          pagination.initialPage == pageCount
                              ? null
                              : () {
                                  onNext();
                                },
                          'Next',
                          pagination.initialPage == pageCount
                              ? _color.disable
                              : _color.success)
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
