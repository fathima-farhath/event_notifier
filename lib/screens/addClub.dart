import 'package:cloud_firestore/cloud_firestore.dart';
import 'loginStud.dart';
import 'package:firebase_auth/firebase_auth.dart';
//mport 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'viewClub.dart';

class createClub extends StatefulWidget {
  const createClub({super.key});

  @override
  State<createClub> createState() => _createClubState();
}

class _createClubState extends State<createClub> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phnoController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confpasswordController = TextEditingController();
  final _dept = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phnoController.dispose();
    _passwordController.dispose();
    _confpasswordController.dispose();
    _dept.dispose();
    super.dispose();
  }

  //form validation

  bool _isUsernameValid = true;
  bool _isEmailValid = true;
  bool _isPhoneNumberValid = true;
  bool _isPasswordValid = true;
  bool _isConfirmPasswordValid = true;
  bool _isDeptValid = true;

  bool validateForm() {
    bool isValid = true;

    // Validate each form field

    if (_dept.text.isEmpty) {
      setState(() => _isDeptValid = false);
      isValid = false;
    } else {
      setState(() => _isDeptValid = true);
    }
    if (_usernameController.text.isEmpty) {
      setState(() => _isUsernameValid = false);
      isValid = false;
    } else {
      setState(() => _isUsernameValid = true);
    }

    if (!_emailController.text.endsWith('@gmail.com')) {
      setState(() => _isEmailValid = false);
      isValid = false;
    } else {
      setState(() => _isEmailValid = true);
    }

    if (_phnoController.text.length != 10) {
      setState(() => _isPhoneNumberValid = false);
      isValid = false;
    } else {
      setState(() => _isPhoneNumberValid = true);
    }

    if (_passwordController.text.isEmpty ||
        _passwordController.text.length < 6) {
      setState(() => _isPasswordValid = false);
      isValid = false;
    } else {
      setState(() => _isPasswordValid = true);
    }

    if (_confpasswordController.text.isEmpty ||
        _confpasswordController.text != _passwordController.text) {
      setState(() => _isConfirmPasswordValid = false);
      isValid = false;
    } else {
      setState(() => _isConfirmPasswordValid = true);
    }

    return isValid;
  }

  Future signUp() async {
    //authenticating
    try {
      if (passwordConfirmed()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        //add user to database
        addUserDetails(
          _usernameController.text.trim(),
          _emailController.text.trim(),
          int.parse(_phnoController.text.trim()),
          _dept.text.trim(),
          _passwordController.text.trim(),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DepartmentListPage()),
        );
      }
    } catch (error) {
      // Handle any exceptions here
      print('Error during sign up: $error');
    }
  }

  //adding to firebase

  Future addUserDetails(String username, String email, int phno, String dept,
      String password) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('Club').doc(userId).set({
      'name': username,
      'email': email,
      'Phno': phno.toString(),
      'dept': dept,
      'password': password,
    });
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() ==
        _confpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 250, 255),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(12),
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  'Create a new Club',
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.blue.withOpacity(.9),
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .8,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                controller: _dept,
                onChanged: (value) {
                  setState(() {
                    _isDeptValid = true;
                  });
                },
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                    hintText: 'Club Name',
                    errorText: !_isDeptValid
                        ? 'Please enter a valid phone number'
                        : null,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //username
            Container(
              width: MediaQuery.of(context).size.width * .8,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                controller: _usernameController,
                onChanged: (value) {
                  setState(() {
                    _isUsernameValid = true;
                  });
                },
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                    hintText: 'Name of Club Secratary ',
                    errorText: !_isUsernameValid
                        ? 'Please enter a valid username'
                        : null,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .8,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                controller: _emailController,
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
                    hintText: 'Club official email',
                    errorText:
                        !_isEmailValid ? 'Please enter a valid email' : null,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .8,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                controller: _phnoController,
                onChanged: (value) {
                  setState(() {
                    _isPhoneNumberValid = true;
                  });
                },
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                    hintText: 'Club Contact Number',
                    errorText: !_isPhoneNumberValid
                        ? 'Please enter a valid phone number'
                        : null,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            Container(
              width: MediaQuery.of(context).size.width * .8,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                controller: _passwordController,
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
                    hintText: 'Create password',
                    errorText: !_isPasswordValid
                        ? 'Please enter a strong password'
                        : null,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .8,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                controller: _confpasswordController,
                onChanged: (value) {
                  setState(() {
                    _isConfirmPasswordValid = true;
                  });
                },
                obscureText: true,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                    hintText: 'Confirm password',
                    errorText: !_isConfirmPasswordValid
                        ? 'Passwords do not match'
                        : null,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    )),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                if (validateForm()) {
                  signUp();
                }
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
                    'Register',
                    style: TextStyle(
                      color: Colors.white, // Set text color to blue
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.25,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 1,
            ),

            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
