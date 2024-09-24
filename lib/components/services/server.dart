import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ServiceWorker {
  String err = '';
  Future<Map<String, dynamic>> signUP(body) async {
    var endPoint =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDx8h2UbViCKOTIJGNzFefatv_GlwrawrE';
    var response = await http.post(Uri.parse(endPoint),
        body: jsonEncode(body),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json"
        });
    print('body:$body');

    try {
      return response.statusCode == 200
          ? jsonDecode(response.body)
          : 'Request failed!';
    } catch (e) {
      print('>>>>>$e');
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> userLogin(body) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var endPoint =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDx8h2UbViCKOTIJGNzFefatv_GlwrawrE';
    var response = await http.post(Uri.parse(endPoint), body: jsonEncode(body));
    var data = jsonDecode(response.body);

    try {
      pref.setString('auth', data['idToken']);
      return response.statusCode == 200 ? data : "An error occurred";
    } catch (e) {
      return throw Exception(e); //onHandleError(e);
    }
  }

  Future<Map<String, dynamic>> getData() async {
    Map<String, dynamic> result = {};
    try {
      String url = "http://127.0.0.1:5000/data_yen";
      var svrResponse = await http.post(Uri.parse(url));
      if (svrResponse.statusCode == 200) {
        result = json.decode(svrResponse.body);
      } else {
        print(svrResponse.body);
      }
    } catch (e) {}
    return result;
  }

  Future<dynamic> getProducts() async {
    const url =
        "https://Real-Time-Amazon-Data.proxy-production.allthingsdev.co/v2/products-by-category?category_id=2478868012&page=1&country=US&sort_by=RELEVANCE&product_condition=ALL&min_price=105&max_price=110&brand=null";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data']['products'];
    } else {
      return throw Exception('failed to load post');
    }
  }

  onHandleError(errorType) {
    switch (errorType) {
      case 'INVALID_LOGIN_CREDENTIALS':
        err = 'Invalid login';
        break;
    }
    return err;
  }
}
