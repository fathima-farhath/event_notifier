import 'package:event_notifier/screens/feed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'feed.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool _isEmailValid = true;
  bool _isPasswordValid = true;

  bool validateForm() {
    bool isValid = true;

    // Validate each form field
    if (emailController.text.isEmpty) {
      setState(() => _isEmailValid = false);
      isValid = false;
    } else {
      setState(() => _isEmailValid = true);
    }

    if (passwordController.text.isEmpty) {
      setState(() => _isPasswordValid = false);
      isValid = false;
    } else {
      setState(() => _isPasswordValid = true);
    }
    return isValid;
  }

  Future<bool> checkCredentials(String email, String password) async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('Student').get();

    final users = querySnapshot.docs;

    for (var userSnapshot in users) {
      final userData = userSnapshot.data();
      final dbEmail = userData['email'];
      final dbPassword = userData['password'];

      if (email == dbEmail && password == dbPassword) {
        // Credentials match
        FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyFeed()),
        );
        return true;
      }
    }

    // Credentials do not match
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid Credentials'),
          content: Text('The email and password do not match.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the alert dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
    return false;
  }

  // void login() async {
  //   final email = emailController.text;
  //   final password = passwordController.text;

  //   bool isValidCredentials = await checkCredentials(email, password);

  //   if (isValidCredentials) {
  //     //credentials are valid, proceed to login
  //     FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: emailController.text.trim(),
  //       password: passwordController.text.trim(),
  //     );
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => MyFeed()),
  //     );
  //   } else {
  //     // Credentials are invalid, show an alert
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Invalid Credentials'),
  //           content: Text('The email and password do not match.'),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context); // Close the alert dialog
  //               },
  //               child: Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  'Sign In',
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.blue.withOpacity(.9),
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .8,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                controller: emailController,
                onChanged: (value) {
                  setState(() {
                    _isEmailValid = true;
                  });
                },
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                    hintText: 'Enter Cusat email',
                    errorText:
                        !_isEmailValid ? 'Please enter a valid email' : null,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .8,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                controller: passwordController,
                onChanged: (value) {
                  setState(() {
                    _isPasswordValid = true;
                  });
                },
                obscureText: true,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                    hintText: 'Password',
                    errorText: !_isPasswordValid
                        ? 'Please enter a valid password'
                        : null,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    )),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                        color:
                            Color.fromARGB(255, 33, 134, 206).withOpacity(.9),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyFeed()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Set background color to white
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.05,
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white, // Set text color to blue
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.25,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}