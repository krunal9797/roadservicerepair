import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roadservicerepair/app/constants/app_colors.dart';
import 'package:roadservicerepair/app/modules/side_bar/side_bar_view.dart';
import 'package:roadservicerepair/app/modules/vendor_request_status_edit/vendor_request_status_edit_controller.dart';
import 'package:roadservicerepair/app/modules/vendor_status/vendor_status_view.dart';
import 'package:roadservicerepair/app/utils/text_field_utl.dart';
import 'package:roadservicerepair/app/utils/text_utl.dart';

class VendorRequestStatusEditView extends StatelessWidget {
  const VendorRequestStatusEditView({super.key});


  @override
  Widget build(BuildContext context) {
    final VendorStatusEditController controller = Get.put(VendorStatusEditController());
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.whiteText,
        surfaceTintColor: AppColors.whiteText,
        title: setSemiText(
                   "Vendor Status Edit",
              AppColors.titleText,
              16),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.vendorStatusInfo.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final info = controller.vendorStatusInfo.value!;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              setTextField1(
                context,
                "Service",
                "Enter Service",
                controller.isService,
                controller.txtService,
                controller.fnService,
              ),
              setTextField1(
                context,
                "Service For",
                "Enter Service For",
                controller.isServiceFor,
                controller.txtServiceFor,
                controller.fnServiceFor,
              ),
              setTextField1(
                context,
                "Name",
                "Enter Name",
                controller.isName,
                controller.txtName,
                controller.fnName,
              ),
              setTextField1(
                context,
                "Email",
                "Enter Email",
                controller.isEmail,
                controller.txtEmail,
                controller.fnEmail,
              ),
              setTextField1(
                context,
                "Drive Number",
                "Enter Driver Number",
                controller.isDriverNumber,
                controller.txtDriverNumber,
                controller.fnDriverNumber,
              ),
              setTextField1(
                context,
                "Unit Number",
                "Enter Unit Number",
                controller.isUnitNumber,
                controller.txtUnitNumber,
                controller.fnUnitNumber,
              ),
              // setTextField1(
              //   context,
              //   "Driver Number",
              //   "Enter Driver Number",
              //   controller.isDriverNumber,
              //   controller.txtDriverNumber,
              //   controller.fnDriverNumber,
              // ),
              setTextField1(
                context,
                "Address",
                "Enter Address",
                controller.isAddress,
                controller.txtAddress,
                controller.fnAddress,
              ),
              setTextField1(
                context,
                "Remark",
                "Enter Remark",
                controller.isRemark,
                controller.txtRemark,
                controller.fnRemark,
              ),
              setTextField(
                context,
                "Estimated Time",
                "Enter Estimated Time",
                controller.isEstTime,
                controller.txtEstTime,
                controller.fnEstTime,
              ),
              setTextField(
                context,
                "Estimated Price",
                "Enter Estimated Price",
                controller.isEstPrice,
                controller.txtEstPrice,
                controller.fnEstPrice,
              ),
              setTextField1(
                context,
                "Vendor Name",
                "Enter Vendor Name",
                controller.isVendorName,
                controller.txtVendorName,
                controller.fnVendorName,
              ),
              setTextField1(
                context,
                "Vendor Email",
                "Enter Vendor Email",
                controller.isVendorEmail,
                controller.txtVendorEmail,
                controller.fnVendorEmail,
              ),
              setTextField1(
                context,
                "Vendor Mobile",
                "Enter Vendor Mobile",
                controller.isVendorMobile,
                controller.txtVendorMobile,
                controller.fnVendorMobile,
              ),
              setTextField1(
                context,
                "Vendor Address",
                "Enter Vendor Address",
                controller.isVendorAddress,
                controller.txtVendorAddress,
                controller.fnVendorAddress,
              ),
              // Custom Status Field with Dialog
              GestureDetector(
                onTap: () => _showStatusDialog(context, controller),
                child: AbsorbPointer(
                  child: setTextField(
                    context,
                    "Status",
                    "Enter Status",
                    controller.isStatus,
                    controller.txtStatus,
                    controller.fnStatus,
                  ),
                ),
              ),

              // Conditionally Show Reason Field

              Obx(() {
                if (controller.statusRx.value == "Not Complete") {
                  return setTextField(
                    context,
                    "Reason",
                    "Enter Reason",
                    controller.isReason,
                    controller.txtReason,
                    controller.fnReason,
                  );
                } else {
                  return const SizedBox.shrink();  // Hide when not "Not Complete"
                }
              }),

              // Submit Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  onPressed: () => _submitForm(controller),
                  child: const Text("Submit"),
                ),
              ),
            ],
          ),
        );
      }),
    );

  }
}

// Status Selection Dialog
void _showStatusDialog(BuildContext context, VendorStatusEditController controller) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Select Status"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("Open"),
              onTap: () {
                controller.txtStatus.text = "Open";
                controller.txtReason.clear();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text("Close"),
              onTap: () {
                controller.txtStatus.text = "Close";
                controller.txtReason.clear();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text("Not Complete"),
              onTap: () {
                controller.txtStatus.text = "Not Complete";
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}
// Submit Form Logic
Future<void> _submitForm(VendorStatusEditController controller) async {
  bool isSuccess = await controller.updateVendorStatus();
  print("krunal "+isSuccess.toString());
  if (isSuccess) {
    Get.snackbar(
      "Success",
      "Update Vendor Status Details Successful!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    Get.to(()=>const SideBarView());
    // Get.off(() => const SideBarView()); // Navigate to HomeView if logged in
  } else {
    Get.snackbar(
      "Error",
      "Failed to update vendor status. Please try again.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    Get.to(()=>const SideBarView());
    // Get.off(() => const SideBarView()); // Navigate to HomeView if logged in
  }
}

