import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:roadservicerepair/app/utils/shake_widget.dart';
import 'package:roadservicerepair/model/StatusModel.dart';

import '../../../model/CityData.dart';
import '../../../model/StateData.dart';
import '../../constants/Api.dart';

class EditInquiryController extends GetxController {
  dynamic data = Get.arguments;

  RxString pageTitle = "".obs;
  String towing_for = "";

  String truck_tire_type = "";
  String selectedCountryId = "";
  String selectedStateId = "";
  String selectedCityId = "";

  String rname = "";
  var statuses = <Map<String, dynamic>>[].obs;
  var selectedStatus = ''.obs;

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

  List<StateInfo> arrState = [];
  List<StatusModel> arrStatus = [];
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



  //RxBool isLoading = false.obs;
  RxInt status = 0.obs;
  RxString imageurl = ''.obs;

  var isLoadingCountry = false.obs;
  var isLoadingStatus = false.obs;
  var isLoadingState = false.obs;
  var isLoadingCity = false.obs;

  //Operations
  RxString selectedService = ''.obs;

  InfoList() {
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
    txtRemark.text = data['remark'];
    txtEstTime.text = data['est_time'];
    txtEstPrice.text = data['est_price'];
    txtVendorName.text = data['vendor_name'];
    txtVendorEmail.text = data['vendor_email'];
    txtVendorMobile.text = data['vendor_mobile'];
    txtVendorAddress.text = data['vendor_address'];

    rname = data['rname'];
    selectedStatus.value = rname;
  }

  @override
  void onInit() {
    pageTitle.value = "Edit Inquiry";
    print("EditInquiryController");
    InfoList();
    FetchStatus();

    super.onInit();
  }

  Future<void> FetchStatus() async {
    isLoadingStatus.value = true;
    final response = await http.get(Uri.parse(Api.GET_STATUS));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Map<String, dynamic>> fetchedStatuses = (data['info'] as List)
          .map((item) => {"id": item['id'], "name": item['name']})
          .toList();
      statuses.assignAll(fetchedStatuses);
      if (statuses.isNotEmpty) {
        selectedStatus.value = statuses.firstWhere(
                (status) => status['name'] == rname,
                orElse: () => {'name': ''})['name'] ??
            '';
      }
    } else {
      Get.snackbar('Error', 'Failed to load statuses');
    }
  }

  void updateSelectedStatus(String value) {
    selectedStatus.value = value;
  }

  String? get selectedId => statuses.firstWhereOrNull(
      (status) => status['name'] == selectedStatus.value)?['id'];

  onServiceSelect(String? value) {
    selectedService.value = value ?? '';
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
/*                  Expanded(
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

  Future _pickImageFromGallery(BuildContext context) async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;

    final File pickedFile = File(returnImage.path);
    setImagePath(pickedFile);

    Navigator.of(context).pop(); //close the model sheet
  }

//Camera
  void setImagePath(File file) {
    imagePath.value = file;
  }

  Future _pickImageFromCamera(BuildContext context) async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    final File pickedFile = File(returnImage.path);

    setImagePath(pickedFile);

    print(imagePath);
    Navigator.of(context).pop();
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
        Uri.parse(Api.UPDATE_VENDOR_INQUIRY),
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
          'status': data['status'].toString(),
          'image': data['image']
        }),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context);

        print(response.body);
        Get.snackbar("Success", "Update Details successfully",
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

    // print(
    //     {
    //       'list':'inquiry list',
    //       'id' : data['id'].toString(),
    //       'service': data['service'].toString(),
    //       'tire_type': data['tire_type'].toString() ,
    //       'tire_size':data['tire_size'].toString()  ,
    //       'towing_for':data['towing_for'].toString()  ,
    //       'cust_mobileno': data['cust_mobileno'].toString() ,
    //       'email': data['email'].toString() ,
    //       'country': data['cid'].toString() ,
    //       'state': data['sid'].toString() ,
    //       'city':data['c_id'].toString()  ,
    //       'address': data['address'].toString() ,
    //       'remark': data['remark'].toString() ,
    //       'cust_address': data['cust_address'].toString(),
    //       'est_time': data['est_time'].toString(),
    //       'est_price': data['est_price'].toString(),
    //       'vendor_name': data['vendor_name'].toString(),
    //       'vendor_email': data['vendor_email'].toString(),
    //       'vendor_mobile': data['vendor_mobile'].toString(),
    //       'status': selectedId.toString(),
    //       'truck_make': data['truck_make'].toString(),
    //       'make_other': data['make_other'].toString(),
    //       'vi_number': data['vi_number'].toString(),
    // });
  }
}
