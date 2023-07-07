import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'feedHOD.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  String _username = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  // void _getUserData() async {
  //   try {
  //     final userId = _firebaseAuth.currentUser!.uid;
  //     final userDoc =
  //         await _firebaseFirestore.collection('Student').doc(userId).get();
  //     print("uid ");
  //     print(userId);

  //     // if (userDoc.exists) {
  //     //   setState(() {
  //     // _username = userDoc.get('sem') ?? '';
  //     var userData = userDoc.data();
  //     var username = userData!['username'];
  //     print(username);
  //     //     _email = userDoc.get('email') ?? '';
  //     //   });
  //     // }
  //   } catch (e) {
  //     print("error in fetching: $e");
  //   }
  // }

  void _getUserData() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        final userId = user.uid;
        final userDoc =
            await _firebaseFirestore.collection('Student').doc(userId).get();
        if (userDoc.exists) {
          setState(() {
            _username = userDoc.get('username');
            _email = userDoc.get('email');
          });
        } else {
          print("Document does not exist");
        }
      } else {
        print("User is not authenticated");
      }
    } catch (e) {
      print("Error in fetching: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyFeed(),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text("data"),
            SizedBox(height: 10),
            Text(_username, style: TextStyle(fontSize: 20)),
            Text(_email, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
