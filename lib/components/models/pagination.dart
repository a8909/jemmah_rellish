import 'package:jemmah_rellish/components/models/carts.dart';

import 'cartItems.dart';

class Pagination {
  final CartItems product = CartItems();
  int initialPage = 1;
  int perPage = 10;
  List<Cart> pages = [];
  get totalPage => product.categories = pages;
  get currentCount => (pages.length / perPage).ceil();

  set pageIndex(int newIndex) {
    initialPage = newIndex;
  }
}
