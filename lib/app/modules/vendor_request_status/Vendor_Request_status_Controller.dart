import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../constants/Api.dart';

class VendorRequestStatusController extends GetxController{

  RxList arr = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchVendor();
  }


  Future<void> fetchVendor() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email =prefs.getString('email');

    try {
      final response = await http.post(Uri.parse(Api.VENDOR_REQUEST_STATUS_CONTROLLER),
          headers: {
            'Content-Type': 'application/json',
          },

          body: jsonEncode({

            'vendor_email': email
          })
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 1) {
          final info = data['info'];
          if (info is Map) {
            arr.assignAll([info]); // Wrap in a list if it's a single object
          } else if (info is List) {
            arr.assignAll(info); // Directly assign if it's already a list
          }
        }
      } else {
      //  Get.snackbar('Error', 'Failed to load customers');
      }
    } catch (e) {
     // Get.snackbar('Error', 'Failed to load customers');
    }
  }

}