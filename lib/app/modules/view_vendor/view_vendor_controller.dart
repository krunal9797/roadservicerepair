import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../constants/Api.dart';

class VendorsController extends GetxController {
  RxList arr = [].obs;
  void onInit() {
    super.onInit();
    fetchVendor();
  }

  Future<void> fetchVendor() async {
    try {
      final response = await http.get(Uri.parse(Api.VENDORLIST));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> list = data['info'];
        print(list);
        arr.assignAll(list);
      } else {
        Get.snackbar('Error', 'Failed to load customers');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load customers');
    }
  }

  Future<void> deleteItem( String id) async{
    try {
      final response = await http.post(
        Uri.parse(Api.DELETE_VENDOR),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'u_id': id,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] != null && jsonResponse['status'] == 1) {
          print(jsonResponse);
          fetchVendor();
          Get.snackbar("Success", jsonResponse['info']);

        } else {
          // Handle error response
          Get.snackbar("Error", jsonResponse['info']);
        }
      } else {
        Get.snackbar("Error", "Server error: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", "An error occurred");
    }


  }
  }