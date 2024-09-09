import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:roadservicerepair/app/modules/edit_vendor_inquiry/EditInquiry.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/Api.dart';

class ViewvendorInquiryController extends GetxController{
 // RxInt expandedIndex = (0).obs;  // -1 means no panel is expanded

  RxList arr = [].obs;

  var expandedIndex = RxInt(0);


  void onInit() {
    super.onInit();
    print("ViewvendorInquiryController");
    fetchVendorInquiry();
  }


  void updateExpandedIndex(int index) {
    expandedIndex.value = expandedIndex.value == index ? -1 : index;
  }



  Future<void> fetchVendorInquiry() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email =prefs.getString('email');
    String? c_id =prefs.getString('c_id');
    print(email!+c_id!);

    try {
      final response = await http.post(Uri.parse(Api.SHOWINQUIRY),
          headers: {
            'Content-Type': 'application/json',
          },

          body: jsonEncode({

            'email': email,
            'city': c_id,
          })
      );

      print(c_id);
      print(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> list = data['info'];
        arr.assignAll(list);
      } else {
        Get.snackbar('Error', 'Failed to load vendor Inquiry');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'Failed to load vendor Inquiry');
    }
  }


  editInquiry(String? id ) async{
    if (id == null) {
      Get.snackbar("Error", "ID cannot be null");
      return;
    }


    print( "pass"+id!);
    try{
      final response =await http.post(Uri.parse(Api.EDITINQUIRY),
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


          print("RES_editInquiry "+list.toString());

          // Parse the response and navigate to the next screen
          Get.to(() => const Editinquiry(),arguments: list)?.then((value) {
            if (value == true) {
              fetchVendorInquiry();
            }
          });

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





}