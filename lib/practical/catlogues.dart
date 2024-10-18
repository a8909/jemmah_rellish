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
  int? savedCount = 0;

  void showModal(String productImage, String productName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 350,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.network(
                  productImage,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
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
      var addItem = items[index];
      final cart = Cart(
          image: addItem['image'],
          title: addItem['title'],
          price: addItem['price'],
          deliveryStatus: addItem['category']);
      crt.onAdd(cart);
      showModal(addItem['image'], addItem['title']);
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
    savedCount = await storage.savedTooltips('tipsKey');
    setState(() {
      cartCount = savedCount ?? 0;
    });
  }

  void _onRefresh() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        items.shuffle();
      },
    );
  }

  void showCart() {
    Navigator.pushNamed(context, '/carts');
  }

  @override
  void initState() {
    super.initState();
    _updateProducts();
    _updatePagination();
    _onLoadtoolTip();
  }

  void _updateProducts() async {
    final List products = await _endPoint.getProducts();
    setState(() {
      items = products;
    });
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
        populatedProduct = items;
      } else {
        populatedProduct = items.where((q) {
          final queryList =
              q['category'].toLowerCase().contains(search.toLowerCase()) ||
                  q['price'].toString().contains(search);
          return queryList;
        }).toList();
      }
      _updatePagination();
    });
  }

  @override
  Widget build(BuildContext context) {
    getPaginatedItem();
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
              isCartAdded ||
                      savedCount.toString().isNotEmpty 
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
                decoration:  InputDecoration(
                    hintText: 'Search to filter product by category or price',
                    helperStyle:  TextStyle(color: Colors.black.withOpacity(0.5)),
                    suffixIcon:const  Icon(Icons.search),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))))),
            const SizedBox(height: 10),
            _serchController.text.isEmpty
                ? Expanded(
                    child: FutureBuilder(
                        future: _endPoint.getProducts(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return GridView.builder(
                              itemCount: populatedProduct.isEmpty
                                  ? snapshot.data!.length
                                  : populatedProduct.length,
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                final productItems = populatedProduct.isEmpty
                                    ? snapshot.data[index]
                                    : populatedProduct[index];

                                return DisplayCart(
                                  cart: Cart(
                                      image: productItems['image'],
                                      title: productItems['title'],
                                      price: productItems['price'],
                                      deliveryStatus: productItems['category']),
                                  onTap: () {
                                    addToCart(index);
                                  },
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Text(
                                'snapshot error is : ${snapshot.error}');
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                  )
                : AnimatedOpacity(
                    opacity: 0.5,
                    curve: Curves.easeInOut,
                    duration: const Duration(seconds: 2),
                    child: Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/image/invalid_search.png',
                            height: 400,
                            width: 400
                          ),
                          const Text(
                            'Enter a vaild search entry',
                          ),
                        ],
                      ),
                    )),
            items.isEmpty || _serchController.text.isEmpty
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
