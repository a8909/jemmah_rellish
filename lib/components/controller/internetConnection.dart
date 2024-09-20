import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnection {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription subscription;
  bool isconnected = false;
  set connectionState(bool param) {
    isconnected = param;
  }

  checkConnection() {
    subscription = _connectivity.onConnectivityChanged.listen(
      (event) {
        if (event == [ConnectivityResult.mobile]) {
          print('Connected to mobile network');
        } else if (event == ConnectivityResult.wifi) {
          print('Connected to WiFi');
        } else if (event == ConnectivityResult.none) {
          print('No internet connection');
        } else {
          print('Unknown connection state: $event');
          connectionState = false;
        }
      },
    );
  }
}
