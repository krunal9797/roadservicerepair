import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roadservicerepair/app/constants/app_colors.dart';
import 'package:roadservicerepair/app/constants/app_images.dart';
import 'package:roadservicerepair/app/data/app_info.dart';
import 'package:roadservicerepair/app/modules/login/login_controller.dart';
import 'package:roadservicerepair/app/utils/button_utl.dart';
import 'package:roadservicerepair/app/utils/image_utl.dart';
import 'package:roadservicerepair/app/utils/text_field_utl.dart';
import 'package:roadservicerepair/app/utils/text_utl.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              controller.onBackToHome(); // Use the controller to handle back navigation
              return false; // Prevent default behavior
            },
            child: SafeArea(
              top: false,
              bottom: false,
              child: Scaffold(
                backgroundColor: AppColors.primary,
                body: ListView(
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: Image.asset(
                        'assets/images/5555.png',
                        width: 100, // Set the width
                        height: 100, // Set the height
                      ),),
                    // const SizedBox(height: 20),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     setSemiText(AppInfo.appName, AppColors.titleText, 18)
                    //   ],
                    // ),
                    const SizedBox(height: 40),
            
                    // TextField
                    setTextField(
                      context,
                      "Email",
                      "Enter Email",
                      controller.emailKey,
                      controller.txtEmail,
                      controller.fnEmail,
                    ),
            
                    const SizedBox(height: 15),
            
                    Obx(
                          () => setTextField(
                        context,
                        "Password",
                        "Enter Password",
                        controller.passwordKey,
                        controller.txtPassword,
                        controller.fnPassword,
                        surfix: setIconButton(
                              () => controller.onVisibilityTap(!controller.isSecure.value),
                          Icon(
                            controller.isSecure.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.detailText,
                          ),
                          height: 30,
                          width: 30,
                        ),
                        obsecureText: !controller.isSecure.value,
                      ),
                    ),
            
                    const SizedBox(height: 20),
            
                    Center(
                      child: Obx(() => setButton(
                        controller.onLoginTap,
                        controller.isLoading.value
                            ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.whiteText),
                        )
                            : setSemiText("Login", AppColors.whiteText, 16),
                        AppColors.button,
                        200,
                        50,
                      )),
                    ),
            
                    const SizedBox(height: 10),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     const SizedBox(
                    //       width: 100,
                    //       child: Divider(
                    //         color: AppColors.detailText,
                    //         thickness: 1,
                    //         height: 1,
                    //       ),
                    //     ),
                    //     const SizedBox(width: 5),
                    //     //setRegularText("OR", AppColors.titleText, 14),
                    //     const SizedBox(width: 5),
                    //     const SizedBox(
                    //       width: 100,
                    //       child: Divider(
                    //         color: AppColors.detailText,
                    //         thickness: 1,
                    //         height: 1,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 10),
            
                    // Center(
                    //   child: setButton(
                    //     controller.onRegisterTap,
                    //     setSemiText("Register", AppColors.whiteText, 16),
                    //     AppColors.detailText,
                    //     200,
                    //     50,
                    //   ),
                    // ),
            
            //                  const SizedBox(height: 70),
            
                    Center(
                      child: setTextButton(
                        controller.onForgotTap,
                        setSemiText(
                          "Forgot password?",
                          AppColors.titleText,
                          14,
                          textDecoration: TextDecoration.underline,
                        ),
                      ),
                    ),
            
                    // Center(
                    //   child: setButton(
                    //     controller.onReqServiceTap,
                    //     setSemiText("Request Road Service", AppColors.whiteText, 16),
                    //     AppColors.titleText,
                    //     MediaQuery.of(context).size.width - 40,
                    //     50,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}