import 'package:event_notifier/screens/feed.dart';
import 'package:flutter/material.dart';
import 'screens/notifications.dart';
import 'screens/updateNotification.dart';
import 'screens/readnotify.dart';
import 'screens/addEvent.dart';
import 'screens/calendar.dart';
import 'screens/feed.dart';
import 'screens/editevents.dart';
import 'screens/editnotification.dart';
import 'screens/demo.dart';
 import 'screens/addNotification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Demo App",
      home:MyFeed(),
      theme: ThemeData(primarySwatch: Colors.indigo),
      );

  }
}