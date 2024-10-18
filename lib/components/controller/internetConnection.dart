import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'networkError.dart';

class InternetConnection {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription subscription;
  bool isconnected = false;
  set connectionState(bool param) {
    isconnected = param;
    _updateConnectionStatus;
  }

  checkConnection() async {
    final ConnectivityResult connectionResult = (await _connectivity.checkConnectivity()) as ConnectivityResult;
    _updateConnectionStatus(connectionResult);
    print('connectionState: $connectionResult');
    subscription =
        _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> result){
          _updateConnectionStatus(result as ConnectivityResult);
        });
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      connectionState = true;
      print('true');
    }
    connectionState = false;
    print('false');
    const NetworkError();
  }
}
