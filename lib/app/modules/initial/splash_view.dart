import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:roadservicerepair/app/constants/app_colors.dart';
import 'package:roadservicerepair/app/constants/app_images.dart';
import 'package:roadservicerepair/app/data/app_info.dart';
import 'package:roadservicerepair/app/modules/initial/splash_controller.dart';
import 'package:roadservicerepair/app/utils/global.dart';
import 'package:roadservicerepair/app/utils/image_utl.dart';
import 'package:roadservicerepair/app/utils/text_utl.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SplashController(),
        builder: (_) {
          return SafeArea(
              top: false,
              bottom: false,
              child: Scaffold(
                backgroundColor: AppColors.primary,
                body: SizedBox(
                  height: getScreenHeight(context),
                  width: getScreenWidth(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        child: setImageWithSize(AppImages.appLogo, 100, 100),
                      ),
                      const SizedBox(height: 20),
                      setBoldText(AppInfo.appName, AppColors.titleText, 18)
                    ],
                  ),
                ),
              ));
        });
  }
}
