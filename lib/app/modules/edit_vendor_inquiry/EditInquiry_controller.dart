import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/CityData.dart';
import '../../../model/Country.dart';
import '../../../model/StateData.dart';
import '../../constants/Api.dart';
import '../../utils/shake_widget.dart';
import 'package:http/http.dart' as http;

class EditinquiryController extends GetxController{
  dynamic data = Get.arguments;
   late SharedPreferences prefs;

  RxString pageTitle = "".obs;
  String towing_for ="";

  String truck_tire_type ="";
  String selectedCountryId ="";
  String selectedStateId ="";
  String selectedCityId ="";

  Rx<File?> imagePath = Rx<File?>(null);

  RxBool isLoading = false.obs;
  RxInt status = 0.obs;
  RxString imageurl = ''.obs;

  List<String> arrServices = [
    "Truck Repair",
    "Trailer Repair",
    "Truck Tire",
    "Trailer Tire",
    "Towing"
  ];
  List<String> arrTypeOfTire = ["Steer", "Driver"];
  List<String> arrTowingSrv = ["Truck", "Trailer", "Both"];

  List<Info> arrCountry = [];
  List<StateInfo> arrState = [];
  List<CityInfo> arrCity = [];

  //Shake Key

  final isId = GlobalKey<ShakeWidgetState>();
  final isService = GlobalKey<ShakeWidgetState>();
  final isServiceFor = GlobalKey<ShakeWidgetState>();
  final isType = GlobalKey<ShakeWidgetState>();
  final isName = GlobalKey<ShakeWidgetState>();
  final isUnitNumber = GlobalKey<ShakeWidgetState>();
  final isDriverNumber = GlobalKey<ShakeWidgetState>();
  final isAddress = GlobalKey<ShakeWidgetState>();
  final isRemark = GlobalKey<ShakeWidgetState>();
  final isEstTime = GlobalKey<ShakeWidgetState>();
  final isEstPrice = GlobalKey<ShakeWidgetState>();
  final isVendorName = GlobalKey<ShakeWidgetState>();
  final isVendorEmail = GlobalKey<ShakeWidgetState>();
  final isVendorMobile = GlobalKey<ShakeWidgetState>();
  final isVendorAddress = GlobalKey<ShakeWidgetState>();


  //Controller

  TextEditingController txtId = TextEditingController();
  TextEditingController txtService = TextEditingController();
  TextEditingController txtServiceFor = TextEditingController();
  TextEditingController txtType = TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtUnitNumber = TextEditingController();
  TextEditingController txtDriverNumber = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtRemark = TextEditingController();
  TextEditingController txtEstTime = TextEditingController();
  TextEditingController txtEstPrice = TextEditingController();
  TextEditingController txtVendorName = TextEditingController();
  TextEditingController txtVendorEmail = TextEditingController();
  TextEditingController txtVendorMobile = TextEditingController();
  TextEditingController txtVendorAddress = TextEditingController();


  //FocusNode

  FocusNode fnId = FocusNode();
  FocusNode fnService = FocusNode();
  FocusNode fnServiceFor = FocusNode();
  FocusNode fnType = FocusNode();
  FocusNode fnName = FocusNode();
  FocusNode fnUnitNumber = FocusNode();
  FocusNode fnDriverNumber = FocusNode();
  FocusNode fnAddress = FocusNode();
  FocusNode fnRemark = FocusNode();
  FocusNode fnEstTime = FocusNode();
  FocusNode fnEstPrice = FocusNode();
  FocusNode fnVendorName = FocusNode();
  FocusNode fnVendorEmail = FocusNode();
  FocusNode fnVendorMobile = FocusNode();
  FocusNode fnVendorAddress = FocusNode();




  //Operations
  RxString selectedService = ''.obs;


  InfoList(){
     print(data);

     status.value = int.parse(data['sta_tus']);
     imageurl.value = data['image'];

     print(status.toString() + imageurl.toString());

     txtService.text = data['service'];
     txtServiceFor.text = data['service_for'];
     txtType.text = data['type'];
     txtName.text = data['name'];
     txtUnitNumber.text = data['unit_number'];
     txtDriverNumber.text = data['driver_number'];
     txtAddress.text = data['address'];
     // txtRemark.text = data['remark'];
     // txtEstTime.text = data['est_time'];
     // txtEstPrice.text = data['est_price'];
     // txtVendorName.text = data['vendor_name'];
     // txtVendorEmail.text = data['vendor_email'];
     // txtVendorMobile.text = data['vendor_mobile'];
     // txtVendorAddress.text = data['vendor_address'];



  }
  getList() async {
    prefs = await SharedPreferences.getInstance();
    //txtEmail.text =prefs.getString("email")!;
    //txtAdrs.text =prefs.getString("address")!;

    //txtMobile.text=prefs.getString("mobile_no")!;
    txtName.text=prefs.getString("name")!;


  }

  @override
  void onInit() {
    pageTitle.value = "Edit Inquiry";
    print("edit_inquiry");
    InfoList();
    getList();






    super.onInit();
  }


  onServiceSelect(String? value) {
    selectedService.value = value ?? '';

  }

  // bool validateInputs() {
  //   bool isValid = true;
  //
  //   if (selectedService.value.isEmpty) {
  //     isServices.currentState?.shake();
  //     isValid = false;
  //   }
  //
  //   if (txtMobile.text.isEmpty) {
  //     isMobile.currentState?.shake();
  //     isValid = false;
  //   }
  //   if (txtEmail.text.isEmpty) {
  //     isEmail.currentState?.shake();
  //     isValid = false;
  //   }
  //
  //   if (txtAdrs.text.isEmpty) {
  //     isAdrs.currentState?.shake();
  //     isValid = false;
  //   }
  //
  //   if (txtReqInfo.text.isEmpty) {
  //     isReqInfo.currentState?.shake();
  //     isValid = false;
  //   }
  //
  //   return isValid;
  // }

  Future<void> sendNow(BuildContext context) async {


    try {
      final response = await http.post(
        Uri.parse(Api.VENDOR_UPDATE_INQUIRY),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'id': data['id'].toString(),
          'service': data['service'].toString(),
          'service_for': data['service_for'].toString(),
          'type': data['type'].toString(),
          'name': data['name'].toString(),
          'unit_number': data['unit_number'].toString(),
          'driver_number': data['driver_number'].toString(),
          'address': data['address'].toString(),
          'remark': data['remark'].toString(),
          'est_time': data['est_time'].toString(),
          'est_price': data['est_price'].toString(),
          'vendor_name': data['vendor_name'].toString(),
          'vendor_email': data['vendor_email'].toString(),
          'vendor_mobile': data['vendor_mobile'].toString(),
          'vendor_address': data['vendor_address'].toString(),
          'status': "2",
          'sta_tus':"1",

        }),
      );



      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] != null && jsonResponse['status'] == 1){

               print(jsonResponse);
        Get.back(result: true);

        Get.snackbar("Success", jsonResponse["msg"],
            snackPosition: SnackPosition.BOTTOM);}
        else{
          Get.snackbar("Error", jsonResponse['msg'],
              snackPosition: SnackPosition.BOTTOM);
        }

        }

       else {
        Get.snackbar("Error", "Failed to send request",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar("Error", "An error occurred",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }

    // print({
    //   'service': data['service'].toString(),
    //   'tire_type': data['truck_tire_type'].toString() ,
    //   'tire_size':data['tire_size'].toString()  ,
    //   'towing_for':data['towing_for'].toString()  ,
    //   'cust_mobileno': data['mobile_no'].toString() ,
    //   'email': data['email'].toString() ,
    //   'country': data['cid'].toString() ,
    //   'state': data['sid'].toString() ,
    //   'city':data['c_id'].toString()  ,
    //   'address': prefs.getString("address") ,
    //   'remark': data['remark'].toString() ,
    //   'cust_address': data['address'].toString(),
    //   'est_time': txtest_time.text.toString(),
    //   'est_price': txtest_price.text.toString(),
    //   'vendor_name': prefs.getString("name"),
    //   'vendor_email': prefs.getString("email"),
    //   'vendor_mobile': prefs.getString("mobile_no"),
    //   'status': "2",
    //   'est_time': txtest_time.text.toString(),
    //   'est_price': txtest_price.text.toString(),
    //   'id': data['id'].toString(),
    //   'sta_tus':"1",
    // 'truck_make':data['truck_make'].toString()  ,
    // 'make_other':data['make_other'].toString(),
    // 'vi_number': data['vi_number'].toString() ,
    // });
  }



}