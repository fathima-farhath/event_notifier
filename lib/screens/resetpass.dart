import 'feedHOD.dart';
import 'feedStud.dart';
import 'feedTeach.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ResetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String? userEmail = user?.email;

    return Scaffold(
      appBar: AppBar(
        title: Text('Password Reset'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            goTofeed(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 140,
            ),
            Text("Send a request to registered email and reset your password"),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                if (userEmail != null) {
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: userEmail);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Password Reset Email Sent'),
                        content: Text(
                          'A password reset email has been sent to $userEmail. Please check your inbox and follow the instructions to reset your password.',
                        ),
                        actions: [
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Send Password Reset Email'),
            ),
          ],
        ),
      ),
    );
  }

  void goTofeed(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    // Check if user is authenticated
    User? user = auth.currentUser;
    try {
      if (user != null) {
        String userId = user.uid;

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
      }
    } catch (e) {
      print("error in moving: $e");
    }
  }
}
