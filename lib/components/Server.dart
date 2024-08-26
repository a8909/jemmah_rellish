import 'dart:convert';

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
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var endPoint =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDx8h2UbViCKOTIJGNzFefatv_GlwrawrE';
    var response = await http.post(Uri.parse(endPoint), body: jsonEncode(body));
    var data = jsonDecode(response.body);

    try {
      if (response.statusCode == 200) {
        _pref.setString('auth', data['idToken']);
        return data;
      } else {
        final responseBody = jsonDecode(response.body);
        final errorMessage =
            responseBody['error']?['message'] ?? 'An error occurred';
        switch (errorMessage) {
          case 'INVALID_PASSWORD':
            err = 'invalid password';
            break;
          case 'EMAIL_EXITS':
            err = 'email already exist';
            break;
          case 'INVALID_LOGIN_CREDENTIALS':
            err = 'Invalid login';
            break;
          default:
            err = 'An error occurred';
        }
        return throw Exception(errorMessage);
      }
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

  onHandleError(errorType) {
    switch (errorType) {
      case 'INVALID_LOGIN_CREDENTIALS':
        err = 'Invalid login';
        break;
    }
    return err;
  }
}
