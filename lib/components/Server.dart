import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jemmah_rellish/components/localStorage.dart';

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

    try {
      // prefs.setString('Auth', jsonDecode(response.body));
      return response.statusCode == 200
          ? jsonDecode(response.body)
          : 'Request failed!';
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> userLogin(body) async {
    var endPoint =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDx8h2UbViCKOTIJGNzFefatv_GlwrawrE';
    var response = await http.post(Uri.parse(endPoint), body: jsonEncode(body));

    try {
      Localstorage().create(key: 'auth', value: response.body);

      return response.statusCode == 200
          ? jsonDecode(response.body)
          : 'Request failed!';
    } catch (e) {
      switch (e) {
        case 'INVALID_PASSWORD':
          err = 'invalid password';
          break;
        case 'EMAIL_EXITS':
          err = 'email already exist';
          break;
        default:
          err = 'An error occurred';
      }
      print(e);
      return throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> getData() async {
    Map<String, dynamic> result = {};
    try {
      String url = "http://127.0.0.1:5000/data_yen";
      var svrResponse = await http.post(Uri.parse(url));
      print('me');
      if (svrResponse.statusCode == 200) {
        result = json.decode(svrResponse.body);
      } else {
        print(svrResponse.body);
      }
    } catch (e) {
      print('error is here');
      // log('$e');
    }
    return result;
  }
}
