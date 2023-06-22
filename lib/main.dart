import 'package:flutter/material.dart';
// import 'screens/notifications.dart';
// import 'screens/readnotify.dart';
// import 'screens/feed.dart';
// import 'screens/editevents.dart';
import 'screens/editnotification.dart';
import 'screens/splash.dart';

void main() {
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
