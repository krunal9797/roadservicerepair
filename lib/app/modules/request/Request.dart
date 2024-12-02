import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../../model/CityData.dart';
import '../../../model/Country.dart';
import '../../../model/StateData.dart';
import '../../constants/app_colors.dart';
import '../../push_notifications.dart';
import '../../utils/button_utl.dart';
import '../../utils/drop_down_utl.dart';
import '../../utils/text_field_utl.dart';
import '../../utils/text_utl.dart';
import 'Request_Controller.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingInBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handler background message ${message.messageId}");

  RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    PushNotification notifications = PushNotification(
      title: initialMessage.notification?.title ?? '',
      body: initialMessage.notification?.body ?? '',
      dataTitle: initialMessage.data['title'] ?? '',
      dataBody: initialMessage.data['body'] ?? '',
    );
    // You can handle the notification here
  }
}
class Request extends StatefulWidget {
  const Request({super.key});

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  final controller = Get.put(RequestController());
  int  _totalNotifications = 0;
  late PushNotification pushNotification;
  late FirebaseMessaging _messaging;

  void registerNotification()async{
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingInBackgroundHandler);

    NotificationSettings setting = await _messaging.requestPermission(
        alert: true,
        badge: true,
        provisional: false,
        sound: true
    );

    if(setting.authorizationStatus == AuthorizationStatus.authorized)
    {
      FirebaseMessaging.onMessage.listen((RemoteMessage message){
        print("Received Message : ${message.notification?.body}");

        PushNotification notifications = PushNotification(
          title: message.notification?.title ?? '',
          body: message.notification?.body ?? '',
          dataTitle: message.data['title'] ?? '',
          dataBody: message.data['body'] ?? '',
        );
        setState(() {
          pushNotification = notifications;
          _totalNotifications++;

        });

        if(pushNotification!=null)
        {
          showSimpleNotification(Text(notifications.title),subtitle: Text(notifications.body??''));
        }

      });
    }


  }
  //for handlening the notification in terminated state
  checkforInitialMessage() async{
    await Firebase.initializeApp();
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if(initialMessage !=null){

      PushNotification notifications = PushNotification(
        title: initialMessage.notification?.title ?? '',
        body: initialMessage.notification?.body ?? '',
        dataTitle: initialMessage.data['title'] ?? '',
        dataBody: initialMessage.data['body'] ?? '',
      );

      setState(() {
        pushNotification = notifications;
        _totalNotifications++;

      });
    }
  }

  @override
  void initState() {

    registerNotification();
    checkforInitialMessage();

    //for handling notification when app is in background but not terminated

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message){

      PushNotification notifications = PushNotification(
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
        dataTitle: message.data['title'] ?? '',
        dataBody: message.data['body'] ?? '',
      );

      setState(() {
        pushNotification = notifications;
        _totalNotifications++;

      });

    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.whiteText,
          title: Obx(() => setSemiText(controller.pageTitle.value, AppColors.titleText, 16)),
        ),
        backgroundColor: AppColors.primary,
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            setDropDown(
              context,
              "Select Service",
              "Select service type",
              controller.isServices,
              controller.arrServices,
              controller.onServiceSelect,
            ),
            const SizedBox(height: 15),
            Obx(
                  () => Visibility(
                visible: controller.selectedService.value == "Truck Repair",
                child: Column(
                  children: [
                    setDropDown(
                      context,
                      "Truck Make",
                      "Select type of Truck",
                      controller.isTruckMake,
                      controller.arrTruckMake,
                      controller.onTruckSelect,
                    ),
                    const SizedBox(height: 15),

                  ],
                ),
              ),
            ),

            Obx(
                  () => Visibility(
                visible: controller.selectedService.value == "Truck Tire",
                child: Column(
                  children: [
                    setDropDown(
                      context,
                      "Type of Tire",
                      "Select type of tire",
                      controller.isTypeOfTire,
                      controller.arrTypeOfTire,
                          (String? value) {
                        controller.truck_tire_type =value!;

                      },
                    ),
                    const SizedBox(height: 15),

                  ],
                ),
              ),
            ),
            Obx(
                  () => Visibility(
                visible: controller.selectedTruck.value == "Other",
                child: Column(
                  children: [
                    setTextField(
                      context,
                      "Other",
                      "Enter truck",
                      controller.isOtherMake,
                      controller.txtOtherMake,
                      controller.fnOtherMake,
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
            Obx(
                  () => Visibility(
                visible: controller.selectedService.value == "Trailer Tire",
                child: Column(
                  children: [
                    setTextField(
                      context,
                      "Tire size",
                      "Enter tire size",
                      controller.isTrialerTire,
                      controller.txtTrialerTire,
                      controller.fnTrialerTire,
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
            Obx(
                  () => Visibility(
                visible: controller.selectedService.value == "Towing",
                child: Column(
                  children: [
                    setDropDown(
                      context,
                      "Towing for",
                      "Select vehicle",
                      controller.isTowingSrv,
                      controller.arrTowingSrv,
                          (String? value) {
                        print("Towing for"+value.toString());
                        controller.towing_for =value!;

                      },
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
            setTextField(
              context,
              "VI Number.",
              "Enter Vi number",
              controller.isVi,
              controller.txtVi,
              controller.fnVi,
            ),
            const SizedBox(height: 15),
            setTextField1(
              context,
              "Mobile No.",
              "Enter mobile number",
              controller.isMobile,
              controller.txtMobile,
              controller.fnMobile,
            ),
            const SizedBox(height: 15),
            setTextField1(
              context,
              "Email",
              "Enter Email",
              controller.isEmail,
              controller.txtEmail,
              controller.fnEmail,
            ),
            const SizedBox(height: 15),
            Obx(() => controller.isLoadingCountry.value
                ?Center(
              child: SizedBox(
                width: 24,  // Adjust the width as needed
                height: 24, // Adjust the height as needed
                child: CircularProgressIndicator(
                  strokeWidth: 2, // Adjust the thickness of the indicator
                ),
              ),
            )
                : setDropDown(
                context,
                "Country",
                "Select country",
                controller.isCountry,
                controller.arrCountry.map((info) => info.name ?? '').toList(),

                    (String? value) {
                  setState(() {
                    var  CountryName = value;
                    controller.selectedCountryId = controller.arrCountry.firstWhere(
                          (info) => info.name == value,
                      orElse: () => Info(id: '', shortname: '', name: '', phonecode: ''), // provide default value if not found
                    ).id!;
                    print(controller.selectedCountryId);
                    controller.fetchStates(controller.selectedCountryId!);
                  });
                }
            )),
            const SizedBox(height: 15),
            Obx(() => controller.isLoadingState.value
                ? Center(
              child: SizedBox(
                width: 24,  // Adjust the width as needed
                height: 24, // Adjust the height as needed
                child: CircularProgressIndicator(
                  strokeWidth: 2, // Adjust the thickness of the indicator
                ),
              ),
            )
                :setDropDown(
                context,
                "State",
                "Select state",
                controller.isState,
                controller.arrState.map((info) => info.name ?? '').toList(),
                    (String? value) {
                  setState(() {
                    var stateName = value;
                    controller.selectedStateId = controller.arrState.firstWhere(
                          (info) => info.name == value,
                      orElse: () => StateInfo(id: '', name: ''), // provide default value if not found
                    ).id!;
                    print(controller.selectedStateId);
                    controller.fetchCities(controller.selectedStateId!);
                  });
                }

            )),
            const SizedBox(height: 15),
            Obx(() => controller.isLoadingCity.value
                ? Center(
              child: SizedBox(
                width: 24,  // Adjust the width as needed
                height: 24, // Adjust the height as needed
                child: CircularProgressIndicator(
                  strokeWidth: 2, // Adjust the thickness of the indicator
                ),
              ),
            )
                : setDropDown(
              context,
              "City",
              "Select city",
              controller.isCity,
              controller.arrCity.map((info) => info.name ?? '').toList(),
                  (String? value) {
                setState(() {
                  var  cityName = value;
                  controller.selectedCityId = controller.arrCity.firstWhere(
                        (info) => info.name == value,
                    orElse: () => CityInfo(id: '', name: ''), // provide default value if not found
                  ).id!;

                });
              },
            )),
            const SizedBox(height: 15),
            setTextFormField(
              context,
              "Your Location",
              "Enter your address",
              controller.isAdrs,
              controller.txtAdrs,
              controller.fnAdrs,
            ),
            const SizedBox(height: 15),
            setTextFormField(
              context,
              "Request Information",
              "Enter problem",
              controller.isReqInfo,
              controller.txtReqInfo,
              controller.fnReqInfo,
            ),
            const SizedBox(height: 30),
            Center(
              child: InkWell(
                onTap: () {
                  print('click');
                  controller.showImagePickerOption(context);
                },
                child: Obx(
                      () => controller.imagePath.value == null
                      ? Image.asset(
                    'assets/images/add.jpg',
                    width: 150,
                    height: 100,
                  )
                      : Image.file(
                    controller.imagePath.value as File ,
                    width: 150,
                    height: 100,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Obx(() {
                return controller.isLoading.value
                    ? CircularProgressIndicator()
                    : setButton(
                      () => controller.sendNow(context),
                  setSemiText("Send Now lll", AppColors.whiteText, 16),
                  AppColors.button,
                  200,
                  50,
                );
              }),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
