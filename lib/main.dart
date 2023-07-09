import 'package:flutter/material.dart';
import 'screens/splash.dart';
import 'screens/notifications.dart';
import 'screens/updateNotification.dart';
import 'screens/readnotify.dart';
import 'screens/addEvent.dart';
import 'screens/calendar.dart';
import 'screens/editevents.dart';
import 'screens/editnotification.dart';
import 'screens/demo.dart';
import 'screens/addNotification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/feedHOD.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //  FirebaseMessaging.instance.requestPermission();
  //  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   // Handle foreground messages
  //   print("Foreground Message: $message");
  // });
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // Handle the background message here
//   print("Handling background message: ${message.messageId}");

//   // Extract the notification data from the message
//   final notification = message.notification;
//   final data = message.data;

//   if (notification != null) {
//     // Handle the notification message
//     final title = notification.title;
//     final body = notification.body;
//     // Do something with the notification data
//     print("Notification - Title: $title, Body: $body");
//   }

//   if (data != null) {
//     // Handle the data message
//     // Do something with the data payload
//     print("Data: $data");
//   }
// }
// FirebaseMessaging messaging = FirebaseMessaging.instance;

// void requestNotificationPermission() async {
//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//   // Handle the notification permission response if needed
// }

// void getToken() async {
//   String? token = await messaging.getToken();
//   print(token);
//   // Use the token to send notifications to this device
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Demo App",
      home: ScreenSplash(),
      theme: ThemeData(primarySwatch: Colors.indigo),
    );
  }
}
