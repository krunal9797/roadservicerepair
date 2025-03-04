import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:roadservicerepair/app/constants/Api.dart';
import 'package:http/http.dart' as http;
import 'package:roadservicerepair/app/modules/vendor_request_status_edit/vendor_request_status_edit_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VendorStatusController extends GetxController {
  RxList arr = [].obs;
  String userType ='';
  String userEmail = '';
  Timer? _refreshTimer;
  int count = 0;

  void onInit() async{
    super.onInit();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userType = prefs.getString('user_type')!;
    userEmail = prefs.getString('email')!;

    print("krunal count "+count.toString());
    print("krunal userType "+userType);
    print("drawer "+userType);
    if(userType == "0"){
      fetchViewVendorStatus();
    }else if(userType == "2"){
      fetchViewVendorStatus2();
    }

    print("ViewInquiryController");
    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      count = count + 1;
      print("krunal count "+count.toString());
      print("krunal count "+userType);
      if(userType == "0"){
        print("krunal count admin 0 "+userType);
        fetchViewVendorStatus();
      }else if(userType == "2"){
        print("krunal count vendor 1 "+userType);
        fetchViewVendorStatus2();
      }
    });

  }

  Future<void> fetchViewVendorStatus2() async{
    try {

      final response = await http.post(
          Uri.parse("https://roadservice.roadservicerepair.com/api/get_vendor_status.php"),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'vendor_email': userEmail,
          }),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> list = data['info'];
        print(data);
        arr.clear();
        arr.assignAll(list);
      } else {
        Get.snackbar('Error', 'Failed to Laod Vendor Request');
      }
    } catch (e) {
     // Get.snackbar('Error', 'Failed to load Request');
    }
  }

  Future<void> fetchViewVendorStatus() async{
    try {
      final response = await http.get(Uri.parse("https://roadservice.roadservicerepair.com/api/view_vendor_status.php"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> list = data['info'];
        print(data);
        arr.clear();
        arr.assignAll(list);
      } else {
        Get.snackbar('Error', 'Failed to Laod Vendor Request');
      }
    } catch (e) {
     // Get.snackbar('Error', 'Failed to load Request');
    }
  }

  Future<void> editVendorStatus(String id) async{
    print("krunal "+id);
    Get.to(() => const VendorRequestStatusEditView(), arguments: id);
  }

  Future<void> deleteVendorStatus(String id,) async {
    print("Deleting ID: $id");
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://roadservice.roadservicerepair.com/api/delete_vendor_status.php'));
    request.body = json.encode({"vs_id": id});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Vendor Status Deleted Successfully');
      await response.stream.bytesToString();
      await fetchViewVendorStatus();  // Refresh the list
    } else {
      Get.snackbar('Error', 'Failed to delete vendor status');
      print(response.reasonPhrase);
    }
  }

//    Get.to(() => const VendorRequestStatusEditView(), arguments: id);




}