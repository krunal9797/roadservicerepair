import 'dart:convert';
import 'dart:io';
import 'dart:typed_data' as typed_data;

import 'dart:typed_data';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:roadservicerepair/app/utils/shake_widget.dart';
import 'package:http/http.dart' as http;

import '../../../model/CityData.dart';
import '../../../model/Country.dart';
import '../../../model/StateData.dart';
import '../../constants/Api.dart';

class ReqServiceController extends GetxController {
  dynamic data = Get.arguments;

  RxString pageTitle = "".obs;
  String towing_for ="";
  String truck_make="";

  String truck_tire_type ="";
 String selectedCountryId ="";
  String selectedStateId ="";
  String selectedCityId ="";

  Rx<File?> imagePath = Rx<File?>(null);

  RxBool isLoading = false.obs;


  List<String> arrServices = [
    "Truck Repair",
    "Trailer Repair",
    "Truck Tire",
    "Trailer Tire",
    "Towing"
  ];
  List<String> arrTypeOfTire = ["Steer", "Driver"];
  List<String> arrTowingSrv = ["Truck", "Trailer", "Both"];
  List<String> arrTruckMake = ["Freightliner ", "Volvo", "Kenworth","Peterbilt","International","Other"];


  List<Info> arrCountry = [];
  List<StateInfo> arrState = [];
  List<CityInfo> arrCity = [];

  //Shake Key
  final isVi = GlobalKey<ShakeWidgetState>();
  final isServices = GlobalKey<ShakeWidgetState>();
  final isTruckMake = GlobalKey<ShakeWidgetState>();
  final isOtherMake = GlobalKey<ShakeWidgetState>();

  final isTypeOfTire = GlobalKey<ShakeWidgetState>();
  final isTruckTire = GlobalKey<ShakeWidgetState>();
  final isTrialerTire = GlobalKey<ShakeWidgetState>();
  final isTowingSrv = GlobalKey<ShakeWidgetState>();
  final isCountry = GlobalKey<ShakeWidgetState>();
  final isState = GlobalKey<ShakeWidgetState>();
  final isCity = GlobalKey<ShakeWidgetState>();

  final isMobile = GlobalKey<ShakeWidgetState>();
  final isEmail = GlobalKey<ShakeWidgetState>();
  final isAdrs = GlobalKey<ShakeWidgetState>();
  final isReqInfo = GlobalKey<ShakeWidgetState>();

  //Controller
  TextEditingController txtTruckTire = TextEditingController();
  TextEditingController txtTrialerTire = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtAdrs = TextEditingController();
  TextEditingController txtReqInfo = TextEditingController();
  TextEditingController txtOtherMake = TextEditingController();
  TextEditingController txtVi = TextEditingController();

  //FocusNode
  FocusNode fnVi = FocusNode();
  FocusNode fnTruckTire = FocusNode();
  FocusNode fnOtherMake = FocusNode();
  FocusNode fnTrialerTire = FocusNode();
  FocusNode fnMobile = FocusNode();
  FocusNode fnEmail = FocusNode();
  FocusNode fnAdrs = FocusNode();
  FocusNode fnReqInfo = FocusNode();
  var isLoadingCountry = false.obs;
  var isLoadingState = false.obs;
  var isLoadingCity = false.obs;

  //Operations
  RxString selectedService = ''.obs;
  RxString selectedTruck = ''.obs;

  @override
  void onInit() {
    pageTitle.value = data;
    print("ReqServiceController");
   fetchCountries();

    super.onInit();
  }
   Future<void> fetchCountries() async{
     isLoadingCountry.value = true;
    final response = await http.get(Uri.parse(Api.COUNTRY));
    if(response.statusCode==200){
      Country countryData = Country.fromJson(json.decode(response.body));
      arrCountry = countryData.info ?? [];

    }
     isLoadingCountry.value = false;
  }

  Future<void> fetchStates(String countryId) async {
    isLoadingState.value = true;

    final response = await http.post(
      Uri.parse(Api.STATE),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'country_id': countryId,
      }),
    );
    if (response.statusCode == 200) {
      // Assuming you have a similar structure for State response as Country
      StateData stateData = StateData.fromJson(json.decode(response.body));

        arrState = stateData.info ?? [];

    } else {
      // Handle the error
      print('Failed to load states');
    }
    isLoadingState.value = false;

  }

  Future<void> fetchCities(String stateId) async {
    isLoadingCity.value = true;
    final response = await http.post(
      Uri.parse(Api.CITY),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'state_id': stateId,
      }),
    );
    if (response.statusCode == 200) {
      // Assuming you have a similar structure for State response as Country
      CityData cityData = CityData.fromJson(json.decode(response.body));

        arrCity = cityData.info ?? [];

    } else {
      // Handle the error
      print('Failed to load states');
    }
    isLoadingCity.value = false;

  }

  onServiceSelect(String? value) {
    print("service"+value!);
    selectedService.value = value ?? '';
    if (value != "Truck Repair") {
      selectedTruck.value = '';
    }

  }
  onTruckSelect(String? value) {
    print("service"+value!);
    selectedTruck.value = value ?? '';

  }
   showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.blue[100],
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4.5,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromGallery(context);
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.image,
                              size: 70,
                            ),
                            Text("Gallery")
                          ],
                        ),
                      ),
                    ),
                  ),
                  //comment by krunal 26-09-2024
                  /*Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromCamera(context);
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 70,
                            ),
                            Text("Camera")
                          ],
                        ),
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          );
        });
  }
  showAlertDialog(context) => showCupertinoDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('Permission Denied'),
      content: const Text('Allow access to gallery and photos'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => openAppSettings(),
          child: const Text('Settings'),
        ),
      ],
    ),
  );
  void showAlertDialog1(BuildContext context) {
    showCupertinoDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Permission Denied'),
        content: const Text('Allow access to camera to take photos.'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () => openAppSettings(),
            child: const Text('Settings'),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImageFromGallery(BuildContext context) async {
    try {
      final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (returnImage == null) {
        print('No image selected');
        Navigator.of(context).pop();
        return;
      }

      imagePath.value = File(returnImage.path);
      print('Selected image path: ${imagePath.value?.path}');

      // Ensure the modal sheet is closed after picking the image
      Navigator.of(context).pop();
    } catch (e) {
      print('Error picking image: $e');

      // Handle permission denial specifically
      var status = await Permission.photos.status;
      if (status.isDenied) {
        print('Access Denied');
        showAlertDialog(context);
      } else {
        print('Exception occurred!');
      }

      // Ensure the modal sheet is closed even after an error
      Navigator.of(context).pop();
    }
  }

//Camera
  Future<void> _pickImageFromCamera(BuildContext context) async {
    try {
      final returnImage = await ImagePicker().pickImage(source: ImageSource.camera);
      if (returnImage == null) {
        print('No image selected');
        Navigator.of(context).pop();
        return;
      }

      imagePath.value = File(returnImage.path);
      print('Selected image path: ${imagePath.value?.path}');

      // Ensure the modal sheet is closed after picking the image
      Navigator.of(context).pop();
    } catch (e) {
      print('Error picking image: $e');

      // Handle permission denial specifically
      var status = await Permission.camera.status;
      if (status.isDenied) {
        print('Access Denied');
        showAlertDialog1(context);
      } else {
        print('Exception occurred!');
      }

      // Ensure the modal sheet is closed even after an error
      Navigator.of(context).pop();
    }
  }

  // bool validateInputs() {
  //   bool isValid = true;

  //   if (selectedService.value.isEmpty) {
  //     isServices.currentState?.shake();
  //     isValid = false;
  //   }

  //   if (txtMobile.text.isEmpty) {
  //     isMobile.currentState?.shake();
  //     isValid = false;
  //   }
  //   if (txtEmail.text.isEmpty) {
  //     isEmail.currentState?.shake();
  //     isValid = false;
  //   }

  //   if (txtAdrs.text.isEmpty) {
  //     isAdrs.currentState?.shake();
  //     isValid = false;
  //   }

  //   if (txtReqInfo.text.isEmpty) {
  //     isReqInfo.currentState?.shake();
  //     isValid = false;
  //   }
  //   if (imagePath.value == null || imagePath.value!.path.isEmpty) {
  //     Get.snackbar("Error", "Select Image", snackPosition: SnackPosition.BOTTOM);
  //     isValid = false;
  //   }

  //   return isValid;
  // }

  Future<void> sendNow(BuildContext context) async {

    // if (!validateInputs()) {
    //   Get.snackbar("Error", "Please fill all required fields",
    //       snackPosition: SnackPosition.BOTTOM);
    //   return;
    // }

    isLoading.value = true;

    try {

      var uri = Uri.parse(Api.REQUEST_SERVICE);
      var request = http.MultipartRequest('POST', uri);
      request.fields['service'] = selectedService.value?.isNotEmpty == true ? selectedService.value! : '';
      request.fields['truck_tire_type'] = selectedService.value == "Truck Tire" ?truck_tire_type: '';
      request.fields['tire_size'] = (selectedService.value == "Truck Tire" || selectedService.value== "Trailer Tire")? txtTrialerTire.text ?? '': '';
      request.fields['towing_for'] =selectedService.value =="Towing" ?towing_for :'';

request.fields['mobile_no'] = txtMobile.text ?? '';
request.fields['email'] = txtEmail.text ?? '';
request.fields['country'] = selectedCountryId ?? '';
request.fields['state'] = selectedStateId ?? '';
request.fields['city'] = selectedCityId ?? '';
request.fields['address'] = txtAdrs.text ?? '';
request.fields['remark'] = txtReqInfo.text ?? '';

request.fields['truck_make'] = selectedTruck.value ?? '';
    request.fields['make_other'] = selectedTruck.value == "Other" ? (txtOtherMake.text ?? '') : '';
    request.fields['vi_number'] = txtVi.text ?? '';


    if (imagePath.value != null && imagePath.value!.path.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath('image', imagePath.value!.path),
      );
    }

      print('service: ${request.fields['service']}');
      print('truck_tire_type: ${request.fields['truck_tire_type']}');
      print('tire_size: ${request.fields['tire_size']}');
      print('towing_for: ${request.fields['towing_for']}');
      print('mobile_no: ${request.fields['mobile_no']}');
      print('email: ${request.fields['email']}');
      print('country: ${request.fields['country']}');
      print('state: ${request.fields['state']}');
      print('city: ${request.fields['city']}');
      print('address: ${request.fields['address']}');
      print('remark: ${request.fields['remark']}');
      print('truck_make: ${request.fields['truck_make']}');
      print('make_other: ${request.fields['make_other']}');
      print('vi_number: ${request.fields['vi_number']}');


      var response = await request.send();
      if (response.statusCode == 200) {


        Get.back();
        Get.snackbar("Success", "Request sent successfully",

            snackPosition: SnackPosition.BOTTOM);



      } else {
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

}



