import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'typeofuser.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'feed.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    gotoUser(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(147, 109, 132, 226),
          ),
          child: Center(
              child: Column(children: [
            const SizedBox(
              height: 80,
            ),
            const Text(
              'EVENT NOTIFIER',
              style: TextStyle(
                fontFamily: 'Kablammo',
                fontSize: 44,
              ),
            ),
            const SizedBox(
              height: 9,
            ),
            const Text(
              'All event notification at one place',
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'Monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            ClipPath(
              clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
              child: Image.asset(
                'images/splash.jfif',
                fit: BoxFit.cover,
                height: 200,
                width: 200,
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            const SpinKitWave(
              size: 90,
              color: Colors.white,
            ),
          ])),
        ),
      ),
    );
  }

  // Future<void> gotoUser() async {
  //   await Future.delayed(Duration(milliseconds: 1500));
  //  StreamBuilder<User?>(
  //       stream: FirebaseAuth.instance.authStateChanges(),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           return MyFeed();
  //         } else {
  //           return ScreenUser();
  //         }
  //       },
  //     ),
  // }

  Future<void> gotoUser(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 1500));
    FirebaseAuth auth = FirebaseAuth.instance;

    // Check if user is authenticated
    User? user = auth.currentUser;

    // Navigate to the appropriate page based on authentication status
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyFeed()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ScreenUser()),
      );
    }
  }
}
