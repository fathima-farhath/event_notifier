import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'feedHOD.dart';
import 'feedTeach.dart';
import 'feedStud.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String userEmail = FirebaseAuth.instance.currentUser!.email!;

  @override
  void initState() {
    super.initState();
    fetchUserData();
    // usernameController.text = 'John Doe'; // Initial value for username
    // phoneNumberController.text = '1234567890';
    emailController.text = userEmail;
  }

  Future<void> fetchUserData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      String userId = currentUser.uid;

      DocumentSnapshot<Map<String, dynamic>> studentSnapshot =
          await FirebaseFirestore.instance
              .collection('Student')
              .doc(userId)
              .get();
      DocumentSnapshot<Map<String, dynamic>> teacherSnapshot =
          await FirebaseFirestore.instance
              .collection('Teacher')
              .doc(userId)
              .get();
      DocumentSnapshot<Map<String, dynamic>> departmentSnapshot =
          await FirebaseFirestore.instance
              .collection('Department')
              .doc(userId)
              .get();
      DocumentSnapshot<Map<String, dynamic>> clubSnapshot =
          await FirebaseFirestore.instance.collection('Club').doc(userId).get();

      if (studentSnapshot.exists) {
        Map<String, dynamic> studentData = studentSnapshot.data()!;
        setState(() {
          usernameController.text = studentData['username'] ?? '';
          phoneNumberController.text = studentData['Phno'] ?? '';
        });
      } else if (teacherSnapshot.exists) {
        Map<String, dynamic> teacherData = teacherSnapshot.data()!;
        setState(() {
          usernameController.text = teacherData['username'] ?? '';
          phoneNumberController.text = teacherData['Phno'] ?? '';
        });
      } else if (departmentSnapshot.exists) {
        Map<String, dynamic> departmentData = departmentSnapshot.data()!;
        setState(() {
          usernameController.text = departmentData['name'] ?? '';
          phoneNumberController.text = departmentData['Phno'] ?? '';
        });
      } else if (clubSnapshot.exists) {
        Map<String, dynamic> clubData = clubSnapshot.data()!;
        setState(() {
          usernameController.text = clubData['name'] ?? '';
          phoneNumberController.text = clubData['Phno'] ?? '';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            goTofeed(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.indigo,
              child: Text(
                usernameController.text.isNotEmpty
                    ? usernameController.text[0].toUpperCase()
                    : '',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Cusat Email ',
              ),
            ),
            SizedBox(height: 4),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'This email cannot be edited',
                style: TextStyle(
                  fontSize: 12,
                  color: const Color.fromARGB(255, 236, 7, 7),
                ),
              ),
            ),
            SizedBox(height: 0),
            ElevatedButton(
              onPressed: () {
                // Perform save/update logic here
                String username = usernameController.text;
                String phoneNumber = phoneNumberController.text;
                print('Username: $username');
                print('Phone Number: $phoneNumber');

                updateProfile(username, phoneNumber);
                goTofeed(context);
                ;
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void updateProfile(String username, String phoneNumber) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      String userId = currentUser.uid;

      //if student
      final studentDoc = await FirebaseFirestore.instance
          .collection('Student')
          .doc(userId)
          .get();
      if (studentDoc.exists) {
        try {
          await FirebaseFirestore.instance
              .collection('Student')
              .doc(userId)
              .update({
            'username': username,
            'Phno': phoneNumber,
          });

          // Fields updated successfully
          print('Profile data updated successfully!');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Profile updated successfully'),
            ),
          );
        } catch (e) {
          // Error occurred while updating fields
          print('Error updating profile data: $e');
        }
      }

      //if teacher
      final teachDoc = await FirebaseFirestore.instance
          .collection('Teacher')
          .doc(userId)
          .get();
      if (teachDoc.exists) {
        try {
          await FirebaseFirestore.instance
              .collection('Teacher')
              .doc(userId)
              .update({
            'username': username,
            'Phno': phoneNumber,
          });

          // Fields updated successfully
          print('Profile data updated successfully!');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Profile updated successfully'),
            ),
          );
        } catch (e) {
          // Error occurred while updating fields
          print('Error updating profile data: $e');
        }
      }

      //if club
      final clubDoc =
          await FirebaseFirestore.instance.collection('Club').doc(userId).get();

      if (clubDoc.exists) {
        print("Club");
        try {
          await FirebaseFirestore.instance
              .collection('Club')
              .doc(userId)
              .update({
            'name': username,
            'P hno': phoneNumber,
          });

          // Fields updated successfully
          print('Profile data updated successfully!');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Profile updated successfully'),
            ),
          );
        } catch (e) {
          // Error occurred while updating fields
          print('Error updating profile data: $e');
        }
      }

      //if hod
      final hodDoc = await FirebaseFirestore.instance
          .collection('Department')
          .doc(userId)
          .get();
      if (hodDoc.exists) {
        try {
          await FirebaseFirestore.instance
              .collection('Department')
              .doc(userId)
              .update({
            'name': username,
            'Phno': phoneNumber,
          });

          // Fields updated successfully
          print('Profile data updated successfully!');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Profile updated successfully'),
            ),
          );
        } catch (e) {
          // Error occurred while updating fields
          print('Error updating profile data: $e');
        }
      }
    }
  }
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

      final clubDoc =
          await FirebaseFirestore.instance.collection('Club').doc(userId).get();
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
