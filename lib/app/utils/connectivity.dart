import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:roadservicerepair/app/data/app_info.dart';

class InternetConnectivity {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  bool isConnected = false;
  bool isChecked = false;

  static final InternetConnectivity _singleton =
      InternetConnectivity._internal();

  factory InternetConnectivity() {
    return _singleton;
  }

  InternetConnectivity._internal() {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  dispose() {
    _connectivitySubscription.cancel();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e);
      return;
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus = result;

    switch (_connectionStatus) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
        isConnected = true;
        break;

      case ConnectivityResult.none:
        isConnected = false;
        break;

      default:
        isConnected = false;

        break;
    }

    // isChecked ? showSnackBar(isConnected) : null;
    isChecked = true;

    print("Online: ${isConnected}");
  }

  showSnackBar(bool isOnline) {
    Get.snackbar(
      AppInfo.appName,
      isOnline ? "You are connected." : "Please check your internet conection.",
      icon: isConnected
          ? const Icon(Icons.signal_cellular_alt_rounded, color: Colors.white)
          : const Icon(
              Icons.signal_cellular_connected_no_internet_0_bar_rounded,
              color: Colors.white),
      snackPosition: SnackPosition.TOP,
      backgroundColor:
          isConnected ? Colors.green.shade300 : Colors.red.shade300,
      borderRadius: 20,
      margin: const EdgeInsets.all(15),
      colorText: Colors.white,
      isDismissible: true,
      dismissDirection: DismissDirection.vertical,
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}
