//import 'package:event_notifier/screens/feed.dart';
import 'package:event_notifier/screens/resetpass.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'otp.dart';
//import 'feed.dart';

class hodLoginUI extends StatefulWidget {
  const hodLoginUI({super.key});

  @override
  State<hodLoginUI> createState() => _hodLoginUIState();
}

class _hodLoginUIState extends State<hodLoginUI> {
  final emailControllert = TextEditingController();
  final passwordControllert = TextEditingController();
  // final otpController = TextEditingController();
  EmailOTP myauth = EmailOTP();
  // late EmailAuth emailAuth;

  @override
  void dispose() {
    emailControllert.dispose();
    passwordControllert.dispose();
    super.dispose();
  }

  //sending otp
  void sendOTP() async {
    myauth.setConfig(
        appEmail: "fathimafarhana3491@gmail.com",
        appName: "Email OTP",
        userEmail: emailControllert.text,
        otpLength: 4,
        otpType: OTPType.digitsOnly);
    if (await myauth.sendOTP() == true) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("OTP has been sent"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Oops, OTP send failed"),
      ));
    }
  }

  bool _isEmailValid = true;
  bool _isPasswordValid = true;
  //validating login
  bool validateForm() {
    bool isValid = true;

    // Validate each form field
    if (emailControllert.text.isEmpty) {
      setState(() => _isEmailValid = false);
      isValid = false;
    } else {
      setState(() => _isEmailValid = true);
    }

    if (passwordControllert.text.isEmpty) {
      setState(() => _isPasswordValid = false);
      isValid = false;
    } else {
      setState(() => _isPasswordValid = true);
    }
    return isValid;
  }

  //checking if the email belongd to collection
  Future<bool> checkEmailBelongsToClub(String email) async {
    try {
      final clubSnapshot = await FirebaseFirestore.instance
          .collection('Club')
          .where('email', isEqualTo: emailControllert.text.trim())
          .limit(1)
          .get();

      final hodSnapshot = await FirebaseFirestore.instance
          .collection('Department')
          .where('email', isEqualTo: emailControllert.text.trim())
          .limit(1)
          .get();

      return clubSnapshot.size > 0 || hodSnapshot.size > 0;
    } catch (e) {
      print('Error checking email: $e');
      return false;
    }
  }

//login fucntion
  Future<void> login(
      String email, String password, BuildContext context) async {
    String email = emailControllert.text.trim();

    // Login successful, navigate to otp screen
    bool belongsToClubOrHod = await checkEmailBelongsToClub(email);

    if (belongsToClubOrHod) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailControllert.text.trim(),
          password: passwordControllert.text.trim(),
        );

        sendOTP();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => OtpScreen(
                      myauth: myauth,
                    )));
      } catch (e) {
        // Login failed, show error dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Failed'),
              content: Text(e.toString()),
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
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text("This email is not validated as the official email"),
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
      print("this email is not validated as the official email");
    }
  }

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
                controller: emailControllert,
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
                    hintText: 'Enter the Official email id',
                    labelText: 'Email',
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
                controller: passwordControllert,
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
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResetScreen(),
                          ));
                    },
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
                login(emailControllert.text.trim(),
                    passwordControllert.text.trim(), context);
              },
              // onPressed: () {
              //   FirebaseAuth.instance.signInWithEmailAndPassword(
              //     email: emailController.text.trim(),
              //     password: passwordController.text.trim(),
              //   );
              //   Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(builder: (context) => MyFeed()),
              //   );
              // },
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
