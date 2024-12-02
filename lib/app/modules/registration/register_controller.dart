import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roadservicerepair/app/utils/shake_widget.dart';

class RegisterController extends GetxController {
  RxInt userType = 0.obs;

  List<String> arrCustomerType = ["Owner", "Manager", "Driver"];
  List<String> arrVendorType = ["Owner", "Manager", "Mechanic"];
  List<String> arrCustFor = ["Company", "Shop", "Individual"];
  List<String> arrVenFor = ["Mobile", "Shop"];
  List<String> arrServiceType = [
    "Truck Repair",
    "Trailer Repair",
    "Tier Repair",
    "Towing Service"
  ];
  List<String> arrCountry = ["Canada", "US"];
  List<String> arrState = ["Remain"];
  List<String> arrCity = ["Remain"];

  //Shake Key
  final isCustomerType = GlobalKey<ShakeWidgetState>();
  final isVendorType = GlobalKey<ShakeWidgetState>();
  final isCustFor = GlobalKey<ShakeWidgetState>();
  final isVenFor = GlobalKey<ShakeWidgetState>();
  final isServiceType = GlobalKey<ShakeWidgetState>();
  final isCountry = GlobalKey<ShakeWidgetState>();
  final isState = GlobalKey<ShakeWidgetState>();
  final isCity = GlobalKey<ShakeWidgetState>();

  final isCompanyName = GlobalKey<ShakeWidgetState>();
  final isPhone = GlobalKey<ShakeWidgetState>();
  final isAdd = GlobalKey<ShakeWidgetState>();
  final isEmail = GlobalKey<ShakeWidgetState>();
  final isPassword = GlobalKey<ShakeWidgetState>();

  //Controller

  TextEditingController txtCompanyName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtAdd = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  //FocusNode
  FocusNode fnCompanyName = FocusNode();
  FocusNode fnPhone = FocusNode();
  FocusNode fnAdd = FocusNode();
  FocusNode fnEmail = FocusNode();
  FocusNode fnPassword = FocusNode();

  RxBool isSecure = false.obs;

  onVisibilityTap(bool value) {
    isSecure.value = value;
  }

  onUserTypeTapped(int value) {
    userType.value = value;
  }
}
