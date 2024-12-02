import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../model/CityData.dart';
import '../../../model/Country.dart';
import '../../../model/StateData.dart';
import '../../constants/app_colors.dart';
import '../../utils/button_utl.dart';
import '../../utils/drop_down_utl.dart';
import '../../utils/text_field_utl.dart';
import '../../utils/text_utl.dart';
import 'Edit_inquiry_controller.dart';

class EditInquiryview extends StatefulWidget {
  const EditInquiryview({super.key});

  @override
  State<EditInquiryview> createState() => _EditInquiryviewState();
}

class _EditInquiryviewState extends State<EditInquiryview> {
  final controller = Get.put(EditInquiryController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.whiteText,
          title: Obx(() => setSemiText(controller.pageTitle.value, AppColors.titleText, 16)),
        ),
        backgroundColor: AppColors.primary,
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [




            const SizedBox(height: 15),

            setTextField1(
              context,
              "Service.",
              "Enter service",
              controller.isServices,
              controller.txtServices,
              controller.fnServices,
            ),
            const SizedBox(height: 15),
            setTextField1(
              context,
              "truck_make.",
              "Enter truck_make",
              controller.isTruck_make,
              controller.txtTruck_make,
              controller.fnTruck_make,
            ),
            const SizedBox(height: 15),
            setTextField1(
              context,
              "make_other.",
              "Enter make_other",
              controller.isMake_other,
              controller.txtMake_other,
              controller.fnMake_other,
            ),
            const SizedBox(height: 15),
            setTextField1(
              context,
              "vi_number.",
              "Enter vi_number",
              controller.isvi_number,
              controller.txtvi_number,
              controller.fnvi_number,
            ),

            const SizedBox(height: 15),

            setTextField1(
              context,
              "tire_type.",
              "Enter tire_type",
              controller.isTire_type,
              controller.txtTire_type,
              controller.fnTire_type,
            ),
            const SizedBox(height: 15),

            setTextField1(
              context,
              "tire_size.",
              "Enter tire_size",
              controller.isTire_size,
              controller.txtTire_size,
              controller.fnTire_size,
            ),
            const SizedBox(height: 15),

            setTextField1(
              context,
              "towing_for.",
              "Enter towing_for",
              controller.istowing_for,
              controller.txttowing_for,
              controller.fntowing_for,
            ),
            const SizedBox(height: 15),

            setTextField1(
              context,
              "country_name.",
              "Enter country_name",
              controller.iscountry_name,
              controller.txtcountry_name,
              controller.fncountry_name,
            ), const SizedBox(height: 15),

            setTextField1(
              context,
              "state_name.",
              "Enter state_name",
              controller.isstate_name,
              controller.txtstate_name,
              controller.fnstate_name,
            ), const SizedBox(height: 15),

            setTextField1(
              context,
              "city_name.",
              "Enter city_name",
              controller.iscity_name,
              controller.txtcity_name,
              controller.fncity_name,
            ),
            const SizedBox(height: 15),

            setTextField1(
              context,
              "cust_mobileno.",
              "Enter cust_mobileno",
              controller.iscust_mobileno,
              controller.txtcust_mobileno,
              controller.fncust_mobileno,
            ),
            const SizedBox(height: 15),

            setTextField1(
              context,
              "cust_address.",
              "Enter cust_address",
              controller.iscust_address,
              controller.txtcust_address,
              controller.fncust_address,
            ),
            const SizedBox(height: 15),

            setTextField1(
              context,
              "remark.",
              "Enter remark",
              controller.isremark,
              controller.txtremark,
              controller.fnremark,
            ),
            const SizedBox(height: 15),

            setTextField1(
              context,
              "est_time.",
              "Enter est_time",
              controller.isest_time,
              controller.txtest_time,
              controller.fnest_time,
            ),
            const SizedBox(height: 15),

            setTextField1(
              context,
              "est_price.",
              "Enter est_price",
              controller.isest_price,
              controller.txtest_price,
              controller.fnest_price,
            ),
            const SizedBox(height: 15),

            setTextField1(
              context,
              "vendor_name.",
              "Enter vendor_name",
              controller.isvendor_name,
              controller.txtvendor_name,
              controller.fnvendor_name,
            ),
            const SizedBox(height: 15),

            setTextField1(
              context,
              "vendor_email.",
              "Enter vendor_email",
              controller.isvendor_email,
              controller.txtvendor_email,
              controller.fnvendor_email,
            ),
            const SizedBox(height: 15),

            setTextField1(
              context,
              "rname.",
              "Enter rname",
              controller.isrname,
              controller.txtrname,
              controller.fnrname,
            ),


            const SizedBox(height: 15),

            setTextField1(
              context,
              "Mobile No.",
              "Enter mobile number",
              controller.isMobile,
              controller.txtMobile,
              controller.fnMobile,
            ),
            const SizedBox(height: 15),
            setTextField1(
              context,
              "Email",
              "Enter Email",
              controller.isEmail,
              controller.txtEmail,
              controller.fnEmail,
            ),
            const SizedBox(height: 15),

            setTextFormField1(
              context,
              "Your Location",
              "Enter your address",
              controller.isAdrs,
              controller.txtAdrs,
              controller.fnAdrs,
            ),
            const SizedBox(height: 15),

            Center(
              child: Obx(() {
                if (controller.statuses.isEmpty) {
                  return CircularProgressIndicator();
                } else {
                  return DropdownButton<String>(
                    hint: Text('Select Status'),
                    value: controller.selectedStatus.value.isEmpty
                        ? null
                        : controller.selectedStatus.value,
                    onChanged: (String? newValue) {
                      controller.updateSelectedStatus(newValue!);
                    },
                    items: controller.statuses.map((status) {
                      return DropdownMenuItem<String>(
                        value: status['name'],
                        child: Text(status['name']!),
                      );
                    }).toList(),
                  );
                }
              }),
            ),
            SizedBox(height: 20),
            // Obx(() => Text(
            //   'Selected ID: ${controller.selectedId ?? ""}',
            //   style: TextStyle(fontSize: 18),
            // )),


            const SizedBox(height: 30),

            Center(
              child: setButton(
                    () => controller.sendNow(context),
                setSemiText("Update Now", AppColors.whiteText, 16),
                AppColors.button,
                200,
                50,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
