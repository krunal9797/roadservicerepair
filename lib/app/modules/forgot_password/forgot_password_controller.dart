import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roadservicerepair/app/utils/shake_widget.dart';

class ForgotController extends GetxController {
  //Controller
  TextEditingController txtEmail = TextEditingController();

  //FocusNode
  FocusNode fnEmail = FocusNode();

  //Shake Key
  final isEmail = GlobalKey<ShakeWidgetState>();

  onSubmitTap() {}
}
