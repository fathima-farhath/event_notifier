import 'package:event_notifier/screens/feedAdmin.dart';
import 'package:event_notifier/screens/feedStud.dart';
import 'package:event_notifier/screens/feedTeach.dart';
import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'typeofuser.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'feedHOD.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<void> gotoUser(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 3000));
    FirebaseAuth auth = FirebaseAuth.instance;

    // Check if user is authenticated
    User? user = auth.currentUser;
    try {
      if (user != null) {
        String userId = user.uid;

        final adminDoc = await FirebaseFirestore.instance
            .collection('admin')
            .doc(userId)
            .get();
        if (adminDoc.exists) {
          print("Admin");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminScreen()),
          );
        }

        final studentDoc = await FirebaseFirestore.instance
            .collection('Student')
            .doc(userId)
            .get();
        if (studentDoc.exists) {
          print("Student");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyFeeds()),
          );
        }

        final teachDoc = await FirebaseFirestore.instance
            .collection('Teacher')
            .doc(userId)
            .get();
        if (teachDoc.exists) {
          print("Teacher");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyFeedt()),
          );
        }

        final clubDoc = await FirebaseFirestore.instance
            .collection('Club')
            .doc(userId)
            .get();
        final hodDoc = await FirebaseFirestore.instance
            .collection('Department')
            .doc(userId)
            .get();
        if (clubDoc.exists || hodDoc.exists) {
          print("Club");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyFeed()),
          );
        }
      } else {
        // Navigate to the appropriate page based on authentication status and collection
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ScreenUser()),
        );
      }
    } catch (e) {
      print("error in moving: $e");
    }
  }
}
