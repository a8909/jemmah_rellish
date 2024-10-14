import 'package:jemmah_rellish/components/localStorage.dart';
import 'package:jemmah_rellish/components/models/carts.dart';

class CartItems {
  final Localstorage _storage = Localstorage();
  List<Cart> categories = [];

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
