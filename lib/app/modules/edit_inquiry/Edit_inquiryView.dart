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
            // Text("kkk"),
            setTextFieldDrop(
              context,
              "Service",
              "Enter Service Name",
              controller.isService,
              controller.txtService,
              controller.fnService,
              enable: false,
              onTap: () {
                _openServiceDialog(context, controller);
              },
            ),
            const SizedBox(height: 15),
            // Conditional Second Dropdown (Make or Model)
            Obx(() {
              if (controller.selectedService.value == 'Truck') {
                return setTextFieldDrop(
                  context,
                  "Make Or Model",
                  "Enter Service For",
                  controller.isServiceFor,
                  controller.txtServiceFor,
                  controller.fnServiceFor,
                  enable: false,
                  onTap: () {
                    if (controller.selectedService.isNotEmpty) {
                      _openServiceDialogDepend(context, controller, controller.selectedService.value);
                    } else {
                      print('Please select a service first');
                    }
                  },
                );
              } else {
                controller.selectedService.value = "";
                return SizedBox.shrink(); // Hide the second dropdown if not 'Truck'
              }
            }),
            const SizedBox(height: 15),
            setTextField(
              context,
              "Name",
              "Enter Name",
              controller.isName,
              controller.txtName,
              controller.fnName,
                enable: false
            ),

            const SizedBox(height: 15),
            setTextField(
              context,
              "Unit Number",
              "Enter Unit Number",
              controller.isUnitNumber,
              controller.txtUnitNumber,
              controller.fnUnitNumber,
                enable: false
            ),

            const SizedBox(height: 15),
            setTextField(
              context,
              "Driver Number",
              "Enter Driver Number",
              controller.isDriverNumber,
              controller.txtDriverNumber,
              controller.fnDriverNumber,
                enable: false
            ),
            const SizedBox(height: 15),
            setTextField(
              context,
              "Your Location",
              "Enter your address",
              controller.isAddress,
              controller.txtAddress,
              controller.fnAddress,
                enable: false
            ),
            const SizedBox(height: 15),
            setTextField(
              context,
              "Remark",
              "Enter Remark",
              controller.isRemark,
              controller.txtRemark,
              controller.fnRemark,
                enable: false
            ),

            const SizedBox(height: 15),
            setTextField(
              context,
              "Estimate Time",
              "Enter Estimate Time",
              controller.isEstTime,
              controller.txtEstTime,
              controller.fnEstTime,
                enable: false
            ),

            const SizedBox(height: 15),
            setTextField(
              context,
              "Estimate Price",
              "Enter Price Time",
              controller.isEstPrice,
              controller.txtEstPrice,
              controller.fnEstPrice,
                enable: false
            ),
            const SizedBox(height: 15),
            setTextField(
              context,
              "Vendor Name",
              "Enter Vendor Name",
              controller.isVendorName,
              controller.txtVendorName,
              controller.fnVendorName,
                enable: false
            ),

            const SizedBox(height: 15),
            setTextField(
              context,
              "Vendor Email",
              "Enter Vendor Email",
              controller.isVendorEmail,
              controller.txtVendorEmail,
              controller.fnVendorEmail,
                enable: false
            ),
            const SizedBox(height: 15),
            setTextField(
              context,
              "Vendor Mobile",
              "Enter Vendor Mobile",
              controller.isVendorMobile,
              controller.txtVendorMobile,
              controller.fnVendorMobile,
                enable: false
            ),
            const SizedBox(height: 15),
            setTextField(
              context,
              "Vendor Address",
              "Enter Vendor Address",
              controller.isVendorAddress,
              controller.txtVendorAddress,
              controller.fnVendorAddress,
                enable: false
            ),


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

  // Dialog function to open when tapping the TextField
  void _openServiceDialog(BuildContext context, EditInquiryController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,  // Set the background color to white
          title: Text('Select Service'),
          content: SingleChildScrollView(
            child: Column(
              children: controller.services.map((service) {
                return ListTile(
                  title: Text(service),
                  onTap: () {
                    // Update the selected service in the controller and text field
                    controller.selectedService.value = service;
                    controller.txtService.text = service;
                    Get.back(); // Close the dialog
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  void _openServiceDialogDepend(BuildContext context, EditInquiryController controller, String selectedService) {
    // Get the dependent details for the selected service
    List<String> details = controller.serviceDetails[selectedService] ?? [];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Select Detail for $selectedService'),
          content: SingleChildScrollView(
            child: Column(
              children: details.map((detail) {
                return ListTile(
                  title: Text(detail),
                  onTap: () {
                    // Update the selected detail in the controller and text field
                    controller.selectedServiceDetail.value = detail;
                    controller.txtServiceFor.text = detail;
                    Get.back(); // Close the second dialog
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }


}
