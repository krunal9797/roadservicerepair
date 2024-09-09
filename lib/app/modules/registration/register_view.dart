import 'dart:convert';
import 'dart:core';
import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:roadservicerepair/app/constants/app_colors.dart';
import 'package:roadservicerepair/app/constants/util.dart';
import 'package:roadservicerepair/app/utils/button_utl.dart';
import 'package:roadservicerepair/app/utils/drop_down_utl.dart';
import 'package:roadservicerepair/app/utils/global.dart';
import 'package:roadservicerepair/app/utils/text_field_utl.dart';
import 'package:roadservicerepair/app/utils/text_utl.dart';
import 'package:roadservicerepair/model/CityData.dart';
import 'package:roadservicerepair/model/Country.dart';
import 'dart:typed_data' as typed_data;

import 'package:flutter/foundation.dart';
import '../../../model/StateData.dart';
import '../../constants/Api.dart';
import '../../utils/shake_widget.dart';
import 'package:http/http.dart' as http;

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RxInt userType = 1.obs;
  RxBool isSecure = false.obs;
  String? cust_type;
  String? vendorFor;
  String? selectedCountryId;
  String? selectedStateId;
  String? selectedCityId;
  String? selectCustomerFor;
  String? vendorType;
  String? typeOfService;

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
  TextEditingController txtCompanyName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtAdd = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  //FocusNode
  FocusNode fnCompanyName = FocusNode();
  FocusNode fnPhone = FocusNode();
  FocusNode fnAdd = FocusNode();
  FocusNode fnEmail = FocusNode();
  FocusNode fnPassword = FocusNode();
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
  List<Info> arrCountry = [];
  List<StateInfo> arrState = [];
  List<CityInfo> arrCity = [];
  File? imagePath ;
  var isLoadingCountry = false;
  var isLoadingState = false;
  var isLoadingCity = false;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
   // _requestPermissions();
    fetchCountries();

  }
  // void setImagePath(File file) {
  //   imagePath.value = file;
  // }



  Future<void> fetchCountries() async{
      isLoadingCountry = true;
    final response = await http.get(Uri.parse(Api.COUNTRY));
    if(response.statusCode==200){
      Country countryData = Country.fromJson(json.decode(response.body));

     // arrCountry = countryData.info?.map((info) => info.name ?? '').toList() ?? [];
     setState(() {
       arrCountry = countryData.info ?? [];
     });

    }
    isLoadingCountry =false;



  }
  Future<void> fetchStates(String countryId) async {
     isLoadingState = true;
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
      setState(() {
        arrState = stateData.info ?? [];
      });
    } else {
      // Handle the error
      print('Failed to load states');
    }
      isLoadingState = false;
  }

  Future<void> fetchCities(String stateId) async {
     isLoadingCity = true;
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
      setState(() {
        arrCity = cityData.info ?? [];
      });
    } else {
      // Handle the error
      print('Failed to load states');
    }
    setState(() {

    });
      isLoadingCity = false;





  }

  Future<void> register() async {
    if (_validateForm()) {
      try {
        var uri = Uri.parse(Api.REGISTER);

        var request = http.MultipartRequest('POST', uri);

        // Add text fields
        request.fields['type'] = userType.value == 2 ? (vendorType ?? '') : '';
        request.fields['cust_type'] = userType.value == 2 ? (vendorFor ?? '') : '';
        request.fields['service_type'] = userType.value == 2 ? (typeOfService ?? '') : '';
        request.fields['type_cust'] = userType.value == 1 ? (cust_type ?? '') : '';
        request.fields['typecust'] = userType.value == 1 ? (selectCustomerFor ?? '') : '';
        request.fields['name'] = txtCompanyName.text.trim();
        request.fields['mobile_no'] = txtPhone.text.trim();
        request.fields['country'] = selectedCountryId ?? '';
        request.fields['state'] = selectedStateId ?? '';
        request.fields['city'] = selectedCityId ?? '';
        request.fields['address'] = txtAdd.text.trim();
        request.fields['email'] = txtEmail.text.trim();
        request.fields['password'] = txtPassword.text.trim();
        request.fields['user_type'] = userType.value.toString();
        request.fields['fcm_token'] = fcmToken.toString();

        // Add image file
        if (imagePath != null && imagePath!.path.isNotEmpty) {
          request.files.add(await http.MultipartFile.fromPath('image', imagePath!.path));
        }

        // Send request
        var response = await request.send();

        if (response.statusCode == 200) {
          // Registration successful, handle next steps
          var responseBody = await response.stream.bytesToString();
          var jsonResponse = jsonDecode(responseBody);

          print('Registration successful: $responseBody');
          Get.snackbar("Success", jsonResponse['msg']);

          navigator?.pop();
        } else {
          // Handle error response
          Get.snackbar("Error", "Registration failed");
        }
      } catch (e) {
        print(e);
        Get.snackbar("Error", e.toString());
      }

      // Debug print the data
      print({
        'type': userType.value == 2 ? (vendorType ?? '') : '',
        'cust_type': userType.value == 2 ? (vendorFor ?? '') : '',
        'service_type': userType.value == 2 ? (typeOfService ?? '') : '',
        'type_cust': userType.value == 1 ? (cust_type ?? '') : '',
        'typecust': userType.value == 1 ? (selectCustomerFor ?? '') : '',
        'name': txtCompanyName.text.trim(),
        'mobile_no': txtPhone.text.trim(),
        'country': selectedCountryId ?? '',
        'state': selectedStateId ?? '',
        'city': selectedCityId ?? '',
        'address': txtAdd.text.trim(),
        'email': txtEmail.text.trim(),
        'password': txtPassword.text.trim(),
        'selectedImage': imagePath,
        'user_type': userType.value.toString(),
        'fcm_token': fcmToken.toString(),
      });
    }
  }
  // Future<void> register() async {
  //    if (_validateForm()) {
  //     try {
  //
  //
  //       final response = await http.post(
  //         Uri.parse(Api.REGISTER),
  //         /*headers: {
  //           'Content-Type': 'application/json',
  //         },*/
  //           body:{
  //             'type': userType.value == 2 ? (vendorType ?? '') : '',
  //             'cust_type': userType.value == 2 ? (vendorFor ?? '') : '',
  //             'service_type': userType.value == 2 ? (typeOfService ?? '') : '',
  //             'type_cust': userType.value == 1 ? (cust_type ?? '') : '',
  //             'typecust': userType.value == 1 ? (selectCustomerFor ?? '') : '',
  //             'name': txtCompanyName.text.trim(),
  //             'mobile_no': txtPhone.text.trim(),
  //             'country': selectedCountryId ?? '',
  //             'state': selectedStateId ?? '',
  //             'city': selectedCityId ?? '',
  //             'address': txtAdd.text.trim(),
  //             'email': txtEmail.text.trim(),
  //             'password': txtPassword.text.trim(),
  //             'image': imagePath.toString(),
  //             'user_type': userType.value.toString(),
  //
  //           }
  //       );
  //           if (response.statusCode == 200) {
  //
  //         // Registration successful, handle next steps
  //         final   jsonResponse = jsonDecode(response.body);
  //
  //
  //         print('Registration successful'+response.body);
  //         Get.snackbar("Success", jsonResponse['msg']);
  //
  //         navigator?.pop();
  //       } else {
  //      // Handle error response
  //      Get.snackbar("Error", "Registration failed");
  //    }
  // } catch (e) {
  //   print(e);
  //   Get.snackbar("Error", e.toString());
  //   }
  //
  //   print({
  //   'type': userType.value == 2 ? (vendorType ?? '') : '',
  //   'cust_type': userType.value == 2 ? (vendorFor ?? '') : '',
  //   'service_type': userType.value == 2 ? (typeOfService ?? '') : '',
  //   'type_cust': userType.value == 1 ? (cust_type ?? '') : '',
  //   'typecust': userType.value == 1 ? (selectCustomerFor ?? '') : '',
  //   'name': txtCompanyName.text.trim(),
  //   'mobile_no': txtPhone.text.trim(),
  //   'country': selectedCountryId ?? '',
  //   'state': selectedStateId ?? '',
  //   'city': selectedCityId ?? '',
  //   'address': txtAdd.text.trim(),
  //   'email': txtEmail.text.trim(),
  //   'password': txtPassword.text.trim(),
  //   'selectedImage':imagePath,
  //   'user_type': userType.value.toString(),
  //   });
  //
  //
  //    }
  //
  //
  // }

  bool _validateForm() {
    bool isValid = true;

    if (txtCompanyName.text.isEmpty) {
      isValid = false;
      isCompanyName.currentState?.shake();
    }
    if (txtPhone.text.isEmpty) {
      isValid = false;
      isPhone.currentState?.shake();
    }
    if (txtAdd.text.isEmpty) {
      isValid = false;
      isAdd.currentState?.shake();
    }
    if (txtEmail.text.isEmpty || !isEmailValid(txtEmail.text.trim())) {
      isValid = false;
      isEmail.currentState?.shake();
    }
    if (txtPassword.text.isEmpty) {
      isValid = false;
      isPassword.currentState?.shake();
    }

    return isValid;
  }

  bool isEmailValid(String email) {
    // Basic email validation, replace with your own logic if needed
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void showImagePickerOption(BuildContext context) {
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
                        _pickImageFromGallery();
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
                        _pickImageFromCamera();
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

//Gallery
  Future _pickImageFromGallery() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;
      setState(() {
        imagePath = File(pickedFile.path);
        print(imagePath);
        Navigator.of(context).pop();
      });
    } catch (e) {

      var status = await Permission.photos.status;
      if (status.isDenied) {
        print('Access Denied');
        showAlertDialog(context);
      } else {
        print('Exception occured!');
      }

    }


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




  Future _pickImageFromCamera() async {



    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile == null) return;
      setState(() {
        imagePath = File(pickedFile.path);
        print(imagePath);
        Navigator.of(context).pop();
      });
    } catch (e) {
      print('Error picking image: $e');
    }

  }
//   Future _pickImageFromGallery() async {
//     final returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (returnImage == null) return;
//
//
//     final File pickedFile = File(returnImage.path);
//     setImagePath(pickedFile);
//     setState(() {
//
//
//     });
//     Navigator.of(context).pop(); //close the model sheet
//   }
//
//
//   Future _pickImageFromCamera() async {
//     final returnImage = await ImagePicker().pickImage(source: ImageSource.camera);
//     if (returnImage == null) return;
//     final File pickedFile = File(returnImage.path);
//
//
//     setImagePath(pickedFile);
//
//     print(imagePath);
//
//
//     Navigator.of(context).pop();
//     setState(() {
//
//
//
//     });
//
//   }
  @override
  Widget build(BuildContext context) {




          return SafeArea(
            top: false,
            bottom: false,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.whiteText,
                surfaceTintColor: AppColors.whiteText,
                title:
                    setSemiText("Register New User", AppColors.titleText, 16),
              ),
              backgroundColor: AppColors.primary,
              body: ListView(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child:
                        setRegularText("Select Type", AppColors.titleText, 16),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        GestureDetector(
                          onTap: () {
                            onUserTypeTapped(1);
                          },
                          child: Container(
                            height: 50,
                            width: getScreenWidth(context) / 2 - 30,
                            decoration: BoxDecoration(
                              color: userType.value == 1
                                  ? AppColors.titleText
                                  : AppColors.whiteText,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            alignment: Alignment.center,
                            child: setRegularText(
                                "Customer",
                                userType.value == 1
                                    ? AppColors.whiteText
                                    : AppColors.titleText,
                                14),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            onUserTypeTapped(2);
                          },
                          child: Container(
                            height: 50,
                            width: getScreenWidth(context) / 2 - 30,
                            decoration: BoxDecoration(
                              color: userType.value == 2
                                  ? AppColors.titleText
                                  : AppColors.whiteText,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            alignment: Alignment.center,
                            child: setRegularText(
                              "Vendor",
                              userType.value == 2
                                  ? AppColors.whiteText
                                  : AppColors.titleText,
                              14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Stack(
                      children: [
                        imagePath != null
                            ? CircleAvatar(
                            radius: 100,  backgroundImage: FileImage(imagePath as File))
                            : const CircleAvatar(
                          radius: 100,
                          backgroundImage: NetworkImage(
                              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
                        ),
                        Positioned(
                            bottom: -0,
                            left: 140,
                            child: IconButton(
                                onPressed: () {
                                  showImagePickerOption(context);
                                },
                                icon: const Icon(Icons.add_a_photo)))
                      ],
                    ),
                  ),


                Obx(() =>   Visibility(
                    visible: userType==1,
                    child: setDropDown(
                      context,
                      "Customer Type",
                      "Select customer type",
                      isCustomerType,
                      arrCustomerType,
                      (String? value) => {
                        cust_type =value


                      },
                    ),
                  ),),
                  const SizedBox(height: 15),
                 Obx(
                   () => Visibility(
                    visible: userType== 2,
                    child: setDropDown(
                      context,
                      "Vendor Type",
                      "Select vendor type",
                      isVendorType,
                      arrVendorType,
                      (String? value) => {
                         vendorType = value
                      },
                    ),
                  )),
                  const SizedBox(height: 15),
                 Obx(() =>  Visibility(
                   visible: userType==1,
                    child: setDropDown(
                      context,
                      "Select Customer For",
                      "Select customer for",
                      isCustFor,
                      arrCustFor,
                      (String? value) => {

                         selectCustomerFor = value

                      },
                    ),
                  ),),
                  const SizedBox(height: 15),

                 Obx(() =>  Visibility(
                   visible: userType==2,
                    child: setDropDown(
                      context,
                      "Select Vendor For",
                      "Select vendor for",
                      isVenFor,
                      arrVenFor,
                      (String? value) => {
                        vendorFor =value
                      },
                    ),
                  ),),
                  const SizedBox(height: 15),

                Obx(() =>   Visibility(
                  visible: userType==2,
                    child: setDropDown(
                      context,
                      "Type Of Service",
                      "Select type of service",
                      isServiceType,
                      arrServiceType,
                      (String? value) => {
                        typeOfService=value
                      },
                    ),
                  ),),
                  const SizedBox(height: 15),
                  setTextField(
                      context,
                      "Owner/Vendor Or Company Name",
                      "Enter Owner/Vendor Or Company Name",
                      isCompanyName,
                      txtCompanyName,
                      fnCompanyName),
                  const SizedBox(height: 15),
                  setTextField(context, "Phone Number", "Enter phone number",
                      isPhone, txtPhone, fnPhone),
                  const SizedBox(height: 15),
                  if (isLoadingCountry) Center(
                    child: SizedBox(
                      width: 24,  // Adjust the width as needed
                      height: 24, // Adjust the height as needed
                      child: CircularProgressIndicator(
                        strokeWidth: 2, // Adjust the thickness of the indicator
                      ),
                    ),
                  ),
                  if (!isLoadingCountry && arrCountry.isNotEmpty)
                 setDropDown(
                    context,
                    "Country",
                    "Select country",
                    isCountry,
                    arrCountry.map((info) => info.name ?? '').toList(),

                        (String? value) {
                      setState(() {
                      var  CountryName = value;
                         selectedCountryId = arrCountry.firstWhere(
                              (info) => info.name == value,
                          orElse: () => Info(id: '', shortname: '', name: '', phonecode: ''), // provide default value if not found
                        ).id!;
                        print(selectedCountryId);
                        fetchStates(selectedCountryId!);
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  if (isLoadingState) Center(
                    child: SizedBox(
                      width: 24,  // Adjust the width as needed
                      height: 24, // Adjust the height as needed
                      child: CircularProgressIndicator(
                        strokeWidth: 2, // Adjust the thickness of the indicator
                      ),
                    ),
                  ),
                  if (!isLoadingState && arrState.isNotEmpty)
                  setDropDown(
                    context,
                    "State",
                    "Select state",
                    isState,
                    arrState.map((info) => info.name ?? '').toList(),
                        (String? value) {
                      setState(() {
                      var  stateName = value;
                         selectedStateId = arrState.firstWhere(
                              (info) => info.name == value,
                          orElse: () => StateInfo(id: '', name: ''), // provide default value if not found
                        ).id!;
                        print(selectedStateId);
                        fetchCities(selectedStateId!);
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  if (isLoadingCity)
                    Center(
                      child: SizedBox(
                        width: 24,  // Adjust the width as needed
                        height: 24, // Adjust the height as needed
                        child: CircularProgressIndicator(
                          strokeWidth: 2, // Adjust the thickness of the indicator
                        ),
                      ),
                    ),
                  if (!isLoadingCity && arrCity.isNotEmpty)
                  setDropDown(
                    context,
                    "City",
                    "Select city",
                    isCity,
                    arrCity.map((info) => info.name ?? '').toList(),
                          (String? value) {
                        setState(() {
                          var cityName = value!;
                          selectedCityId = arrCity.firstWhere(
                                (info) => info.name == value,
                            orElse: () => CityInfo(id: '', name: ''), // provide default value if not found
                          ).id!;

                        });
                      }

                  ),
                  const SizedBox(height: 15),
                  setTextFormField(context, "Address", "Enter address", isAdd,
                      txtAdd, fnAdd),
                  const SizedBox(height: 15),
                  setTextField(context, "Email", "Enter email", isEmail,
                      txtEmail, fnEmail),
                  const SizedBox(height: 15),
                  Obx(
                    () => setTextField(context, "Password", "Enter Password",
                        isPassword, txtPassword, fnPassword,
                        surfix: setIconButton(
                          () => onVisibilityTap(!isSecure.value),
                          Icon(
                            isSecure.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.detailText,
                          ),
                          height: 30,
                          width: 30,
                        ),
                        obsecureText: !isSecure.value),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: setButton(
                        () => {

                         register()
                        },
                        setSemiText("Register", AppColors.whiteText, 16),
                        AppColors.button,
                        200,
                        50),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );



  }
  onUserTypeTapped(int value) {
    userType.value = value;
  }
  onVisibilityTap(bool value) {
    isSecure.value = value;
  }
}
