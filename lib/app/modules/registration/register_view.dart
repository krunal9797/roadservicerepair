import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:roadservicerepair/app/constants/app_colors.dart';
import 'package:roadservicerepair/app/constants/util.dart';
import 'package:roadservicerepair/app/modules/registration/register_controller.dart';
import 'package:roadservicerepair/app/utils/button_utl.dart';
import 'package:roadservicerepair/app/utils/drop_down_utl.dart';
import 'package:roadservicerepair/app/utils/text_field_utl.dart';
import 'package:roadservicerepair/app/utils/text_utl.dart';
import 'package:roadservicerepair/model/CityData.dart';
import 'package:roadservicerepair/model/Country.dart';

import '../../../model/StateData.dart';
import '../../constants/Api.dart';
import '../../utils/shake_widget.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterController controller = RegisterController();

  // RxInt userType = 1.obs;
  late RxInt userType;
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
  final isContactPerson = GlobalKey<ShakeWidgetState>();
  final isWorkingHour = GlobalKey<ShakeWidgetState>();
  final isAuthorization = GlobalKey<ShakeWidgetState>();
  final isPassword = GlobalKey<ShakeWidgetState>();

  TextEditingController txtCompanyName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtAdd = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtWorkingHours = TextEditingController();
  TextEditingController txtAuthorization = TextEditingController();
  TextEditingController txtContactPerson = TextEditingController();

  TextEditingController txtVendorFor = TextEditingController();

  //FocusNode
  FocusNode fnCompanyName = FocusNode();
  FocusNode fnPhone = FocusNode();
  FocusNode fnAdd = FocusNode();
  FocusNode fnEmail = FocusNode();
  FocusNode fnPassword = FocusNode();

  FocusNode fnContactPerson = FocusNode();
  FocusNode fnWorkingHour = FocusNode();
  FocusNode fnAuthorization = FocusNode();

  List<String> arrCustomerType = ["Owner", "Manager", "Driver"];
  List<String> arrVendorType = ["Owner", "Manager", "Mechanic"];
  List<String> arrCustFor = ["Company", "Shop", "Individual"];
  List<String> arrVenFor = ["Mobile", "Shop"];
  List<String> arrServiceType = [
    "Truck Repair",
    "Trailer Repair",
    "Tier Repair",
    "Towing Service",
    "Fuel Delivery"
  ];

  List<String> prices = List.generate(
    11, // From 500 to 1000 in 50 increments -> (1000 - 500) / 50 + 1 = 11
    (index) => "\$${500 + (index * 50)}",
  );
  String selectedPrice = "\$500";

  List<Info> arrCountry = [];
  List<StateInfo> arrState = [];
  List<CityInfo> arrCity = [];
  File? imagePath;

  var isLoadingCountry = false;
  var isLoadingState = false;
  var isLoadingCity = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _requestPermissions();
    userType = (Get.arguments as int).obs;
    print("user tyep " + userType.toString());
    fetchCountries();
  }

  // void setImagePath(File file) {
  //   imagePath.value = file;
  // }

  Future<void> fetchCountries() async {
    isLoadingCountry = true;
    final response = await http.get(Uri.parse(Api.COUNTRY));
    if (response.statusCode == 200) {
      Country countryData = Country.fromJson(json.decode(response.body));

      // arrCountry = countryData.info?.map((info) => info.name ?? '').toList() ?? [];
      setState(() {
        arrCountry = countryData.info ?? [];
      });
    }
    isLoadingCountry = false;
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
    setState(() {});
    isLoadingCity = false;
  }

  Future<void> register() async {

    print("krunal"+" vendor type "+vendorType.toString());
    print("krunal"+" cust type "+vendorFor.toString());
    print("krunal"+"type of serivce "+vendorFor.toString());
    print("krunal"+"type of serivce "+controller.txtService.value.toString());
    print("krunal"+"type of serivce "+typeOfService.toString());


    //customer

    print("krunal"+"type of serivce "+typeOfService.toString());


    if (_validateForm()) {
      try {
        var uri = Uri.parse(Api.REGISTER);

        var request = http.MultipartRequest('POST', uri);

        // Add text fields

        request.fields['type'] = (userType == 1) ? cust_type.toString() : vendorType.toString();
        request.fields['cust_type'] = (userType == 1) ? selectCustomerFor.toString() : vendorFor.toString();

        request.fields['service_type'] = typeOfService.toString();
        request.fields['type_cust'] = cust_type.toString();
        request.fields['typecust'] = selectCustomerFor.toString();
        request.fields['company_name'] = txtCompanyName.text.toString();
        request.fields['authorization'] = (userType == 1) ? selectedPrice.toString() : '';
        request.fields['working_hours'] = (userType == 2) ? txtWorkingHours.text.toString() : '';


        request.fields['name'] = txtContactPerson.text.trim();
        request.fields['mobile_no'] = txtPhone.text.trim();
        request.fields['country'] = selectedCountryId ?? '';
        request.fields['state'] = selectedStateId ?? '';
        request.fields['city'] = selectedCityId ?? '';
        request.fields['address'] = txtAdd.text.trim();
        request.fields['email'] = txtEmail.text.trim();
        request.fields['password'] = txtPassword.text.trim();
        request.fields['user_type'] = userType.value.toString();
        request.fields['contact_person'] = txtContactPerson.text.toString();
        request.fields['fcm_token'] = fcmToken.toString();
        //request.fields['working_hours'] = txtWorkingHours.text.toString();

        final defaultImageFile = await getDefaultImageFile();
        request.files.add(await http.MultipartFile.fromPath(
            'image', imagePath?.path ?? defaultImageFile.path));

        // if (imagePath != null && imagePath!.path.isNotEmpty) {
        //   request.files.add(await http.MultipartFile.fromPath('image', imagePath!.path));
        // }

        Map<String, dynamic> requestData = {
          'type': request.fields['type'],
          'cust_type': request.fields['cust_type'],
          'service_type': request.fields['service_type'],
          'type_cust': request.fields['type_cust'],
          'typecust': request.fields['typecust'],
          'name': request.fields['name'],
          'mobile_no': request.fields['mobile_no'],
          'country': request.fields['country'],
          'state': request.fields['state'],
          'city': request.fields['city'],
          'address': request.fields['address'],
          'email': request.fields['email'],
          'password': request.fields['password'],
          'user_type': request.fields['user_type'],
          'contact_person': request.fields['contact_person'],
          'fcm_token': request.fields['fcm_token'],
          'authorization':
              userType == 1 ? request.fields['authorization'] : null,
          'working_hours':
              userType == 2 ? request.fields['working_hours'] : null,
          'image': imagePath?.path ?? 'no image selected',
        };

// Print the request data as a JSON object

        print("test");
        print(jsonEncode(requestData));
        print("test");

        // Send request
        var response = await request.send();

        print('Response status: ${response.statusCode}');
        print('Response body: ${response}');

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

      // Debug print the datae

    }
  }

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
                  //comment by krunal 26-09-2024
/*                  Expanded(
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
                  ),*/
                ],
              ),
            ),
          );
        });
  }

//Gallery
  Future _pickImageFromGallery() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
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
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.whiteText,
          surfaceTintColor: AppColors.whiteText,
          title: setSemiText("Register New User", AppColors.titleText, 16),
        ),
        backgroundColor: AppColors.primary,
        body: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            const SizedBox(height: 20),
            Center(
              child: Stack(
                children: [
                  imagePath != null
                      ? CircleAvatar(
                          radius: 100,
                          backgroundImage: FileImage(imagePath as File))
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

            Obx(
              () => Visibility(
                visible: userType == 1,
                child: setDropDown(
                  context,
                  "Customer Type",
                  "Select customer type",
                  isCustomerType,
                  arrCustomerType,
                  (String? value) => {cust_type = value},
                ),
              ),
            ),
            const SizedBox(height: 15),
            Obx(() => Visibility(
                  visible: userType == 2,
                  child: setDropDown(
                    context,
                    "Vendor Type",
                    "Select vendor type",
                    isVendorType,
                    arrVendorType,
                    (String? value) => {vendorType = value},
                  ),
                )),
            const SizedBox(height: 15),
            Obx(
              () => Visibility(
                visible: userType == 1,
                child: setDropDown(
                  context,
                  "Select Customer For",
                  "Select customer for",
                  isCustFor,
                  arrCustFor,
                  (String? value) => {selectCustomerFor = value},
                ),
              ),
            ),
            const SizedBox(height: 15),

            Obx(
              () => Visibility(
                visible: userType == 2,
                child: setTextFieldDropReg(
                  context,
                  "Select Vendor For",
                  "Select Vendor For",
                  isVenFor,
                  controller.txtVendorFor,
                  controller.fnService,
                  enable: false,
                  onTap: () {
                    _openVenForDialog(context, controller);
                  },
                ),
              ),
            ),
            const SizedBox(height: 15),

            Obx(
              () => Visibility(
                visible: userType == 2,
                child: setTextFieldDropReg(
                  context,
                  "Type Of Service",
                  "Select type of service",
                  isServiceType,
                  controller.txtService,
                  controller.fnService,
                  enable: false,
                  onTap: () {
                    _openServiceDialog(context, controller);
                  },
                ),
              ),
            ),
            const SizedBox(height: 15),
            setTextField(context, "Company Name", "Company Name", isCompanyName,
                txtCompanyName, fnCompanyName),
            //contact person
            const SizedBox(height: 15),
            setTextField(context, "Contact Person", "Enter Contact Person",
                isContactPerson, txtContactPerson, fnContactPerson),

            const SizedBox(height: 15),
            setTextField(context, "Phone Number", "Enter phone number", isPhone,
                txtPhone, fnPhone),
            const SizedBox(height: 15),
            if (isLoadingCountry)
              Center(
                child: SizedBox(
                  width: 24, // Adjust the width as needed
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
                    var CountryName = value;
                    selectedCountryId = arrCountry
                        .firstWhere(
                          (info) => info.name == value,
                          orElse: () => Info(
                              id: '',
                              shortname: '',
                              name: '',
                              phonecode:
                                  ''), // provide default value if not found
                        )
                        .id!;
                    print(selectedCountryId);
                    fetchStates(selectedCountryId!);
                  });
                },
              ),
            const SizedBox(height: 15),
            if (isLoadingState)
              Center(
                child: SizedBox(
                  width: 24, // Adjust the width as needed
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
                    var stateName = value;
                    selectedStateId = arrState
                        .firstWhere(
                          (info) => info.name == value,
                          orElse: () => StateInfo(
                              id: '',
                              name: ''), // provide default value if not found
                        )
                        .id!;
                    print(selectedStateId);
                    fetchCities(selectedStateId!);
                  });
                },
              ),
            const SizedBox(height: 15),
            if (isLoadingCity)
              Center(
                child: SizedBox(
                  width: 24, // Adjust the width as needed
                  height: 24, // Adjust the height as needed
                  child: CircularProgressIndicator(
                    strokeWidth: 2, // Adjust the thickness of the indicator
                  ),
                ),
              ),
            if (!isLoadingCity && arrCity.isNotEmpty)
              setDropDown(context, "City", "Select city", isCity,
                  arrCity.map((info) => info.name ?? '').toList(),
                  (String? value) {
                setState(() {
                  var cityName = value!;
                  selectedCityId = arrCity
                      .firstWhere(
                        (info) => info.name == value,
                        orElse: () => CityInfo(
                            id: '',
                            name: ''), // provide default value if not found
                      )
                      .id!;
                });
              }),
            const SizedBox(height: 15),
            Stack(
              children: [
                // Address Input Field
                setTextFormField(
                    context, "Address", "Enter address", isAdd, txtAdd, fnAdd),
                // Location Icon Button
                Positioned(
                  right: 0, // Align to the right
                  top: 0, // Align to the top of the field
                  bottom: 0, // Align to the bottom of the field
                  child: GestureDetector(
                    onTap: () {
                      controller.fetchCurrentLocation(txtAdd);
                    },
                    child: Image.asset(
                      'assets/images/progess.gif',
                      width: 100, // Set the width of the GIF
                      height: 100, // Set the height of the GIF
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),
            if (userType == 2)
              setTextFieldDropReg(
                context,
                "Working Hour",
                "Working Hour",
                isWorkingHour,
                txtWorkingHours,
                fnWorkingHour,
                enable: false,
                onTap: () {
                  _openServiceDialogWorking(context, txtWorkingHours);
                },
              )
            else
              setDropdownField(
                context,
                "Authorization",
                prices,
                selectedPrice,
                (value) {
                  setState(() {
                    selectedPrice = value ?? "\$500";
                  });
                },
              ),
            const SizedBox(height: 15),
            setTextField(
                context, "Email", "Enter email", isEmail, txtEmail, fnEmail),
            const SizedBox(height: 15),
            Obx(
              () => setTextField(context, "Password", "Enter Password",
                  isPassword, txtPassword, fnPassword,
                  surfix: setIconButton(
                    () => onVisibilityTap(!isSecure.value),
                    Icon(
                      isSecure.value ? Icons.visibility_off : Icons.visibility,
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
                  () => {register()},
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

  Future<File> getDefaultImageFile() async {
    // Load the asset as a byte array
    final byteData =
        await rootBundle.load('assets/images/road_repair_service_1.png');

    // Get a temporary directory
    final tempDir = await getTemporaryDirectory();

    // Create a temporary file for the asset
    final tempFile = File('${tempDir.path}/road.png');

    // Write the asset data to the temporary file
    await tempFile.writeAsBytes(byteData.buffer.asUint8List());

    return tempFile;
  }

  void _openVenForDialog(BuildContext context, RegisterController controller) {
    List<String> selectedVenFor = controller.txtVendorFor.text.isNotEmpty
        ? controller.txtVendorFor.text.split(', ')
        : [];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text("Select Vendor For"),
              content: SingleChildScrollView(
                child: Column(
                  children: arrVenFor.map((venFor) {
                    return CheckboxListTile(
                      title: Text(venFor),
                      value: selectedVenFor.contains(venFor),
                      onChanged: (bool? isChecked) {
                        setState(() {
                          if (isChecked == true) {
                            if (!selectedVenFor.contains(venFor)) {
                              selectedVenFor.add(venFor);
                            }
                          } else {
                            selectedVenFor.remove(venFor);
                          }
                        });
                        // Update the text in the controller
                        controller.txtVendorFor.text = selectedVenFor.join(', ');
                        vendorFor = selectedVenFor.join(', ');
                        controller.update(); // Reflect changes in the parent UI
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: const Text("Save"),
                ),
              ],
            );
          },
        );
      },
    );
  }


  void _openServiceDialog(BuildContext context, RegisterController controller) {
    List<String> selectedServices = controller.txtService.text.isNotEmpty
        ? controller.txtService.text.split(', ')
        : [];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text("Select Type of Service"),
              content: SingleChildScrollView(
                child: Column(
                  children: arrServiceType.map((service) {
                    return CheckboxListTile(
                      title: Text(service),
                      value: selectedServices.contains(service),
                      onChanged: (bool? isChecked) {
                        setState(() {
                          if (isChecked == true) {
                            if (!selectedServices.contains(service)) {
                              selectedServices.add(service);
                            }
                          } else {
                            selectedServices.remove(service);
                          }
                        });
                        // Update the text in the controller
                        controller.txtService.text =
                            selectedServices.join(', ');
                        typeOfService = selectedServices.join(', ');
                        controller.update(); // Reflect changes in the parent UI
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: const Text("Save"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _openServiceDialogWorking(BuildContext context, TextEditingController controller) {
    bool is24x7 = false;
    List<String> daysOfWeek = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    Map<String, bool> selectedDays = {
      for (var day in daysOfWeek) day: false,
    };

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Select Working Hours'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text('24x7'),
                    leading: Radio<bool>(
                      value: true,
                      groupValue: is24x7,
                      onChanged: (value) {
                        setState(() {
                          is24x7 = value!;
                          if (is24x7) {
                            selectedDays.updateAll((key, value) => false);
                          }
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Select Days'),
                    leading: Radio<bool>(
                      value: false,
                      groupValue: is24x7,
                      onChanged: (value) {
                        setState(() {
                          is24x7 = value!;
                        });
                      },
                    ),
                  ),
                  if (!is24x7)
                    ...daysOfWeek.map((day) {
                      return CheckboxListTile(
                        title: Text(day),
                        value: selectedDays[day],
                        onChanged: (value) {
                          setState(() {
                            selectedDays[day] = value!;
                          });
                        },
                      );
                    }).toList(),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    // Handle the selection logic
                    if (is24x7) {
                      controller.text = '24x7';
                    } else {
                      var selected = selectedDays.entries
                          .where((entry) => entry.value)
                          .map((entry) => entry.key)
                          .toList();
                      controller.text = selected.isEmpty
                          ? 'No days selected'
                          : selected.join(', ');
                    }
                    Navigator.of(context).pop();
                  },
                  child: const Text('Confirm'),
                ),
              ],
            );
          },
        );
      },
    );
  }

}


