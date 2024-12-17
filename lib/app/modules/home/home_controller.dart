import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:roadservicerepair/app/constants/util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/Api.dart';
import '../../utils/shake_widget.dart';
import '../forgot_password/forgot_password_view.dart';
import '../registration/register_view.dart';
import '../request_service/request_service_view.dart';
import '../side_bar/side_bar_view.dart';
import 'package:roadservicerepair/app/modules/login/login_view.dart';

class HomeController extends GetxController {

  RxInt currentImageIndex = 0.obs;
  late Timer _imageChangeTimer;

  // List of image paths
  final List<String> images = [
    'assets/images/road_repair_service_1.png',
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
    _imageChangeTimer = Timer.periodic(Duration(seconds: 50000), (timer) {
      // Update the image index
      currentImageIndex.value = (currentImageIndex.value + 1) % images.length;
    });
  }

  onRegisterTapCustomer() {
    Get.to(() => const RegisterView(),arguments:1);
  }

  onRegisterTapVendor() {
    Get.to(() => const RegisterView(),arguments:2);
  }
  onForgotTap() {
    Get.to(() => const ForgotView());
  }

  onReqServiceTap() {
    Get.to(() => const ReqServiceView(), arguments: "Request Road Service");
  }

  onAlreadyRegisteredTap(){
    Get.to(() => const LoginView());
  }

}
