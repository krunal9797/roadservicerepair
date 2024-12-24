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
            // Text("Edit Inquiry vendor"),
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
              "Enter Unit No",
              controller.isUnitNumber,
              controller.txtUnitNumber,
              controller.fnUnitNumber,
            ),
            const SizedBox(height: 15),
            setTextFormField(
              context,
              "Address",
              "Enter Address",
              controller.isAddress,
              controller.txtAddress,
              controller.fnAddress,
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
            setTextField(
              context,
              "Estimate Time",
              "Enter Estimate Time",
              controller.isEstTime,
              controller.txtEstTime,
              controller.fnEstTime,
            ),
            const SizedBox(height: 15),
            setTextField(
              context,
              "Estimate Price",
              "Enter Estimate Price",
              controller.isEstPrice,
              controller.txtEstPrice,
              controller.fnEstPrice,
            ),
            const SizedBox(height: 15),
            setTextField(
              context,
              "Vendor Name",
              "Enter Vendor Name",
              controller.isVendorName,
              controller.txtVendorName,
              controller.fnVendorName,
            ),

            const SizedBox(height: 15),
            setTextField(
              context,
              "Vendor Email",
              "Enter Vendor Email Name",
              controller.isVendorEmail,
              controller.txtVendorEmail,
              controller.fnVendorEmail,
            ),

            const SizedBox(height: 15),
            setTextField(
              context,
              "Vendor Mobile",
              "Enter Vendor Mobile",
              controller.isVendorMobile,
              controller.txtVendorMobile,
              controller.fnVendorMobile,
            ),
            const SizedBox(height: 15),
            Stack(
              children: [
                // Address Input Field
                setTextFormField(context, "Address", "Enter Vendor Address", controller.isVendorAddress,
                    controller.txtVendorAddress, controller.fnVendorAddress),
                // Location Icon Button
                Positioned(
                  right: 0, // Align to the right
                  top: 0, // Align to the top of the field
                  bottom: 0, // Align to the bottom of the field
                  child: GestureDetector(
                    onTap: () {
                      controller.fetchCurrentLocation(controller.txtVendorAddress);
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
// Dialog function to open when tapping the TextField
  void _openServiceDialog(BuildContext context, EditinquiryController controller) {
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

  void _openServiceDialogDepend(BuildContext context, EditinquiryController controller, String selectedService) {
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
