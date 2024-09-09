import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:roadservicerepair/app/constants/app_colors.dart';
import 'package:roadservicerepair/app/modules/profile/profile_controller.dart';
import 'package:roadservicerepair/app/utils/text_utl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/Api.dart';
import '../../push_notifications.dart';

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


class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  String name='';
String number ='';
String address='';
String image='';
  late SharedPreferences prefs;
  late FirebaseMessaging _messaging;
  int  _totalNotifications = 0;
  late PushNotification pushNotification;

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
    // TODO: implement initState

     
    getProfile();
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
  

  getProfile( ) async {
    prefs = await SharedPreferences.getInstance();
    
    try {
      final response = await http.post(
        Uri.parse(Api.GET_PROFILE),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': prefs.getString('email'),


        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] != null && jsonResponse['status'] == 1) {
          final data= jsonResponse['info'];
          print(data['image']);

          name = data['name'];
          number =data['mobile_no'];
          address=data['address'];
          image=data['image'];




         // SharedPreferences prefs = await SharedPreferences.getInstance();
       //   prefs.setString('email', jsonResponse['info']['email'].toString());
         // print(jsonResponse['info']['email'].toString());

          // Parse the response and navigate to the next screen

        } else {
          // Handle error response
          Get.snackbar("Error", jsonResponse['msg']);
        }
      } else {
        Get.snackbar("Error", "Server error: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", "${e}An error occurred");
    }
    setState(() {

    });

  }
  @override
  Widget build(BuildContext context) {

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const SizedBox(height: 20),
              Center(
                child: CircleAvatar(
                  radius: 80.0,
                  backgroundImage:
                  NetworkImage(image),
                  backgroundColor: Colors.transparent,
                ),
              ),
              const SizedBox(height: 20),
              setSemiText("Name", AppColors.titleText, 14),
              const SizedBox(height: 5),
              setRegularText(name, AppColors.titleText, 16),
              const SizedBox(height: 20),
              setSemiText("Phone Number", AppColors.titleText, 14),
              const SizedBox(height: 5),
              setRegularText(number, AppColors.titleText, 16),
              const SizedBox(height: 20),
              setSemiText("Address", AppColors.titleText, 14),
              const SizedBox(height: 5),
              setRegularText(address, AppColors.titleText, 16),
            ],
          );

  }
}
