import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../constants/Api.dart';
import '../../utils/global.dart';
import '../edit_inquiry/Edit_inquiryView.dart';

class VendorReqController extends GetxController {
  RxList arr = [].obs;

  void onInit() {
    super.onInit();
    print("kkcs "+IsRefresh.toString());

    fetchShowVendorRequest();

  }

  Future<void> fetchShowVendorRequest() async {
    try {
      final response = await http.get(Uri.parse(Api.SHOW_VEN_REQUEST));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> list = data['info'];

        print(data);
        arr.assignAll(list);
      } else {
    //    Get.snackbar('Error', 'Failed to Laod Vendor Request');
      }
    } catch (e) {
      print(e);
    //  Get.snackbar('Error', 'Failed to load Request');
    }
  }

  editInquiry(String? id ) async{

    print("editInquiry"+id!);
    if (id == null) {
      Get.snackbar("Error", "ID cannot be null");
      return;
    }


    print( "pass"+id!);
    try{
      final response =await http.post(Uri.parse(Api.EDIT_INQUIRY),
          headers: {
            'Content-Type': 'application/json',
          },

        body: jsonEncode({
          'id' : id

        }),
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print("inquiry"+response.body);
        if (jsonResponse['status'] != null && jsonResponse['status'] == 1) {
          final jsonResponse = jsonDecode(response.body);
           final list = jsonResponse['info'];

          print("inquiry list "+list.toString());

          // Parse the response and navigate to the next screen
          Get.to(() => const EditInquiryview(),arguments: list);

        } else {
          // Handle error response
          Get.snackbar("Error", jsonResponse['msg']);
        }
      } else {
        Get.snackbar("Error", "Server error: ${response.statusCode}");
      }





    }catch(e){


    }




  }
  Future<void> deleteItem( String id) async{
    print("deleteItem"+id);
    try {
      final response = await http.post(
        Uri.parse(Api.DELETE_VENDOR_INQUIRY),
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
          fetchShowVendorRequest();
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
