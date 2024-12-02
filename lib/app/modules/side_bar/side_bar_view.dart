import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roadservicerepair/app/constants/app_colors.dart';
import 'package:roadservicerepair/app/constants/app_images.dart';
import 'package:roadservicerepair/app/data/app_info.dart';
import 'package:roadservicerepair/app/modules/customer_request_status/Customer_Request_Status.dart';
import 'package:roadservicerepair/app/modules/login/login_view.dart';
import 'package:roadservicerepair/app/modules/profile/profile_view.dart';
import 'package:roadservicerepair/app/modules/request_service/request_service_view.dart';
import 'package:roadservicerepair/app/modules/show_view_inquiry/ViewVendor_Inquiry.dart';
import 'package:roadservicerepair/app/modules/side_bar/side_bar_controller.dart';
import 'package:roadservicerepair/app/modules/vendor_request/vendor_request_view.dart';
import 'package:roadservicerepair/app/modules/vendor_request_status/Vendor_Request_Status.dart';
import 'package:roadservicerepair/app/modules/view_customer/view_customer_view.dart';
import 'package:roadservicerepair/app/modules/view_inquiry/view_inquiry.dart';
import 'package:roadservicerepair/app/modules/view_vendor/view_vendor_view.dart';
import 'package:roadservicerepair/app/utils/dialog_ult.dart';
import 'package:roadservicerepair/app/utils/image_utl.dart';
import 'package:roadservicerepair/app/utils/sidebar_btn_utl.dart';
import 'package:roadservicerepair/app/utils/text_utl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../request/Request.dart';

class SideBarView extends StatefulWidget {
  const SideBarView({super.key});

  @override
  State<SideBarView> createState() => _SideBarViewState();
}

class _SideBarViewState extends State<SideBarView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SideBarController>(
        init: SideBarController(),
        builder: (_) {
          return SafeArea(
            top: true,
            bottom: true,
            child: Scaffold(
              backgroundColor: AppColors.primary,
              appBar: AppBar(
                backgroundColor: AppColors.whiteText,
                surfaceTintColor: AppColors.whiteText,
                title: Obx(
                  () => setSemiText(
                      _.initialPage.value == 1
                          ? "Profile"
                          : _.initialPage.value == 2
                              ? "View Inquiry"
                              : _.initialPage.value == 3
                                  ? "Vendor Request"
                                  : _.initialPage.value == 4
                                      ? "View Vendor"
                                      : _.initialPage.value==5
                                       ? "View Customer"
                                       : _.initialPage.value==6
                                        ? "Request"
                                        :  _.initialPage.value==7
                                         ? "Customer Request Status"
                                        : _.initialPage.value==8
                                          ? "Vendor Request Status"
                                         : "View Inquiry",
                      AppColors.titleText,
                      16),
                ),
                centerTitle: true,
                actions: [
                  Obx(
                    () => _.initialPage.value == 2
                        ? IconButton(
                            icon: const Icon(
                              Icons.add,
                              color: AppColors.titleText,
                            ),
                            onPressed: () {
                              Get.to(() => const ReqServiceView(),
                                  arguments: "Add Inquiry");
                            },
                          )
                        : const SizedBox(),
                  )
                ],
              ),
              drawer: Drawer(
                key: _.isDrawer,
                backgroundColor: AppColors.primary,
                child: ListView(
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        child: setImageWithSize(AppImages.appLogo, 100, 100),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        setSemiText(AppInfo.appName, AppColors.titleText, 16)
                      ],
                    ),
                    const SizedBox(height: 40),
                    //profile
                    Obx(
                      () => setSideBarButton("Profile", () {
                        _.onPageSelect(1);
                      }, _.initialPage.value == 1),
                    ),


                    Obx(
                      () => Visibility(
                        visible: _.userType== "0",
                        child: Column(

                          children: [
                            const SizedBox(height: 10),

                            setSideBarButton("View Inquiry", () {
                            _.onPageSelect(2);
                          }, _.initialPage.value == 2),
        ] ),
                      ),
                    ),

                    Obx(
                      () => Visibility(
                        visible: _.userType== "0",

                        child: Column(


                          children: [
                            const SizedBox(height: 10),

                            setSideBarButton("Vendor Request", () {
                            _.onPageSelect(3);
                          }, _.initialPage.value == 3),
                      ]  ),
                      ),
                    ),

                    Obx(
                      () => Visibility(
                        visible: _.userType== "0",

                        child: Column(
                          children: [
                            const SizedBox(height: 10),

                            setSideBarButton("View Vendor", () {
                            _.onPageSelect(4);
                          }, _.initialPage.value == 4),
                      ]  ),
                      ),
                    ),

                    Obx(
                          () => Visibility(
                        visible: _.userType== "0",

                        child: Column(
                            children: [
                              const SizedBox(height: 10),

                              setSideBarButton("View Customer", () {
                                _.onPageSelect(5);
                              }, _.initialPage.value == 5),
                            ]  ),
                      ),
                    ),


                    Obx(
                          () => Visibility(
                        visible: _.userType== "1",

                        child: Column(
                            children: [
                              const SizedBox(height: 10),

                              setSideBarButton("Request", () {
                                _.onPageSelect(6);
                              }, _.initialPage.value == 6),
                            ]  ),
                      ),
                    ),
                    Obx(
                          () => Visibility(
                        visible: _.userType== "1",

                        child: Column(
                            children: [
                              const SizedBox(height: 10),

                              setSideBarButton("Customer Request Status", () {
                                _.onPageSelect(7);
                              }, _.initialPage.value == 7),
                            ]  ),
                      ),
                    ),
                    Obx(
                          () => Visibility(
                        visible: _.userType== "2",

                        child: Column(
                            children: [
                              const SizedBox(height: 10),

                              setSideBarButton("Vendor Request Status", () {
                                _.onPageSelect(8);
                              }, _.initialPage.value == 8),
                            ]  ),
                      ),
                    ),
                    Obx(
                          () => Visibility(
                        visible: _.userType== "2",

                        child: Column(
                            children: [
                              const SizedBox(height: 10),

                              setSideBarButton("View Inquiry", () {
                                _.onPageSelect(9);
                              }, _.initialPage.value == 9),
                            ]  ),
                      ),
                    ),



                    const SizedBox(height: 30),

                    setSideBarButton("Logout", () {
                      showDialogBox(
                          "Logout", "are you sure, you want to logout?", () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setBool("isLogin", false);
                        Get.offAll(() => LoginView());
                      });
                    }, false, isLogout: true),

                  ],
                ),
              ),
              body: Obx(
                () => _.initialPage.value == 1
                    ? const ProfileView()
                    : _.initialPage.value == 2
                        ? const ViewInquiryView()
                        : _.initialPage.value == 3
                            ? const VendorReqView()
                            : _.initialPage.value == 4
                                ? const VendorsView()
                                : _.initialPage.value==5
                                 ? const CustomersView()
                                : _.initialPage.value==6
                                 ? const Request()
                                 :_.initialPage.value==7
                                 ? const CustomerRequestStatus()
                                 : _.initialPage.value==8
                                 ? const VendorRequestStatus()
                                 : const ViewvendorInquiry()
              ),
            ),
          );
        });
  }
}
