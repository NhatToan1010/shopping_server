import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shopping_server/utils/popups/loader.dart';

// Manages the network connectivity status and provides methods to handle and check connectivity changes
class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final RxList<ConnectivityResult> _connectionStatus = <ConnectivityResult>[].obs;

  // ----- Initialize the network manager and set up a stream
  // to continually check the connection status
  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  // ----- Update the connection status based on changes in connectivity
  // and show relevant popup for no Internet connection
  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    _connectionStatus.value = result;

    if (result.contains(ConnectivityResult.none)) {
      CustomLoader.customToast(message: 'No Internet Connection');
    }
  }

  // ----- Check the Internet Connection Status
  // return true if connected, false otherwise
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result.any((element) => element == ConnectivityResult.none)) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

// ----- Dispose or close the network connectivity stream
  @override
  void onClose() {
    super.onClose();

    _connectivitySubscription.cancel();
  }
}
