import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/Api.dart';
class Customer_Request_Status_Controller extends  GetxController{

  RxList arr = [].obs;




  @override
  void onInit() {
    super.onInit();
    fetchCustomers();
  }


  Future<void> fetchCustomers() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email =prefs.getString('email');

    try {
      final response = await http.post(Uri.parse(Api.CUST_REQUEST_STATUS_CONTROLLER),

      body: jsonEncode({

        'email': email
      })
      );
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





}