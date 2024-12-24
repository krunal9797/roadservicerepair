import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:roadservicerepair/app/utils/shake_widget.dart';

import '../../../model/CityData.dart';
import '../../../model/Country.dart';
import '../../../model/StateData.dart';
import '../../constants/Api.dart';

class ReqServiceController extends GetxController {
  dynamic data = Get.arguments;

  RxString pageTitle = "".obs;
  String towing_for = "";
  String truck_make = "";

  String truck_tire_type = "";


  Rx<File?> imagePath = Rx<File?>(null);

  RxBool isLoading = false.obs;

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

  //Shake Key0
  final isService = GlobalKey<ShakeWidgetState>();
  final isServiceFor = GlobalKey<ShakeWidgetState>();
  final isType = GlobalKey<ShakeWidgetState>();
  final isName = GlobalKey<ShakeWidgetState>();
  final isUnitNo = GlobalKey<ShakeWidgetState>();
  final isDriverNo = GlobalKey<ShakeWidgetState>();
  final isAddress = GlobalKey<ShakeWidgetState>();
  final isRemark = GlobalKey<ShakeWidgetState>();

  //Controller
  TextEditingController txtService = TextEditingController();
  TextEditingController txtServiceFor = TextEditingController();
  TextEditingController txtType = TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtUnitNo = TextEditingController();
  TextEditingController txtDriverNo = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtRemark = TextEditingController();


  FocusNode fnService = FocusNode();
  FocusNode fnServiceFor = FocusNode();
  FocusNode fnType = FocusNode();
  FocusNode fnName = FocusNode();
  FocusNode fnUnitNo = FocusNode();
  FocusNode fnDriverNo = FocusNode();
  FocusNode fnAddress = FocusNode();
  FocusNode fnRemark = FocusNode();
  FocusNode fnImage = FocusNode();

  @override
  void onInit() {
    pageTitle.value = data;
    print("ReqServiceController");

    super.onInit();
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
      final returnImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
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
      final returnImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
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
  //
  //   if (selectedService.value.isEmpty) {
  //     isServices.currentState?.shake();
  //     isValid = false;
  //   }
  //
  //   // if (txtMobile.text.isEmpty) {
  //   //   isMobile.currentState?.shake();
  //   //   isValid = false;
  //   // }
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
  //   if (imagePath.value == null || imagePath.value!.path.isEmpty) {
  //     Get.snackbar("Error", "Select Image",
  //         snackPosition: SnackPosition.BOTTOM);
  //     isValid = false;
  //   }
  //
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
      request.fields['service'] = selectedService.value;
      request.fields['service_for'] = txtServiceFor.text;
      // request.fields['type'] = txtType.text;
      request.fields['name'] = txtName.text;
      request.fields['unit_number'] = txtUnitNo.text;
      request.fields['driver_number'] = txtDriverNo.text;
      request.fields['address'] = txtAddress.text;
      request.fields['remark'] = txtRemark.text;

      final defaultImageFile = await getDefaultImageFile();
      request.files.add(await http.MultipartFile.fromPath('image', imagePath.value?.path ?? defaultImageFile.path));


      // if (imagePath != null && imagePath.value!.path.isNotEmpty) {
      //   request.files.add(await http.MultipartFile.fromPath('image', imagePath.value!.path));
      // }

      // print('service: ${request.fields['service']}');
      // print('truck_tire_type: ${request.fields['truck_tire_type']}');
      // print('tire_size: ${request.fields['tire_size']}');
      // print('towing_for: ${request.fields['towing_for']}');
      // print('mobile_no: ${request.fields['mobile_no']}');
      // print('email: ${request.fields['email']}');
      // print('country: ${request.fields['country']}');
      // print('state: ${request.fields['state']}');
      // print('city: ${request.fields['city']}');
      // print('address: ${request.fields['address']}');
      // print('remark: ${request.fields['remark']}');
      // print('truck_make: ${request.fields['truck_make']}');
      // print('make_other: ${request.fields['make_other']}');
      // print('vi_number: ${request.fields['vi_number']}');

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

  Future<File> getDefaultImageFile() async {
    // Load the asset as a byte array
    final byteData = await rootBundle.load('assets/images/road_repair_service_1.png');

    // Get a temporary directory
    final tempDir = await getTemporaryDirectory();

    // Create a temporary file for the asset
    final tempFile = File('${tempDir.path}/road.png');

    // Write the asset data to the temporary file
    await tempFile.writeAsBytes(byteData.buffer.asUint8List());

    return tempFile;
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
