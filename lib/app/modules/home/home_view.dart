import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roadservicerepair/app/constants/app_colors.dart';
import 'package:roadservicerepair/app/modules/home/home_controller.dart';
import 'package:roadservicerepair/app/modules/login/login_view.dart';
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.primary,
              body: Column(
                children: [
                  // Top Carousel
                  // Top image (changes every few seconds)
                  SizedBox(
                    height: 450, // Fixed height
                    width: double.infinity, // Ensures the image fills horizontally
                    child: Image.asset(
                      'assets/images/abc.png',

                    ),
                  ),
                  // Login Form
                  SizedBox(height: 50,),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [


                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: Colors.red,
                            ),
                            onPressed: controller.onReqServiceTap,
                            child: Text(
                              'Need Road Service',
                              style:
                              TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),

                          SizedBox(height: 15),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: Colors.red,
                            ),
                            onPressed: controller.onRegisterTapCustomer,
                            child: Text(
                              'Become customer ',
                              style:
                              TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),

                          SizedBox(height: 10),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: Colors.red,
                            ),
                            onPressed: controller.onRegisterTapVendor,
                            child: Text(
                              'Become vendor',
                              style:
                              TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),

                          SizedBox(height: 10),

                          Center(
                            child: GestureDetector(
                              onTap: controller.onAlreadyRegisteredTap, // Trigger the action
                              child: Text(
                                'Already registered? Click to login',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.red, // Optional for emphasis
                                ),
                              ),
                            ),
                          ),


                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
