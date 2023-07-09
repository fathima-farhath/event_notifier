import 'feedAdmin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginUIa extends StatefulWidget {
  const LoginUIa({super.key});

  @override
  State<LoginUIa> createState() => _LoginUIaState();
}

class _LoginUIaState extends State<LoginUIa> {
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

  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Login successful, navigate to home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminScreen()),
      );
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
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  'Login to Access',
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.indigo,
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
                    hintText: 'Enter email',
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
                      '',
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
                login(emailController.text.trim(),
                    passwordController.text.trim(), context);
              },
              style: ElevatedButton.styleFrom(
                  // Set background color to white
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
