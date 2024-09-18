// import 'dart:async';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';

// class InternetConnection {
//   final Connectivity _connectivity = Connectivity();
//   late StreamSubscription subscription;
//   final Type context = BuildContext;

//   void checkConnection(context) {
//     subscription =
//         _connectivity.onConnectivityChanged.listen(_initializeConnection(context));
//   }

//   _initializeConnection(context)  {

//     if (connectionStatus == ConnectivityResult.mobile) {
//      _showSnackBar('Connection restored..', Icons.wifi, context);
//     } else {
//       if (connectionStatus == ConnectivityResult.none) {
//         _showSnackBar('Connection lost..', Icons.wifi_off, context);
       
//       }
//     }
//   }

//   void _showSnackBar(String message, IconData icon, context ) {
//     final snackBar = SnackBar(
//       content: Row(
//         children: [
//           Icon(icon),
//           const SizedBox(width: 8),
//           Expanded(child: Text(message)),
//         ],
//       ),
//       duration: const Duration(seconds: 3),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
// }
