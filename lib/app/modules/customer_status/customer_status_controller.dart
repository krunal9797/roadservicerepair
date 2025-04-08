import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CustomerStatusController extends GetxController {
  var isLoading = false.obs;
  var customerInfo = [].obs;

  @override
  void onInit() {
    fetchCustomerStatus();
    super.onInit();
  }

  Future<void> fetchCustomerStatus() async {
    isLoading.value = true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');

    if (email == null) {
      isLoading.value = false;
      return;
    }

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
      'POST',
      Uri.parse('https://roadservice.roadservicerepair.com/api/customer_status.php'),
    );

    request.body = json.encode({"cust_email": email});
    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        var data = json.decode(responseBody);

        if (data["status"] == 1) {
          customerInfo.assignAll(data["info"]);
        }
      } else {
        print("Error: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
