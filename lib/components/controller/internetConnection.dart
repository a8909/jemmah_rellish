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
        if (event ==  [ConnectivityResult.mobile]){
          print('event is mobile');
        }else{
          print('event is : $event');
        }
      },
    );
  }
}
