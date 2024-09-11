import 'package:jemmah_rellish/components/models/carts.dart';

class CartItems {
  List<Cart> categories = [
    Cart(
        imagePath: "assets/image/HE-1114.png",
        name: 'Shawamar',
        price: "2000",
        content: 'Taste nice and better'),
    Cart(
        imagePath: "assets/image/zobo.jpeg",
        name: 'Zobo',
        price: "2000",
        content: 'Taste nice and better'),
    Cart(
        imagePath: "assets/image/shaw.jpeg",
        name: 'Smotthie',
        price: "2000",
        content: 'Taste nice and better'),
    Cart(
        imagePath: "assets/image/smth.jpeg",
        name: 'Cocktail',
        price: "2000",
        content: 'Taste nice and better'),
    Cart(
        imagePath: "assets/image/shaw2.jpeg",
        name: 'Shawamar',
        price: "2000",
        content: 'Taste nice and better'),
    Cart(
        imagePath: "assets/image/shaw.jpeg",
        name: 'Shawamar',
        price: "2000",
        content: 'Taste nice and better'),
  ];

  get cartItems => categories;

  List<Cart> shopCart = [
    Cart(
        imagePath: "assets/image/shaw.jpeg",
        name: 'Shawamar',
        price: "2000",
        content: 'Taste nice and better'),
    Cart(
        imagePath: "assets/image/zobo.jpeg",
        name: 'Zobo',
        price: "2000",
        content: 'Taste nice and better'),
  ];

  void onAdd(Cart cart) {
    shopCart.add(cart);
  }

  List<Cart> get shop => shopCart;

  int? currentlyShopping;

  set currentShop(int? newshop) {
    currentlyShopping = newshop;
  }

   get shopping => currentlyShopping;
}
