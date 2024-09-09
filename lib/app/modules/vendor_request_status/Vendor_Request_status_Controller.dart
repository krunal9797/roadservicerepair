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
        print(data);
        List<dynamic> list = data['info'];
        print(list);
        arr.assignAll(list);
      } else {
      //  Get.snackbar('Error', 'Failed to load customers');
      }
    } catch (e) {
     // Get.snackbar('Error', 'Failed to load customers');
    }
  }

}