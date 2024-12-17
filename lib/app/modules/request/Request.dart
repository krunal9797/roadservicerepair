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
            setTextField(
              context,
              "Service",
              "Enter Service",
              controller.isService,
              controller.txtService,
              controller.fnService,

            ),
            const SizedBox(height: 15),
            setTextField(
              context,
              "Service For",
              "Enter Service For",
              controller.isServiceFor,
              controller.txtServiceFor,
              controller.fnServiceFor,
            ),
            const SizedBox(height: 15),
            setTextField(
              context,
              "Type",
              "Enter Type",
              controller.isType,
              controller.txtType,
              controller.fnType,
            ),
            const SizedBox(height: 15),
            setTextField(
              context,
              "Name",
              "Enter Name",
              controller.isName,
              controller.txtName,
              controller.fnName,
            ),
            const SizedBox(height: 15),
            setTextField(
              context,
              "Unit Number",
              "Enter Unit Number",
              controller.isUnitNumber,
              controller.txtUnitNumber,
              controller.fnUnitNumber,
            ),
            const SizedBox(height: 15),
            setTextField(
              context,
              "Driver Number",
              "Enter Driver Number",
              controller.isDriverNumber,
              controller.txtDriverNumber,
              controller.fnDriverNumber,
            ),
            const SizedBox(height: 15),
            setTextField(
              context,
              "Address",
              "Enter Address",
              controller.isAddress,
              controller.txtAddress,
              controller.fnAddress,
            ),
            const SizedBox(height: 15),
            setTextField(
              context,
              "Remark",
              "Enter Remark",
              controller.isRemark,
              controller.txtRemark,
              controller.fnRemark,
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
                  setSemiText("Send Now", AppColors.whiteText, 16),
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
