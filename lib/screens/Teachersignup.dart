import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';
//mport 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class TeacherSignup extends StatefulWidget {
  const TeacherSignup({super.key});

  @override
  State<TeacherSignup> createState() => _TeacherSignupState();
}

class _TeacherSignupState extends State<TeacherSignup> {
  var dept;
  var gender;

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phnoController = TextEditingController();
  final passwordController = TextEditingController();
  final confpasswordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    phnoController.dispose();
    passwordController.dispose();
    confpasswordController.dispose();
    super.dispose();
  }

  //form validation

  bool isUsernameValid = true;
  bool isEmailValid = true;
  bool isPhoneNumberValid = true;
  bool isPasswordValid = true;
  bool isConfirmPasswordValid = true;
  bool isDeptValid = true;
  bool isGenderValid = true;

  bool validateForms() {
    bool isValid = true;

    // Validate each form field
    if (usernameController.text.isEmpty) {
      setState(() => isUsernameValid = false);
      isValid = false;
    } else {
      setState(() => isUsernameValid = true);
    }

    if (!emailController.text.endsWith('@cusat.ac.in')) {
      setState(() => isEmailValid = false);
      isValid = false;
    } else {
      setState(() => isEmailValid = true);
    }

    if (phnoController.text.length != 10) {
      setState(() => isPhoneNumberValid = false);
      isValid = false;
    } else {
      setState(() => isPhoneNumberValid = true);
    }

    if (dept.isEmpty) {
      setState(() => isDeptValid = false);
      isValid = false;
    } else {
      setState(() => isDeptValid = true);
    }

    // if (_sem.isEmpty) {
    //   setState(() => _isSemValid = false);
    //   isValid = false;
    // } else {
    //   setState(() => _isSemValid = true);
    // }

    if (gender.isEmpty) {
      setState(() => isGenderValid = false);
      isValid = false;
    } else {
      setState(() => isGenderValid = true);
    }

    if (passwordController.text.isEmpty) {
      setState(() => isPasswordValid = false);
      isValid = false;
    } else {
      setState(() => isPasswordValid = true);
    }

    if (confpasswordController.text.isEmpty ||
        confpasswordController.text != passwordController.text) {
      setState(() => isConfirmPasswordValid = false);
      isValid = false;
    } else {
      setState(() => isConfirmPasswordValid = true);
    }

    return isValid;
  }

  Future signUpp() async {
    //authenticating
    try {
      if (passwordConfirmed()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        //add user to database
        addUserDetails(
            usernameController.text.trim(),
            emailController.text.trim(),
            int.parse(phnoController.text.trim()),
            gender,
            dept);
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

//String gender,String dept, String sem,
  Future addUserDetails(String username, String email, int phno, String gender,
      String dept) async {
    await FirebaseFirestore.instance.collection('Teacher').add({
      'username': username,
      'email': email,
      'Phno': phno,
      'gender': gender,
      'dept': dept,
    });
  }

  bool passwordConfirmed() {
    if (passwordController.text.trim() == confpasswordController.text.trim()) {
      return true;
    } else {
      return false;
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
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  'Registration',
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
            //username
            Container(
              width: MediaQuery.of(context).size.width * .8,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                controller: usernameController,
                onChanged: (value) {
                  setState(() {
                    isUsernameValid = true;
                  });
                },
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                    hintText: 'Username',
                    errorText: !isUsernameValid
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
                controller: emailController,
                onChanged: (value) {
                  setState(() {
                    isEmailValid = true;
                  });
                },
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                    hintText: 'Cusat email',
                    errorText:
                        !isEmailValid ? 'Please enter a valid email' : null,
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
                controller: phnoController,
                onChanged: (value) {
                  setState(() {
                    isPhoneNumberValid = true;
                  });
                },
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                    hintText: 'Phone number',
                    errorText: !isPhoneNumberValid
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
                value: dept,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  hintText: 'Department',
                  errorText: !isDeptValid ? 'Please select a department' : null,
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
                    dept = selectedDept;
                    isDeptValid = true;
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
                value: gender,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  hintText: 'Gender',
                  errorText: !isGenderValid ? 'Please select a gender' : null,
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
                    gender = selectedgen;
                    isGenderValid = true;
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
                controller: passwordController,
                onChanged: (value) {
                  setState(() {
                    isPasswordValid = true;
                  });
                },
                obscureText: true,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                    hintText: 'Create password',
                    errorText: !isPasswordValid
                        ? 'Please enter a valid password'
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
                controller: confpasswordController,
                onChanged: (value) {
                  setState(() {
                    isConfirmPasswordValid = true;
                  });
                },
                obscureText: true,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                    hintText: 'Confirm password',
                    errorText: !isConfirmPasswordValid
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
                if (validateForms()) {
                  signUpp();
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
