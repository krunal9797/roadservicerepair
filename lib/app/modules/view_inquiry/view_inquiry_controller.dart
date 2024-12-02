import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:roadservicerepair/app/modules/edit_inquiry/Edit_inquiryView.dart';

import '../../constants/Api.dart';

class ViewInquiryController extends GetxController {
  RxList arr = [].obs;



  void onInit() {
    super.onInit();
    print("ViewInquiryController");
    fetchViewInquiry();
  }

  Future<void> fetchViewInquiry() async {
    try {
      final response = await http.get(Uri.parse(Api.VIEWINQUIRY));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> list = data['info'];
        print(data);
        arr.assignAll(list);
      } else {
        Get.snackbar('Error', 'Failed to Laod Vendor Request');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load Request');
    }
  }
  Future<void> deleteItem( String id) async{
    try {
      final response = await http.post(
        Uri.parse(Api.DELETE_VIEWINQUIRY),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'id': id,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] != null && jsonResponse['status'] == 1) {
          print(jsonResponse);
          fetchViewInquiry();
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

  // Future<void> editInquiry(dynamic data) async{
  //
  //   print( "pass data"+data['id']);
  //   try{
  //     final response =await http.post(Uri.parse(Api.EDIT_INQUIRY),
  //       headers: {
  //       'Content-Type': 'application/json',
  //     },
  //       body: jsonEncode({
  //         "id": data['id'],
  //
  //
  //       }),
  //     );
  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> jsonResponse = jsonDecode(response.body);
  //       print("inquiry_response"+jsonResponse.toString());
  //       if (jsonResponse['status'] != null && jsonResponse['status'] == 1) {
  //         print("inquiry_response"+jsonResponse.toString());
  //
  //
  //
  //         // Parse the response and navigate to the next screen
  //         Get.off(() => const EditInquiryview());
  //       } else {
  //         // Handle error response
  //         Get.snackbar("Error", jsonResponse['msg']);
  //       }
  //     } else {
  //       Get.snackbar("Error", "Server error: ${response.statusCode}");
  //     }
  //
  //
  //
  //
  //
  //   }catch(e){
  //
  //
  //   }
  //
  //
  //
  //
  // }
}
