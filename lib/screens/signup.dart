import 'package:flutter/material.dart';
import 'login.dart';

class registerScreen extends StatefulWidget {
  const registerScreen({super.key});

  @override
  State<registerScreen> createState() => _registerScreenState();
}

class _registerScreenState extends State<registerScreen> {
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
            // Container(
            //   height: MediaQuery.of(context).size.height,
            //   width: MediaQuery.of(context).size.width,
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage(
            //         'images/bell.png'
            //       )
            //     )
            //   ),
            // ),

            SizedBox(
              height: 10,
            ),
            //username
            Container(
              width: MediaQuery.of(context).size.width * .8,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: TextFormField(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                    hintText: 'Username',
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
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                    hintText: 'Cusat email',
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
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                    hintText: 'Phone number',
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
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  hintText: 'Department',
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
                onChanged: (value) {},
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: DropdownButtonFormField<String>(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  hintText: 'Semester',
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
                onChanged: (value) {},
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: DropdownButtonFormField<String>(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  hintText: 'Gender',
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
                onChanged: (value) {
                  // Handle gender selection here
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
                obscureText: true,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                    hintText: 'Create password',
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
                obscureText: true,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                    hintText: 'Confirm password',
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginUI()),
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
                        color:
                            Color.fromARGB(255, 12, 134, 199).withOpacity(.9),
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
