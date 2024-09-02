import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class InternetConnection {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription subscription;
  void checkConnection() {
    subscription = _connectivity.onConnectivityChanged.listen(_updatedStatus);
  }

  void _updatedStatus(List<ConnectivityResult> event) {
    print(event);
    // if () {
    //   const SnackBar(
    //       content: Row(
    //     children: [Icon(Icons.wifi_off), Text('Connection lost..')],
    //   ));
    //   return;
    // } else if (event == ConnectivityResult.mobile) {
    //   const SnackBar(
    //       content: Row(
    //     children: [Icon(Icons.wifi), Text('Connection restored..')],
    //   ));
    //   return;
    // }
  }
}
