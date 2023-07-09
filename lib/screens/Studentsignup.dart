import 'package:cloud_firestore/cloud_firestore.dart';
import 'loginStud.dart';
import 'package:firebase_auth/firebase_auth.dart';
//mport 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class registerScreen extends StatefulWidget {
  const registerScreen({super.key});

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
  var _dept;
  var _sem;
  var _gender;

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phnoController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confpasswordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phnoController.dispose();
    _passwordController.dispose();
    _confpasswordController.dispose();
    super.dispose();
  }

  //form validation

  bool _isUsernameValid = true;
  bool _isEmailValid = true;
  bool _isPhoneNumberValid = true;
  bool _isPasswordValid = true;
  bool _isConfirmPasswordValid = true;
  bool _isDeptValid = true;
  bool _isSemValid = true;
  bool _isGenderValid = true;

  bool validateForm() {
    bool isValid = true;

    // Validate each form field
    if (_usernameController.text.isEmpty) {
      setState(() => _isUsernameValid = false);
      isValid = false;
    } else {
      setState(() => _isUsernameValid = true);
    }

    if (!_emailController.text.endsWith('@ug.cusat.ac.in')) {
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

    if (_dept.isEmpty) {
      setState(() => _isDeptValid = false);
      isValid = false;
    } else {
      setState(() => _isDeptValid = true);
    }

    if (_sem.isEmpty) {
      setState(() => _isSemValid = false);
      isValid = false;
    } else {
      setState(() => _isSemValid = true);
    }

    if (_gender.isEmpty) {
      setState(() => _isGenderValid = false);
      isValid = false;
    } else {
      setState(() => _isGenderValid = true);
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
            _gender,
            _dept,
            _sem);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginUI()),
        );
      }
    } catch (error) {
      // Handle any exceptions here
      print('Error during sign up: $error');
    }
  }

  //adding to firebase

  Future addUserDetails(String username, String email, int phno, String gender,
      String dept, String sem) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('Student').doc(userId).set({
      'username': username,
      'email': email,
      'Phno': phno.toString(),
      'gender': gender,
      'dept': dept,
      'sem': sem,
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
            Container(
              padding: EdgeInsets.all(12),
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  'Registration',
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.indigo,
                      fontWeight: FontWeight.w600),
                ),
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
                    hintText: 'Username',
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
                    hintText: 'Cusat email',
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
                    hintText: 'Phone number',
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
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: DropdownButtonFormField<String>(
                value: _dept,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  hintText: 'Department',
                  errorText:
                      !_isDeptValid ? 'Please select a department' : null,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                items: [
                  DropdownMenuItem<String>(
                    value: 'IT',
                    child: Text('IT'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'CS',
                    child: Text('CS'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'EC',
                    child: Text('EC'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'EEE',
                    child: Text('EEE'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'MECH',
                    child: Text('MECH'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'CIVIL',
                    child: Text('CIVIL'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'SF',
                    child: Text('SF'),
                  ),
                ],
                onChanged: (selectedDept) {
                  setState(() {
                    _dept = selectedDept;
                    _isDeptValid = true;
                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: DropdownButtonFormField<String>(
                value: _sem,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  hintText: 'Semester',
                  errorText: !_isSemValid ? 'Please select a semester' : null,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                items: [
                  DropdownMenuItem<String>(
                    value: 'Semester 1',
                    child: Text('Semester 1'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Semester 2',
                    child: Text('Semester 2'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Semester 3',
                    child: Text('Semester 3'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Semester 4',
                    child: Text('Semester 4'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Semester 5',
                    child: Text('Semester 5'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Semester 6',
                    child: Text('Semester 6'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Semester 7',
                    child: Text('Semester 7'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Semester 8',
                    child: Text('Semester 8'),
                  ),
                ],
                onChanged: (selectedSem) {
                  setState(() {
                    _sem = selectedSem;
                    _isSemValid = true;
                  });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: DropdownButtonFormField<String>(
                value: _gender,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  hintText: 'Gender',
                  errorText: !_isGenderValid ? 'Please select a gender' : null,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                items: [
                  DropdownMenuItem<String>(
                    value: 'Male',
                    child: Text('Male'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Female',
                    child: Text('Female'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Other',
                    child: Text('Other'),
                  ),
                ],
                onChanged: (selectedgen) {
                  setState(() {
                    _gender = selectedgen;
                    _isGenderValid = true;
                  });
                },
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
                primary: Colors.indigo, // Set background color to white
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
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginUI()),
                      );
                    },
                    child: Text(
                      'Already have an account? Log in',
                      style: TextStyle(
                        color: Color.fromARGB(255, 35, 97, 230).withOpacity(.9),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
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
