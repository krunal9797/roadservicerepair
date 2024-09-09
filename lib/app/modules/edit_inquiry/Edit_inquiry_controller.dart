import 'dart:convert';
import 'dart:io';
import 'dart:typed_data' as typed_data;

import 'dart:typed_data';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roadservicerepair/app/utils/shake_widget.dart';
import 'package:http/http.dart' as http;
import 'package:roadservicerepair/model/StatusModel.dart';

import '../../../model/CityData.dart';
import '../../../model/Country.dart';
import '../../../model/StateData.dart';
import '../../constants/Api.dart';

class EditInquiryController extends GetxController {
  dynamic data = Get.arguments;

  RxString pageTitle = "".obs;
  String towing_for ="";

  String truck_tire_type ="";
  String selectedCountryId ="";
  String selectedStateId ="";
  String selectedCityId ="";

String rname="";
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
  final isTruck_make = GlobalKey<ShakeWidgetState>();
  final isMake_other = GlobalKey<ShakeWidgetState>();
  final isvi_number = GlobalKey<ShakeWidgetState>();
  final isServices = GlobalKey<ShakeWidgetState>();
  final isTypeOfTire = GlobalKey<ShakeWidgetState>();
  final isTruckTire = GlobalKey<ShakeWidgetState>();
  final isTire_type = GlobalKey<ShakeWidgetState>();
  final isTire_size = GlobalKey<ShakeWidgetState>();
  final isTrialerTire = GlobalKey<ShakeWidgetState>();


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
  final isStatus= GlobalKey<ShakeWidgetState>();
  final isCity = GlobalKey<ShakeWidgetState>();

  final isMobile = GlobalKey<ShakeWidgetState>();
  final isEmail = GlobalKey<ShakeWidgetState>();
  final isAdrs = GlobalKey<ShakeWidgetState>();
  final isReqInfo = GlobalKey<ShakeWidgetState>();

  //Controller
  TextEditingController txtTruck_make = TextEditingController();
  TextEditingController txtMake_other = TextEditingController();
  TextEditingController txtvi_number = TextEditingController();
  TextEditingController txtTruckTire = TextEditingController();
  TextEditingController txtTrialerTire = TextEditingController();
  TextEditingController txtTire_type = TextEditingController();
  TextEditingController txtTire_size = TextEditingController();


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

  //FocusNode
  FocusNode fnTruckTire = FocusNode();
  FocusNode fnTire_type = FocusNode();
  FocusNode fnTire_size = FocusNode();
  FocusNode fnTrialerTire = FocusNode();
  FocusNode fnTruck_make = FocusNode();
  FocusNode fnMake_other = FocusNode();
  FocusNode fnvi_number = FocusNode();


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







  FocusNode fnMobile = FocusNode();
  FocusNode fnEmail = FocusNode();
  FocusNode fnAdrs = FocusNode();
  FocusNode fnServices = FocusNode();
  FocusNode fnReqInfo = FocusNode();
  var isLoadingCountry = false.obs;
  var isLoadingStatus = false.obs;
  var isLoadingState = false.obs;
  var isLoadingCity = false.obs;

  //Operations
  RxString selectedService = ''.obs;


  InfoList(){

    txtEmail.text =data['email'];
    txtAdrs.text =data['address'];
    txtremark.text=data['remark'];
    txtMobile.text=data['vendor_mobile'];
    txtServices.text=data['service'];
    txtTire_size.text=data['tire_size'];
    txtTire_type.text=data['tire_type'];
    txttowing_for.text=data['towing_for'];

    txtcountry_name.text=data['country_name'];


    txtstate_name.text =data['state_name'];
    txtcity_name.text =data['city_name'];
    txtcust_mobileno.text=data['cust_mobileno'];
    txtcust_address.text=data['cust_address'];
   txtest_time.text =data['est_time'];
   txtest_price.text =data['est_price'];
   txtvendor_name.text =data['vendor_name'];

  txtvendor_email.text  =data['vendor_email'];
  txtvi_number.text  =data['vi_number'];
  txtMake_other.text=data['make_other'];
  txtTruck_make.text=data['truck_make'];
 txtrname.text =data['rname'];
// selectedStatus.value=data['rname'];
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
  Future<void> FetchStatus() async{
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
            orElse: () => {'name': ''})['name'] ?? '';
      }
    } else {
      Get.snackbar('Error', 'Failed to load statuses');
    }
  }
  void updateSelectedStatus(String value) {
    selectedStatus.value = value;
  }

  String? get selectedId => statuses.firstWhereOrNull((status) => status['name'] == selectedStatus.value)?['id'];



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
                  Expanded(
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
                  ),
                ],
              ),
            ),
          );
        });
  }
  Future _pickImageFromGallery(BuildContext context) async {
    final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;


    final File pickedFile = File(returnImage.path);
    setImagePath(pickedFile);


    Navigator.of( context).pop(); //close the model sheet
  }

//Camera
  void setImagePath(File file) {
    imagePath.value = file;
  }
  Future _pickImageFromCamera(BuildContext context) async {
    final returnImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    final File pickedFile = File(returnImage.path);


    setImagePath(pickedFile);

    print(imagePath);
    Navigator.of(context).pop();
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
        Uri.parse(Api.UPDATE_VENDOR_INQUIRY),

        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'id' : data['id'].toString(),
          'service': data['service'].toString(),
          'tire_type': data['tire_type'].toString() ,
          'tire_size':data['tire_size'].toString()  ,
          'towing_for':data['towing_for'].toString()  ,
          'cust_mobileno': data['cust_mobileno'].toString() ,
          'email': data['email'].toString() ,
          'country': data['cid'].toString() ,
          'state': data['sid'].toString() ,
          'city':data['c_id'].toString()  ,
          'address': data['address'].toString() ,
          'remark': data['remark'].toString() ,
          'cust_address': data['cust_address'].toString(),
          'est_time': data['est_time'].toString(),
          'est_price': data['est_price'].toString(),
          'vendor_name': data['vendor_name'].toString(),
          'vendor_email': data['vendor_email'].toString(),
          'vendor_mobile': data['vendor_mobile'].toString(),
          'status': selectedId.toString(),
          'truck_make': data['truck_make'].toString(),
          'make_other': data['make_other'].toString(),
          'vi_number': data['vi_number'].toString(),

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

    print(

        {
          'list':'inquiry list',
          'id' : data['id'].toString(),
          'service': data['service'].toString(),
          'tire_type': data['tire_type'].toString() ,
          'tire_size':data['tire_size'].toString()  ,
          'towing_for':data['towing_for'].toString()  ,
          'cust_mobileno': data['cust_mobileno'].toString() ,
          'email': data['email'].toString() ,
          'country': data['cid'].toString() ,
          'state': data['sid'].toString() ,
          'city':data['c_id'].toString()  ,
          'address': data['address'].toString() ,
          'remark': data['remark'].toString() ,
          'cust_address': data['cust_address'].toString(),
          'est_time': data['est_time'].toString(),
          'est_price': data['est_price'].toString(),
          'vendor_name': data['vendor_name'].toString(),
          'vendor_email': data['vendor_email'].toString(),
          'vendor_mobile': data['vendor_mobile'].toString(),
          'status': selectedId.toString(),
          'truck_make': data['truck_make'].toString(),
          'make_other': data['make_other'].toString(),
          'vi_number': data['vi_number'].toString(),
    });
  }





}



