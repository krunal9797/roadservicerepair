import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roadservicerepair/app/constants/app_colors.dart';
import 'package:roadservicerepair/app/utils/text_utl.dart';

showDialogBox(String title, String message, Function() onYes,
    {Function()? onNo}) {
  return Get.dialog(CupertinoAlertDialog(
    title: setSemiText(title, AppColors.titleText, 16),
    content: setRegularText(message, AppColors.titleText, 14),
    actions: <Widget>[
      CupertinoDialogAction(
        isDefaultAction: true,
        onPressed: onYes,
        child: setSemiText("Yes", AppColors.titleText, 12),
      ),
      CupertinoDialogAction(
        onPressed: onNo ??
            () {
              Get.back();
            },
        child: setRegularText("No", AppColors.titleText, 12),
      )
    ],
  ));
}
