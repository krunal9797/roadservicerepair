import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:roadservicerepair/app/utils/shake_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
class RegisterController extends GetxController {
  RxInt userType = 0.obs;

  List<String> arrCustomerType = ["Owner", "Manager", "Driver"];
  List<String> arrVendorType = ["Owner", "Manager", "Mechanic"];
  List<String> arrCustFor = ["Company", "Shop", "Individual"];
  List<String> arrVenFor = ["Mobile", "Shop"];
  List<String> arrServiceType = [
    "Truck Repair",
    "Trailer Repair",
    "Tier Repair",
    "Towing Service"
  ];
  List<String> arrCountry = ["Canada", "US"];
  List<String> arrState = ["Remain"];
  List<String> arrCity = ["Remain"];

  //Shake Key
  final isCustomerType = GlobalKey<ShakeWidgetState>();
  final isVendorType = GlobalKey<ShakeWidgetState>();
  final isCustFor = GlobalKey<ShakeWidgetState>();
  final isVenFor = GlobalKey<ShakeWidgetState>();
  final isServiceType = GlobalKey<ShakeWidgetState>();
  final isCountry = GlobalKey<ShakeWidgetState>();
  final isState = GlobalKey<ShakeWidgetState>();
  final isCity = GlobalKey<ShakeWidgetState>();

  final isCompanyName = GlobalKey<ShakeWidgetState>();
  final isPhone = GlobalKey<ShakeWidgetState>();
  final isAdd = GlobalKey<ShakeWidgetState>();
  final isEmail = GlobalKey<ShakeWidgetState>();
  final isPassword = GlobalKey<ShakeWidgetState>();

  //Controller

  TextEditingController txtCompanyName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtAdd = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  TextEditingController txtWorkingHours = TextEditingController();
  TextEditingController txtAuthorization = TextEditingController();
  TextEditingController txtContactPerson = TextEditingController();

  //FocusNode
  FocusNode fnCompanyName = FocusNode();
  FocusNode fnPhone = FocusNode();
  FocusNode fnAdd = FocusNode();
  FocusNode fnEmail = FocusNode();
  FocusNode fnPassword = FocusNode();
  FocusNode fnWorkingHour = FocusNode();
  FocusNode fnAuthorization = FocusNode();
  FocusNode fnContactPerson = FocusNode();

  RxBool isSecure = false.obs;

  onVisibilityTap(bool value) {
    isSecure.value = value;
  }

  onUserTypeTapped(int value) {
    userType.value = value;
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
        controller.text = address;  // Update the text field with the full address
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

    // void fetchCurrentLocation(TextEditingController controller) {
  //   // Logic to fetch the current location
  //   print("Fetching current location...");
  //   // Update the text field with the address
  //   controller.text = "Sample Address"; // Replace with the actual address
  // }

}
