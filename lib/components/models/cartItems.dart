import 'package:jemmah_rellish/components/models/carts.dart';

class CartItems {
  List<Cart> categories = [
    Cart(
        imagePath: "assets/image/HE-1114.png",
        name: 'Shawamar',
        price: "2000",
        content: 'Taste nice and better'),
    Cart(
        imagePath: "assets/image/HE-1114.png",
        name: 'Zobo',
        price: "2000",
        content: 'Taste nice and better'),
    Cart(
        imagePath: "assets/image/HE-1114.png",
        name: 'Smotthie',
        price: "2000",
        content: 'Taste nice and better'),
    Cart(
        imagePath: "assets/image/HE-1114.png",
        name: 'Cocktail',
        price: "2000",
        content: 'Taste nice and better'),
    Cart(
        imagePath: "assets/image/HE-1114.png",
        name: 'Shawamar',
        price: "2000",
        content: 'Taste nice and better'),
    Cart(
        imagePath: "assets/image/HE-1114.png",
        name: 'Shawamar',
        price: "2000",
        content: 'Taste nice and better'),
  ];

  get cartItems => categories;

  List<Cart> shopCart = [];

  void onAdd(Cart cart) {
    shopCart.add(cart);
  }

  get shop => shopCart;
}
