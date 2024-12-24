import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
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


  final List<String> services = ['Truck', 'Trailer', 'Tires', 'Towing', 'Fuel Delivery'];
  final Map<String, List<String>> serviceDetails = {
    'Truck': ['Make',
      'Freightliner',
      'Volvo',
      'Kenworth',
      'Peterbilt',
      'International',
      'Dump truck',
      'Isuzu',
      'Others'],
  };

  // Reactive variables for selected service and detail
  RxString selectedService = "".obs;
  RxString selectedServiceDetail = "".obs;


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




  InfoList(){
     print(data);

     status.value = int.parse(data['sta_tus']);
     imageurl.value = data['image'];

     print(status.toString() + imageurl.toString());

     txtService.text = data['service'];
     txtServiceFor.text = data['service_for'];
     txtName.text = data['name'];
     txtUnitNumber.text = data['unit_number'];
     txtDriverNumber.text = data['driver_number'];
     txtAddress.text = data['address'];

     selectedService.value = txtService.text;

     txtRemark.text = data['remark'];
     // txtEstTime.text = data['est_time'];
     // txtEstPrice.text = data['est_price'];
     // txtVendorName.text = data['vendor_name'];
     // txtVendorEmail.text = data['vendor_email'];
     // txtVendorMobile.text = data['vendor_mobile'];
     // txtVendorAddress.text = data['vendor_address'];



  }
  getList() async {
    prefs = await SharedPreferences.getInstance();
    txtVendorEmail.text =prefs.getString("email")!;
    txtVendorAddress.text =prefs.getString("address")!;

    txtVendorMobile.text=prefs.getString("mobile_no")!;
    txtVendorName.text=prefs.getString("contact_person")!;



  }

  @override
  void onInit() {
    pageTitle.value = "Edit Inquiry";
    print("edit_inquiry");
    InfoList();
    getList();

    super.onInit();
  }


  Future<void> sendNow(BuildContext context) async {

    print("id "+data['id'].toString());
    print("service "+data['service'].toString());
    print("service_for "+data['service_for'].toString());
    print("name "+data['name'].toString());
    print("unit_number "+data['unit_number'].toString());
    print("driver_number "+data['driver_number'].toString());
    print("address "+data['address'].toString());
    print("remark "+txtRemark.text.toString());
    print("est_time "+txtEstTime.text.toString());
    print("est_price "+txtEstPrice.text.toString());
    print("vendor_name "+txtVendorName.text.toString());
    print("vendor_email "+txtVendorEmail.text.toString());
    print("vendor_address "+txtVendorAddress.text.toString());
    print("status "+status.toString());
    print("sta_tus "+data['sta_tus'].toString());

    try {
      final response = await http.post(
        Uri.parse(Api.VENDOR_UPDATE_INQUIRY),
        headers: {
          'Content-Type': 'application/json',
        },



        body: jsonEncode({
          'id': data['id'].toString(),
          'service': txtService.text.toString(),
          'service_for': txtServiceFor.text.toString(),
          'name': txtName.text.toString(),
          'unit_number': txtUnitNumber.text.toString(),
          'driver_number': txtDriverNumber.text.toString(),
          'address': txtAddress.text.toString(),
          'remark': txtRemark.text.toString(),
          'est_time': txtEstTime.text.toString(),
          'est_price': txtEstPrice.text.toString(),
          'vendor_name': txtVendorName.text.toString(),
          'vendor_email': txtVendorEmail.text.toString(),
          'vendor_mobile': txtVendorMobile.text.toString(),
          'vendor_address': txtVendorAddress.text.toString(),
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


  }


  Future<bool> requestLocationPermission() async {
    // Request location permission using permission_handler
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      // The permission was denied
      return false;
    } else if (status.isPermanentlyDenied) {
      // If the permission is permanently denied, open settings
      openAppSettings();
      return false;
    }
    return false;
  }

  Future<void> fetchCurrentLocation(TextEditingController controller) async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Show dialog to enable location services
      Get.defaultDialog(
        title: "Location Disabled",
        middleText: "Please enable location services to continue.",
        textConfirm: "Enable",
        onConfirm: () async {
          Get.back(); // Close the dialog
          await Geolocator.openLocationSettings();
        },
        textCancel: "Cancel",
      );
      return;
    }

    // Check and request location permissions
    bool permissionGranted = await requestLocationPermission();
    if (!permissionGranted) {
      // If location permission is not granted
      Get.snackbar(
        "Permission Denied",
        "Location permissions are required to fetch your current location.",
      );
      return;
    }

    // Show progress dialog while fetching location
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      // Fetch the current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Fetch the address from the latitude and longitude
      List<Placemark>? placemarks = await GeocodingPlatform.instance
          ?.placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks != null && placemarks.isNotEmpty) {
        // Process the address
        Placemark place = placemarks.first;
        String address = "${place.name}, ${place.street}, ${place.locality}, "
            "${place.administrativeArea}, ${place.postalCode}, ${place.country}";
        controller.text =
            address; // Update the text field with the full address
      } else {
        Get.snackbar("Error", "No address found for this location.");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch location: $e");
    } finally {
      // Close the progress dialog after fetching the location
      Get.back();
    }
  }



}