import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../constants/Api.dart';

class VendorRequestStatusController extends GetxController{

  RxList arr = [].obs;
  String userType ='';

  @override
  void onInit() async{
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userType = prefs.getString('user_type')!;
    print("drawer "+userType);

    await fetchVendor();
  }


  Future<void> fetchVendor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');

    try {
      final response = await http.post(
        Uri.parse(Api.VENDOR_REQUEST_STATUS_CONTROLLER),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'vendor_email': email,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 1) {
          final info = data['info'];
          if (info is Map) {
            arr.assignAll([info]);
          } else if (info is List) {
            arr.assignAll(info);
          }
        }
      } else {
        print('Error: Failed to load customers. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


}