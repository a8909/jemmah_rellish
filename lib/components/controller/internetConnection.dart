import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'networkError.dart';

class InternetConnection {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription subscription;
  bool isconnected = false;
  set connectionState(bool param) {
    isconnected = param;
  }

  checkConnection() async {
    final result = await _connectivity.checkConnectivity();
    print('result : $result');
    if (result == [ConnectivityResult.wifi]) {
      connectionState = false;
      print('wifi');
    }
    subscription = _connectivity.onConnectivityChanged.listen((result) {
      print('connetion is reached');
      if (result == ConnectivityResult.none) {
        print('eventState : $result');
        connectionState = false;
        const NetworkError();
      }
    });
  }
}
