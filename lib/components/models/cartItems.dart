import 'package:jemmah_rellish/components/localStorage.dart';
import 'package:jemmah_rellish/components/models/carts.dart';

class CartItems {
  final Localstorage _storage = Localstorage();
  List<Cart> categories = [
    Cart(
        product_photo: "assets/image/HE-1114.png",
        product_title: 'Shawamar',
        product_price: "2000",
        delivery: 'Taste nice and better'),
    Cart(
        product_photo: "assets/image/zobo.jpeg",
        product_title: 'Zobo',
        product_price: "2000",
        delivery: 'Taste nice and better'),
    Cart(
        product_photo: "assets/image/shaw.jpeg",
        product_title: 'Smotthie',
        product_price: "2000",
        delivery: 'Taste nice and better'),
    Cart(
        product_photo: "assets/image/smth.jpeg",
        product_title: 'Cocktail',
        product_price: "2000",
        delivery: 'Taste nice and better'),
    Cart(
        product_photo: "assets/image/shaw2.jpeg",
        product_title: 'Shawamar',
        product_price: "2000",
        delivery: 'Taste nice and better'),
    Cart(
        product_photo: "assets/image/shaw.jpeg",
        product_title: 'Shawamar',
        product_price: "2000",
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
