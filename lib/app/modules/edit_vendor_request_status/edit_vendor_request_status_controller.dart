import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../vendor_request_status_edit/VendorStatusInfo.dart';
import 'VendorEditStatusInfo.dart';

class EditVendorRequestStatusController extends GetxController{
  Rxn<VendorEditStatusInfo> vendorStatusInfo = Rxn<VendorEditStatusInfo>();
  late String vendorStatusId;

  // TextEditingControllers and FocusNodes for each field
  final txtService = TextEditingController();
  final fnService = FocusNode();
  final isService = GlobalKey();

  final txtServiceFor = TextEditingController();
  final fnServiceFor = FocusNode();
  final isServiceFor = GlobalKey();

  final txtName = TextEditingController();
  final fnName = FocusNode();
  final isName = GlobalKey();

  final txtUnitNumber = TextEditingController();
  final fnUnitNumber = FocusNode();
  final isUnitNumber = GlobalKey();

  final txtDriverNumber = TextEditingController();
  final fnDriverNumber = FocusNode();
  final isDriverNumber = GlobalKey();

  final txtAddress = TextEditingController();
  final fnAddress = FocusNode();
  final isAddress = GlobalKey();

  final txtRemark = TextEditingController();
  final fnRemark = FocusNode();
  final isRemark = GlobalKey();

  final txtEstTime = TextEditingController();
  final fnEstTime = FocusNode();
  final isEstTime = GlobalKey();

  final txtEstPrice = TextEditingController();
  final fnEstPrice = FocusNode();
  final isEstPrice = GlobalKey();

  final txtVendorName = TextEditingController();
  final fnVendorName = FocusNode();
  final isVendorName = GlobalKey();

  final txtVendorEmail = TextEditingController();
  final fnVendorEmail = FocusNode();
  final isVendorEmail = GlobalKey();

  final txtVendorMobile = TextEditingController();
  final fnVendorMobile = FocusNode();
  final isVendorMobile = GlobalKey();

  final txtVendorAddress = TextEditingController();
  final fnVendorAddress = FocusNode();
  final isVendorAddress = GlobalKey();

  final txtReason = TextEditingController();
  final fnReason = FocusNode();
  final isReason = GlobalKey();

  final txtStatus = TextEditingController();
  final fnStatus = FocusNode();
  final isStatus = GlobalKey();

  // Make status observable
  //final statusRx = ''.obs;

  final statusRx = 'Open'.obs; // Default value

  // Remove listener approach for simplicity
  void updateStatus(String newStatus) {
    statusRx.value = newStatus;
  }

  EditVendorRequestStatusController() {
    txtStatus.addListener(() {
      statusRx.value = txtStatus.text;
    });
  }


  @override
  void onInit() {
    super.onInit();
    vendorStatusId = Get.arguments ?? 'No ID Provided';
    print("VendorStatusEditController initialized with ID: $vendorStatusId");

    editVendorStatus();
  }

  Future<void> editVendorStatus() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
      'POST',
      Uri.parse(
          'https://roadservice.roadservicerepair.com/api/edit_request_status.php'),
    );

    request.body = json.encode({"id": vendorStatusId});
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        var data = json.decode(responseBody);
        print(data);

        if (data['status'] == 1) {
          vendorStatusInfo.value = VendorEditStatusInfo.fromJson(data['info']);
          populateFields();
        } else {
          print('Failed to load data');
        }
      } else {
        print('HTTP Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void populateFields() {
    if (vendorStatusInfo.value != null) {
      final info = vendorStatusInfo.value!;
      txtService.text = info.service;
      txtServiceFor.text = info.serviceFor;
      txtName.text = info.name;
      txtUnitNumber.text = info.unitNumber;
      txtDriverNumber.text = info.driverNumber;
      txtAddress.text = info.address;
      txtRemark.text = info.remark;
      txtEstTime.text = info.estTime;
      txtEstPrice.text = info.estPrice;
      txtVendorName.text = info.vendorName;
      txtVendorEmail.text = info.vendorEmail;
      txtVendorMobile.text = info.vendorMobile;
      txtVendorAddress.text = info.vendorAddress;
      txtReason.text = info.reason;
      if (info.status != null && info.status.isNotEmpty) {
        txtStatus.text = info.status;
      } else if (info.rname != null && info.rname.isNotEmpty) {
        txtStatus.text = info.rname;
      }
    }
  }


  Future<bool> updateVendorStatus() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
      'POST',
      Uri.parse('https://roadservice.roadservicerepair.com/api/update_request_status.php'),
    );

    // Collecting form data
    request.body = json.encode({
      "id": vendorStatusId,
      "service": txtService.text,
      "service_for": txtServiceFor.text,
      "name": txtName.text,
      "unit_number": txtUnitNumber.text,
      "driver_number": txtDriverNumber.text,
      "address": txtAddress.text,
      "remark": txtRemark.text,
      "est_time": txtEstTime.text,
      "est_price": txtEstPrice.text,
      "vendor_name": txtVendorName.text,
      "vendor_email": txtVendorEmail.text,
      "vendor_mobile": txtVendorMobile.text,
      "vendor_address": txtVendorAddress.text,
      "sta_tus": txtStatus.text,
      "reason": txtReason.text,
    });

    request.headers.addAll(headers);
    print("krunal "+request.body);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        var data = json.decode(responseBody);
        print(data);

        if (data['status'] == 1) {
          return true;  // Success
        } else {
          print('Update failed: ${data['msg']}');
          return false; // Failure
        }
      } else {
        print('HTTP Error: ${response.reasonPhrase}');
        return false;
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }


  void clearForm() {
    txtService.clear();
    txtServiceFor.clear();
    txtName.clear();
    txtUnitNumber.clear();
    txtDriverNumber.clear();
    txtAddress.clear();
    txtRemark.clear();
    txtEstTime.clear();
    txtEstPrice.clear();
    txtVendorName.clear();
    txtVendorEmail.clear();
    txtVendorMobile.clear();
    txtVendorAddress.clear();
    txtReason.clear();
    txtStatus.clear();
  }

}