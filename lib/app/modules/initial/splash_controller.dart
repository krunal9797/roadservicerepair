import 'package:get/get.dart';
import 'package:roadservicerepair/app/modules/login/login_view.dart';
import 'package:roadservicerepair/app/modules/home/home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../side_bar/side_bar_view.dart';

class SplashController extends GetxController {

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLogin") ?? false; // Return false if the key doesn't exist
  }
  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 2)).then(
      (value) async {
          if (await isLoggedIn()) {
            Get.off(() => const SideBarView()); // Navigate to HomeView if logged in
          } else {
            Get.off(() => const HomeView()); // Navigate to LoginView if not logged in
          }
        }
    );

    super.onReady();
  }
}
