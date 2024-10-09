import 'package:jemmah_rellish/components/localStorage.dart';
import 'package:jemmah_rellish/components/models/carts.dart';

class CartItems {
  final Localstorage _storage = Localstorage();
  List<Cart> categories = [
    Cart(
        productPhoto: "assets/image/HE-1114.png",
        productTitle: 'Shawamar',
        productPrice: "2000",
        delivery: 'Taste nice and better'),
    Cart(
        productPhoto: "assets/image/zobo.jpeg",
        productTitle: 'Zobo',
        productPrice: "2000",
        delivery: 'Taste nice and better'),
    Cart(
        productPhoto: "assets/image/shaw.jpeg",
        productTitle: 'Smotthie',
        productPrice: "2000",
        delivery: 'Taste nice and better'),
    Cart(
        productPhoto: "assets/image/smth.jpeg",
        productTitle: 'Cocktail',
        productPrice: "2000",
        delivery: 'Taste nice and better'),
    Cart(
        productPhoto: "assets/image/shaw2.jpeg",
        productTitle: 'Shawamar',
        productPrice: "2000",
        delivery: 'Taste nice and better'),
    Cart(
        productPhoto: "assets/image/shaw.jpeg",
        productTitle: 'Shawamar',
        productPrice: "2000",
        delivery: 'Taste nice and better'),
  ];

  get cartItems => categories;

  List<Cart> shopCart = [];

  void onAdd(Cart cart) {
    shopCart.add(cart);
  }

  List<Cart> get shop => shopCart;

  int? currentlyShopping;

  set currentShop(int? newshop) {
    currentlyShopping = newshop;
  }

  get shopping => currentlyShopping;

  saveProduct(List<String> value) async {
    await _storage.savepostUpdate('productKey', value);
  }
}
