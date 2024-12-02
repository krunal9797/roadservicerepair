import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideBarController extends GetxController {
  // Page Number
  // 1 Profile
  // 2 View Inquiry
  // 3 Vendor Request
  // 4 View Vendor
  // 5 View Customer
  @override


  RxInt initialPage = 1.obs;
  String userType ='';
  final isDrawer = GlobalKey<DrawerControllerState>();
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    showdrawer();
  }

  onPageSelect(int value) {
    initialPage.value = value;
    Get.back();
  }

  showdrawer( ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     userType = prefs.getString('user_type')!;
     print("drawer"+userType);
  }
}
