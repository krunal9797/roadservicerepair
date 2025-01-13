import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../home/home_view.dart';
import '../side_bar/side_bar_view.dart';

class SplashController extends GetxController {
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLogin") ?? false; // Return false if the key doesn't exist
  }

  Future<void> requestLocationPermission(BuildContext context) async {
    var status = await Permission.locationAlways.status;
    if (!status.isGranted) {
      bool? result = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Background Location Permission Needed",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "This app requires background location permission to provide location-based services even when the app is in the background.",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    const url = "https://roadservice.roadservicerepair.com/privacy_policy.php";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      Get.snackbar("Error", "Unable to open the link.");
                    }
                  },
                  child: const Text(
                    "Privacy Policy",
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false); // Deny permission
                },
                child: const Text("Deny"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true); // Grant permission
                },
                child: const Text("Accept"),
              ),
            ],
          );
        },
      );

      if (result == true) {
        var permissionResult = await Permission.locationAlways.request();
        if (permissionResult.isGranted) {
          Get.snackbar("Permission Granted", "Background location permission granted.");
        } else {
          Get.snackbar("Permission Denied", "Background location permission is required.");
        }
      } else {
        Get.snackbar("Permission Denied", "Background location permission is required.");
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 2)).then((value) async {
      if (await isLoggedIn()) {
        Get.off(() => const SideBarView()); // Navigate to HomeView if logged in
      } else {
        Get.off(() => const HomeView()); // Navigate to LoginView if not logged in
      }

      // Request location permission
      requestLocationPermission(Get.context!);
    });
  }
}
