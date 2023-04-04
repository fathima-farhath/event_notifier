import 'package:flutter/material.dart';
import 'screens/feed.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Demo App",
      home:MyFeed(),
      theme: ThemeData(primarySwatch: Colors.indigo),
      );

  }
}