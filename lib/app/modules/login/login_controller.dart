import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:roadservicerepair/app/constants/util.dart';
import 'package:roadservicerepair/app/modules/home/home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/Api.dart';
import '../../utils/shake_widget.dart';
import '../forgot_password/forgot_password_view.dart';
import '../registration/register_view.dart';
import '../request_service/request_service_view.dart';
import '../side_bar/side_bar_view.dart';

class LoginController extends GetxController {

  // Controller
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  // FocusNode
  FocusNode fnEmail = FocusNode();
  FocusNode fnPassword = FocusNode();

  // Shake Key
  final GlobalKey<ShakeWidgetState> emailKey = GlobalKey<ShakeWidgetState>();
  final GlobalKey<ShakeWidgetState> passwordKey = GlobalKey<ShakeWidgetState>();

  RxBool isSecure = false.obs;
  RxBool isLoading = false.obs; // Loader state

  RxInt currentImageIndex = 0.obs;
  late Timer _imageChangeTimer;

  // List of image paths
  final List<String> images = [
    'assets/images/i1.png',
    'assets/images/i2.png',
    'assets/images/i3.png',
  ];

  @override
  void onInit() {
    super.onInit();
    // Start the image change timer
    _startImageChangeTimer();
  }

  @override
  void onClose() {
    // Cancel the timer when the controller is disposed
    _imageChangeTimer.cancel();
    super.onClose();
  }

  // Method to start changing images every 3 seconds
  void _startImageChangeTimer() {
    _imageChangeTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      // Update the image index
      currentImageIndex.value = (currentImageIndex.value + 1) % images.length;
    });
  }

  onVisibilityTap(bool value) {
    isSecure.value = value;
  }

  onLoginTap() async {
    final email = txtEmail.text.trim();
    final password = txtPassword.text.trim();
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please fill in all fields");
      return;
    }

    isLoading.value = true; // Start loading

    try {
      final response = await http.post(
        Uri.parse(Api.LOGIN),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          'fcm_token': fcmToken.toString(),
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] != null && jsonResponse['status'] == 1) {
           print("RES_loginresponse"+jsonResponse.toString());
        //
           SharedPreferences prefs = await SharedPreferences.getInstance();
           prefs.setString('email', jsonResponse['info']['email'].toString());
           prefs.setString('u_id', jsonResponse['info']['u_id'].toString());
           prefs.setString('type', jsonResponse['info']['type'].toString());
           prefs.setString('cust_type', jsonResponse['info']['cust_type'].toString());
           prefs.setString('service_type', jsonResponse['info']['service_type'].toString());
           prefs.setString('type_cust', jsonResponse['info']['type_cust'].toString());
           prefs.setString('name', jsonResponse['info']['name'].toString());
           prefs.setString('mobile_no', jsonResponse['info']['mobile_no'].toString());
           prefs.setString('country_name', jsonResponse['info']['country_name'].toString());
           prefs.setString('state_name', jsonResponse['info']['state_name'].toString());
           prefs.setString('city_name', jsonResponse['info']['city_name'].toString());
           prefs.setString('address', jsonResponse['info']['address'].toString());
           prefs.setString('image', jsonResponse['info']['image'].toString());
           prefs.setString('user_type', jsonResponse['info']['user_type'].toString());
           prefs.setString('contact_person', jsonResponse['info']['contact_person'].toString());

           prefs.setString('c_id', jsonResponse['info']['c_id'].toString());


           prefs.setBool("isLogin", true);

          print(jsonResponse['info']['user_type'].toString());
          

          // Parse the response and navigate to the next screen
          Get.off(() => const SideBarView());
        } else {
          // Handle error response
          Get.snackbar("Error", jsonResponse['msg']);
        }
      } else {
        Get.snackbar("Error", "Server error: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", "An error occurred");
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  onRegisterTap() {
    Get.to(() => const RegisterView());
  }

  onForgotTap() {
    Get.to(() => const ForgotView());
  }

  onReqServiceTap() {
    Get.to(() => const ReqServiceView(), arguments: "Request Road Service");
  }

  void onBackToHome() {
    Get.off(() => const HomeView());
  }
}
