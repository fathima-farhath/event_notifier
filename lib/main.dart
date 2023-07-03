import 'package:flutter/material.dart';
// import 'screens/notifications.dart';
// import 'screens/readnotify.dart';
//import 'screens/otp.dart';
//import 'screens/feed.dart';
//import 'screens/typeofuser.dart';
// import 'screens/editevents.dart';
//import 'screens/editnotification.dart';
import 'screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Demo App",
      home: ScreenSplash(),
      theme: ThemeData(primarySwatch: Colors.indigo),
    );
  }
}
