import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:roadservicerepair/app/modules/edit_vendor_inquiry/EditInquiry_controller.dart';

import '../../constants/app_colors.dart';
import '../../utils/button_utl.dart';
import '../../utils/text_field_utl.dart';
import '../../utils/text_utl.dart';

class Editinquiry extends StatefulWidget {
  const Editinquiry({super.key});

  @override
  State<Editinquiry> createState() => _EditinquiryState();
}

class _EditinquiryState extends State<Editinquiry> {
  final controller = Get.put(EditinquiryController());
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
              "Service",
              "Enter Service Name",
              controller.isService,
              controller.txtService,
              controller.fnService,
            ),
            const SizedBox(height: 15),
            setTextField1(
              context,
              "Service For",
              "Enter Service For",
              controller.isServiceFor,
              controller.txtServiceFor,
              controller.fnServiceFor,
            ),
            const SizedBox(height: 15),
            setTextField1(
              context,
              "Type",
              "Enter Type",
              controller.isType,
              controller.txtType,
              controller.fnType,
            ),
            const SizedBox(height: 15),
            setTextField1(
              context,
              "Name",
              "Enter Name",
              controller.isName,
              controller.txtName,
              controller.fnName,
            ),
            const SizedBox(height: 15),
            setTextField1(
              context,
              "Unit Number",
              "Enter Unit No",
              controller.isUnitNumber,
              controller.txtUnitNumber,
              controller.fnUnitNumber,
            ),
            const SizedBox(height: 15),
            setTextField1(
              context,
              "Address",
              "Enter Address",
              controller.isAddress,
              controller.txtAddress,
              controller.fnAddress,
            ),
            const SizedBox(height: 15),
            setTextField1(
              context,
              "Remark",
              "Enter Remark",
              controller.isRemark,
              controller.txtRemark,
              controller.fnRemark,
            ),
            const SizedBox(height: 15),
            setTextField1(
              context,
              "Estimate Time",
              "Enter Estimate Time",
              controller.isEstTime,
              controller.txtEstTime,
              controller.fnEstTime,
            ),
            const SizedBox(height: 15),
            setTextField1(
              context,
              "Estimate Price",
              "Enter Estimate Price",
              controller.isEstPrice,
              controller.txtEstPrice,
              controller.fnEstPrice,
            ),
            const SizedBox(height: 15),
            setTextField1(
              context,
              "Vendor Name",
              "Enter Vendor Name",
              controller.isVendorName,
              controller.txtVendorName,
              controller.fnVendorName,
            ),

            const SizedBox(height: 15),
            setTextField1(
              context,
              "Vendor Email",
              "Enter Vendor Email Name",
              controller.isVendorEmail,
              controller.txtVendorEmail,
              controller.fnVendorEmail,
            ),

            const SizedBox(height: 15),
            setTextField1(
              context,
              "Vendor Mobile",
              "Enter Vendor Mobile",
              controller.isVendorMobile,
              controller.txtVendorMobile,
              controller.fnVendorMobile,
            ),
            const SizedBox(height: 15),
            setTextField1(
              context,
              "Vendor Address",
              "Enter Vendor Address",
              controller.isVendorAddress,
              controller.txtVendorAddress,
              controller.fnVendorAddress,
            ),
             const SizedBox(height: 20),
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
