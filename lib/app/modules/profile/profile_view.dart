import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_support/overlay_support.dart';
import 'package:roadservicerepair/app/constants/app_colors.dart';
import 'package:roadservicerepair/app/utils/DataWidget.dart';
import 'package:roadservicerepair/app/utils/button_utl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/Api.dart';
import '../../push_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingInBackgroundHandler(
    RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handler background message ${message.messageId}");

  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

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
  String u_id = '';
  String type = '';
  String cust_type = '';
  String working_hours = '';
  String company_name = '';
  String contact_person = '';
  String authorization = '';
  String service_type = '';
  String mobile_no = '';
  String country_name = '';
  String state_name = '';
  String city_name = '';
  String address = '';
  String email = '';
  String image = '';
  String user_type = '';

  late SharedPreferences prefs;
  late FirebaseMessaging _messaging;
  int _totalNotifications = 0;
  late PushNotification pushNotification;



  void registerNotification() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingInBackgroundHandler);

    NotificationSettings setting = await _messaging.requestPermission(
        alert: true, badge: true, provisional: false, sound: true);

    if (setting.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
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

        if (pushNotification != null) {
          showSimpleNotification(Text(notifications.title),
              subtitle: Text(notifications.body ?? ''));
        }
      });
    }
  }

  //for handlening the notification in terminated state
  checkforInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
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

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
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

  getProfile() async {
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
          final data = jsonResponse['info'];
          print(data['image']);

          u_id = data['u_id'];
          type = data['type'];
          cust_type = data['cust_type'];
          working_hours = data['working_hours'];
          company_name = data['company_name'];
          contact_person = data['contact_person'];
          authorization = data['authorization'];
          service_type = data['service_type'];
          mobile_no = data['mobile_no'];
          country_name = data['country_name'];
          state_name = data['state_name'];
          city_name = data['city_name'];
          address = data['address'];
          email = data['email'];
          image = data['image'];
          user_type = data['user_type'];

          print("vendor");
          print(user_type == "2" ? true : false);
          print("customer");
          print(user_type == "1" ? true : false);
          print("dmin");
          print(user_type == "0" ? true : false);

          print("________________________________");
          print("vendor");
          print(user_type == 2 ? true : false);
          print("customer");
          print(user_type == 1 ? true : false);
          print("dmin");
          print(user_type == 0 ? true : false);

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
    setState(() {});
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
            backgroundImage: NetworkImage(image),
            backgroundColor: Colors.transparent,
          ),
        ),
        // Text("type "+user_type),
        const SizedBox(height: 20),
        DataWidget(
          label: "Type",
          phoneNumber: type,
          labelColor: AppColors.titleText,
          phoneNumberColor: AppColors.titleText,
          labelFontSize: 14,
          phoneNumberFontSize: 16,
        ),
        DataWidget(
          label: "Customer Type",
          phoneNumber: cust_type,
          labelColor: AppColors.titleText,
          phoneNumberColor: AppColors.titleText,
          labelFontSize: 14,
          phoneNumberFontSize: 16,
        ),

        //2 hoi to batavanu
        //service type

        //1 true than show false than hide

        DataWidget(
          label: "Working Hours",
          phoneNumber: working_hours,
          labelColor: AppColors.titleText,
          phoneNumberColor: AppColors.titleText,
          labelFontSize: 14,
          phoneNumberFontSize: 16,
          visible: user_type=="2"?true:false, // Equivalent to `visible: user_type == 2`
        ),

        DataWidget(
          label: "Company Name",
          phoneNumber: company_name,
          labelColor: AppColors.titleText,
          phoneNumberColor: AppColors.titleText,
          labelFontSize: 14,
          phoneNumberFontSize: 16,
        ),

        DataWidget(
          label: "Contact Person",
          phoneNumber: contact_person,
          labelColor: AppColors.titleText,
          phoneNumberColor: AppColors.titleText,
          labelFontSize: 14,
          phoneNumberFontSize: 16,
        ),

        DataWidget(
          label: "Authorization",
          phoneNumber: authorization,
          labelColor: AppColors.titleText,
          phoneNumberColor: AppColors.titleText,
          labelFontSize: 14,
          phoneNumberFontSize: 16,
          visible: user_type=="1"?true:false, // Equivalent to `visible: user_type == 2`
        ),

        DataWidget(
          label: "Service Type",
          phoneNumber: service_type,
          labelColor: AppColors.titleText,
          phoneNumberColor: AppColors.titleText,
          labelFontSize: 14,
          phoneNumberFontSize: 16,
          visible: user_type == "2" ? true : false,
        ),


        DataWidget(
          label: "Mobile No",
          phoneNumber: mobile_no,
          labelColor: AppColors.titleText,
          phoneNumberColor: AppColors.titleText,
          labelFontSize: 14,
          phoneNumberFontSize: 16,
        ),

        DataWidget(
          label: "Country Name",
          phoneNumber: country_name,
          labelColor: AppColors.titleText,
          phoneNumberColor: AppColors.titleText,
          labelFontSize: 14,
          phoneNumberFontSize: 16,
        ),
        DataWidget(
          label: "State Name",
          phoneNumber: state_name,
          labelColor: AppColors.titleText,
          phoneNumberColor: AppColors.titleText,
          labelFontSize: 14,
          phoneNumberFontSize: 16,
        ),

        DataWidget(
          label: "City Name",
          phoneNumber: city_name,
          labelColor: AppColors.titleText,
          phoneNumberColor: AppColors.titleText,
          labelFontSize: 14,
          phoneNumberFontSize: 16,
        ),

        DataWidget(
          label: "Address",
          phoneNumber: address,
          labelColor: AppColors.titleText,
          phoneNumberColor: AppColors.titleText,
          labelFontSize: 14,
          phoneNumberFontSize: 16,
        ),

        DataWidget(
          label: "Email",
          phoneNumber: email,
          labelColor: AppColors.titleText,
          phoneNumberColor: AppColors.titleText,
          labelFontSize: 14,
          phoneNumberFontSize: 16,
        ),

        DataWidget(
          label: "Email",
          phoneNumber: email,
          labelColor: AppColors.titleText,
          phoneNumberColor: AppColors.titleText,
          labelFontSize: 14,
          phoneNumberFontSize: 16,
        ),


        DataWidget(
          label: "Phone Number",
          phoneNumber: mobile_no,
          labelColor: AppColors.titleText,
          phoneNumberColor: AppColors.titleText,
          labelFontSize: 14,
          phoneNumberFontSize: 16,
        ),

        const SizedBox(height: 5),
        setTextButton(() {
          // Confirm before deleting
          Get.defaultDialog(
            title: "Delete Account",
            middleText: "Are you sure you want to delete your account?",
            textConfirm: "Yes",
            textCancel: "No",
            onConfirm: () {
              deleteAccount(); // Call the deleteAccount function
              Get.back(); // Close the dialog
            },
            onCancel: () {
              Get.back(); // Close the dialog
            },
          );
        }, Text("Delete Account")) // Wrap the string with Text widget
      ],
    );
  }

  Future<void> deleteAccount() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      // Check if 'u_id' is stored as int or string
      String? userId = prefs.getString('u_id'); // Try fetching it as a String

      if (userId == null) {
        // If not found as String, try as int
        int? userIdInt = prefs.getInt('u_id');
        userId = userIdInt?.toString(); // Convert int to String if necessary
      }

      // Ensure that userId is not null before proceeding
      if (userId == null) {
        Get.snackbar("Error", "User ID not found");
        return;
      }

      var request = http.Request(
          'POST',
          Uri.parse(
              'https://roadservice.roadservicerepair.com/api/delete_profile.php'));

      request.body = json.encode({
        "u_id": userId, // Pass the user ID as a string
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        print(responseBody);
        // Clear all SharedPreferences data
        await prefs.clear();
        prefs.setBool("isLogin", false);
        Get.back(); // Close the dialog
        Get.offAllNamed('/splash'); // Replace '/home' with your home route
        Get.snackbar("Success", "Account deleted successfully");
        // Optionally, navigate to another screen or clear user data here
      } else {
        print(response.reasonPhrase);
        Get.back(); // Close the dialog
        Get.snackbar(
            "Error", "Failed to delete account: ${response.reasonPhrase}");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", "An error occurred: ${e.toString()}");
    }
  }
}
