import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class InternetConnection {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription subscription;
  bool isconnected = false;
  // late final BuildContext context;
  set connectionState(bool param) {
    isconnected = param;
    // _showSnackbar();
  }

  //  void _showSnackbar() {
  //   final snackBar = SnackBar(
  //     content: Text(isconnected
  //         ? 'You are connected to the internet'
  //         : 'No internet connection'),
  //     duration: const Duration(milliseconds: 1500),
  //   );

  // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }

  checkConnection() {
    subscription = _connectivity.onConnectivityChanged.listen(
      (event) {
        print('event is $event');
        if (event == [ConnectivityResult.mobile] ||
            event == [ConnectivityResult.wifi]) {
          print('mobile event is $event');
          isconnected = true;
          return;
        } else if (event == [ConnectivityResult.none]) {
          print('no connection is : $event');
          isconnected = false;
          return;
        }
      },
    );
  }
}
