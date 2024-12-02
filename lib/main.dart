import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:roadservicerepair/app/modules/notification_service.dart';
import 'package:roadservicerepair/app/my_app.dart';
import 'package:roadservicerepair/app/push_notifications.dart';
import 'app/constants/util.dart';
import 'firebase_options.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Push Notifications and get the Firebase token
  await PushNotifications.init(); // Request notification permissions
  String? firebaseToken =
      await PushNotifications.getDeviceToken(); // Get the Firebase token

  if (firebaseToken != null) {
    fcmToken = firebaseToken.toString();
  }

  // Print the Firebase token (or use it as needed)
  print("Firebase Token: $firebaseToken");

  // Set up message handlers
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("Received Message: ${message.notification?.body}");
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingInBackgroundHandler);

  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingInBackgroundHandler(
    RemoteMessage message) async {
  // Firebase should already be initialized here since it is done in main
  print("Handler background message: ${message.messageId}");

  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    PushNotification notifications = PushNotification(
      title: initialMessage.notification?.title ?? '',
      body: initialMessage.notification?.body ?? '',
      dataTitle: initialMessage.data['title'] ?? '',
      dataBody: initialMessage.data['body'] ?? '',
    );
    // Handle the notification here
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
