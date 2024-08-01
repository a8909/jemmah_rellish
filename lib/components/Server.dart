import 'dart:convert';

import 'package:http/http.dart' as http;

class ServiceWorker {
  Future<Map<String, dynamic>> signUP(body) async {
    var endPoint =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDx8h2UbViCKOTIJGNzFefatv_GlwrawrE';
    var response = await http.post(Uri.parse(endPoint),
        body: jsonEncode(body),
        headers: {
          "Content-type": "application/json",
          "Accept": "application/json"
        });
    print(response.body);
    try {
      return response.statusCode == 200 ? jsonDecode(body) : 'Request failed!';
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> userLogin(body) async {
    var endPoint =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDx8h2UbViCKOTIJGNzFefatv_GlwrawrE';
    var response = await http.post(Uri.parse(endPoint), body: jsonEncode(body));
    try {
      return response.statusCode == 200 ? jsonDecode(body) : 'Request failed!';
    } catch (e) {
      throw Exception(e);
    }
  }
}
