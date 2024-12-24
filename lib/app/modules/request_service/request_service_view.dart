

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roadservicerepair/app/constants/app_colors.dart';
import 'package:roadservicerepair/app/modules/request_service/request_service_controller.dart';
import 'package:roadservicerepair/app/utils/button_utl.dart';
import 'package:roadservicerepair/app/utils/drop_down_utl.dart';
import 'package:roadservicerepair/app/utils/text_field_utl.dart';
import 'package:roadservicerepair/app/utils/text_utl.dart';
import 'package:roadservicerepair/model/CityData.dart';

import '../../../model/Country.dart';
import '../../../model/StateData.dart';

class ReqServiceView extends StatefulWidget {
  const ReqServiceView({Key? key}) : super(key: key);

  @override
  State<ReqServiceView> createState() => _ReqServiceViewState();
}

class _ReqServiceViewState extends State<ReqServiceView> {
  final controller = Get.put(ReqServiceController());

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
                controller.txtServiceFor.clear();
              },
            ),
            const SizedBox(height: 15),
            // Conditional Second Dropdown (Make or Model)
            Obx(() {
              if (controller.selectedService.value == 'Truck') {
                // Dropdown for 'Truck'
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
              } else if (controller.selectedService.value == 'Tires') {
                // Textbox for 'Tires'
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: setTextField(
                    context,
                    "Enter Tire Size",
                    "Enter Tire Size",
                    controller.isServiceFor,
                    controller.txtServiceFor,
                    controller.fnServiceFor,
                  ),
                );
              } else {
                // Reset and hide the second input if no valid selection
                controller.selectedService.value = "";
                return SizedBox.shrink();
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
            ),
            const SizedBox(height: 15),
            setTextField(
              context,
              "Unit Number",
              "Enter Unit Number",
              controller.isUnitNo,
              controller.txtUnitNo,
              controller.fnUnitNo,
            ),
            const SizedBox(height: 15),
            setTextField(
              context,
              "Driver Number",
              "Enter Driver Number",
              controller.isDriverNo,
              controller.txtDriverNo,
              controller.fnDriverNo,
            ),

            const SizedBox(height: 15),
            setTextField(
              context,
              "Remark",
              "Enter Remark",
              controller.isRemark,
              controller.txtRemark,
              controller.fnRemark,
            ),
            const SizedBox(height: 15),
            Stack(
              children: [
                // Address Input Field
                setTextFormField(context, "Address / Share Live Location", "Enter Adress/ share live location", controller.isAddress,
                    controller.txtAddress, controller.fnAddress),
                // Location Icon Button
                Positioned(
                  right: 0, // Align to the right
                  top: 0, // Align to the top of the field
                  bottom: 0, // Align to the bottom of the field
                  child: GestureDetector(
                    onTap: () {
                      controller.fetchCurrentLocation(controller.txtAddress);
                    },
                    child: Image.asset(
                      'assets/images/progess.gif',
                      width: 100, // Set the width of the GIF
                      height: 100, // Set the height of the GIF
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
            Center(
              child: InkWell(
                onTap: () {
                  print('click');
                  controller.showImagePickerOption(context);
                },
                child: Obx(
                      () => controller.imagePath.value == null
                      ? Image.asset(
                    'assets/images/add.jpg',
                    width: 150,
                    height: 100,
                  )
                      : Image.file(
                    controller.imagePath.value as File ,
                    width: 150,
                    height: 100,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Obx(() {
                return controller.isLoading.value
                    ? CircularProgressIndicator()
                    : setButton(
                      () => controller.sendNow(context),
                  setSemiText("Send Now", AppColors.whiteText, 16),
                  AppColors.button,
                  200,
                  50,
                );
              }),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void _openServiceDialog(BuildContext context, ReqServiceController controller) {
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

  void _openServiceDialogDepend(BuildContext context, ReqServiceController controller, String selectedService) {
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
