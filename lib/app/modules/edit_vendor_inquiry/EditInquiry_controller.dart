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
  final isTruck_make = GlobalKey<ShakeWidgetState>();
  final isMake_other = GlobalKey<ShakeWidgetState>();
  final isvi_number = GlobalKey<ShakeWidgetState>();
  final isServices = GlobalKey<ShakeWidgetState>();
  final isTypeOfTire = GlobalKey<ShakeWidgetState>();
  final isTruckTire = GlobalKey<ShakeWidgetState>();
  final isTire_type = GlobalKey<ShakeWidgetState>();
  final isTire_size = GlobalKey<ShakeWidgetState>();
  final isTrialerTire = GlobalKey<ShakeWidgetState>();


  final isCustomerName = GlobalKey<ShakeWidgetState>();
  final isCustomerEmail = GlobalKey<ShakeWidgetState>();
  final isCustomerNumber = GlobalKey<ShakeWidgetState>();

  final istowing_for = GlobalKey<ShakeWidgetState>();
  final iscountry_name = GlobalKey<ShakeWidgetState>();
  final isstate_name = GlobalKey<ShakeWidgetState>();
  final iscity_name = GlobalKey<ShakeWidgetState>();
  final iscust_mobileno = GlobalKey<ShakeWidgetState>();
  final iscust_address = GlobalKey<ShakeWidgetState>();
  final isremark = GlobalKey<ShakeWidgetState>();
  final isest_time = GlobalKey<ShakeWidgetState>();
  final isest_price = GlobalKey<ShakeWidgetState>();
  final isvendor_name = GlobalKey<ShakeWidgetState>();
  final isvendor_email = GlobalKey<ShakeWidgetState>();
  final isrname = GlobalKey<ShakeWidgetState>();







  final isTowingSrv = GlobalKey<ShakeWidgetState>();
  final isCountry = GlobalKey<ShakeWidgetState>();
  final isState = GlobalKey<ShakeWidgetState>();
  final isCity = GlobalKey<ShakeWidgetState>();
  final isName = GlobalKey<ShakeWidgetState>();

  final isMobile = GlobalKey<ShakeWidgetState>();
  final isEmail = GlobalKey<ShakeWidgetState>();
  final isAdrs = GlobalKey<ShakeWidgetState>();
  final isReqInfo = GlobalKey<ShakeWidgetState>();

  //Controller
  TextEditingController txtTruckTire = TextEditingController();
  TextEditingController txtTrialerTire = TextEditingController();
  TextEditingController txtTire_type = TextEditingController();

  TextEditingController txtTruck_make = TextEditingController();
  TextEditingController txtMake_other = TextEditingController();
  TextEditingController txtvi_number = TextEditingController();
  TextEditingController txtTire_size = TextEditingController();

  TextEditingController txtCustomerName = TextEditingController();
  TextEditingController txtCustomerEmail = TextEditingController();
  TextEditingController txtCustomerNumber = TextEditingController();

  TextEditingController txttowing_for = TextEditingController();
  TextEditingController txtcountry_name = TextEditingController();
  TextEditingController txtstate_name = TextEditingController();
  TextEditingController txtcity_name = TextEditingController();
  TextEditingController txtcust_mobileno = TextEditingController();
  TextEditingController txtcust_address = TextEditingController();
  TextEditingController txtremark = TextEditingController();
  TextEditingController txtest_time = TextEditingController();
  TextEditingController txtest_price = TextEditingController();
  TextEditingController txtvendor_name = TextEditingController();
  TextEditingController txtvendor_email = TextEditingController();
  TextEditingController txtrname = TextEditingController();







  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtAdrs = TextEditingController();
  TextEditingController txtReqInfo = TextEditingController();
  TextEditingController txtServices = TextEditingController();
  TextEditingController txtName = TextEditingController();

  //FocusNode
  FocusNode fnTruck_make = FocusNode();
  FocusNode fnMake_other = FocusNode();
  FocusNode fnTire_size = FocusNode();
  FocusNode fnTruckTire = FocusNode();
  FocusNode fnTire_type = FocusNode();
  FocusNode fnvi_number = FocusNode();
  FocusNode fnTrialerTire = FocusNode();

  FocusNode fnCustomerName = FocusNode();
  FocusNode fnCustomerEmail = FocusNode();
  FocusNode fnCustomerNumber = FocusNode();


  FocusNode fntowing_for = FocusNode();
  FocusNode fncountry_name = FocusNode();
  FocusNode fnstate_name = FocusNode();
  FocusNode fncity_name = FocusNode();
  FocusNode fncust_mobileno = FocusNode();
  FocusNode fncust_address = FocusNode();
  FocusNode fnremark = FocusNode();
  FocusNode fnest_time = FocusNode();
  FocusNode fnest_price = FocusNode();
  FocusNode fnvendor_name = FocusNode();
  FocusNode fnvendor_email = FocusNode();
  FocusNode fnrname= FocusNode();
  FocusNode fnName= FocusNode();







  FocusNode fnMobile = FocusNode();
  FocusNode fnEmail = FocusNode();
  FocusNode fnAdrs = FocusNode();
  FocusNode fnServices = FocusNode();
  FocusNode fnReqInfo = FocusNode();
  var isLoadingCountry = false.obs;
  var isLoadingState = false.obs;
  var isLoadingCity = false.obs;

  //Operations
  RxString selectedService = ''.obs;


  InfoList(){
     print(data);

     status.value = int.parse(data['sta_tus']);
     imageurl.value = data['image'];

     print(status.toString() + imageurl.toString());

    txtremark.text=data['remark'];
    txtServices.text=data['service'];
    txtTire_size.text=data['tire_size'];

    txttowing_for.text=data['towing_for'];

    txtcountry_name.text=data['country_name'];

 txtCustomerEmail.text=data['email'];
 txtCustomerNumber.text=data['mobile_no'];

    txtstate_name.text =data['state_name'];
    txtcity_name.text =data['city_name'];
    txtTruck_make.text = data['truck_make'];
    txtMake_other.text =data['make_other'];
    txtvi_number.text =data['vi_number'];



  }
  getList() async {
    prefs = await SharedPreferences.getInstance();
    txtEmail.text =prefs.getString("email")!;
    txtAdrs.text =prefs.getString("address")!;

    txtMobile.text=prefs.getString("mobile_no")!;
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

  bool validateInputs() {
    bool isValid = true;

    if (selectedService.value.isEmpty) {
      isServices.currentState?.shake();
      isValid = false;
    }

    if (txtMobile.text.isEmpty) {
      isMobile.currentState?.shake();
      isValid = false;
    }
    if (txtEmail.text.isEmpty) {
      isEmail.currentState?.shake();
      isValid = false;
    }

    if (txtAdrs.text.isEmpty) {
      isAdrs.currentState?.shake();
      isValid = false;
    }

    if (txtReqInfo.text.isEmpty) {
      isReqInfo.currentState?.shake();
      isValid = false;
    }

    return isValid;
  }

  Future<void> sendNow(BuildContext context) async {


    try {
      final response = await http.post(
        Uri.parse(Api.VENDOR_UPDATE_INQUIRY),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'service': data['service'].toString(),
          'tire_type': data['truck_tire_type'].toString() ,
          'tire_size':data['tire_size'].toString()  ,
          'towing_for':data['towing_for'].toString()  ,
          'cust_mobileno': data['mobile_no'].toString() ,
          'email': data['email'].toString() ,
          'country': data['cid'].toString() ,
          'state': data['sid'].toString() ,
          'city':data['c_id'].toString()  ,
          'address': prefs.getString("address") ,
          'remark': data['remark'].toString() ,
          'cust_address': data['address'].toString(),
          'est_time': txtest_time.text.toString(),
          'est_price': txtest_price.text.toString(),
          'vendor_name': prefs.getString("name"),
          'vendor_email': prefs.getString("email"),
          'vendor_mobile': prefs.getString("mobile_no"),
          'status': "2",
          'id': data['id'].toString(),
          'sta_tus':"1",
        'truck_make':data['truck_make'].toString()  ,
        'make_other':data['make_other'].toString(),
        'vi_number': data['vi_number'].toString() ,

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

    print({
      'service': data['service'].toString(),
      'tire_type': data['truck_tire_type'].toString() ,
      'tire_size':data['tire_size'].toString()  ,
      'towing_for':data['towing_for'].toString()  ,
      'cust_mobileno': data['mobile_no'].toString() ,
      'email': data['email'].toString() ,
      'country': data['cid'].toString() ,
      'state': data['sid'].toString() ,
      'city':data['c_id'].toString()  ,
      'address': prefs.getString("address") ,
      'remark': data['remark'].toString() ,
      'cust_address': data['address'].toString(),
      'est_time': txtest_time.text.toString(),
      'est_price': txtest_price.text.toString(),
      'vendor_name': prefs.getString("name"),
      'vendor_email': prefs.getString("email"),
      'vendor_mobile': prefs.getString("mobile_no"),
      'status': "2",
      'est_time': txtest_time.text.toString(),
      'est_price': txtest_price.text.toString(),
      'id': data['id'].toString(),
      'sta_tus':"1",
    'truck_make':data['truck_make'].toString()  ,
    'make_other':data['make_other'].toString(),
    'vi_number': data['vi_number'].toString() ,
    });
  }



}