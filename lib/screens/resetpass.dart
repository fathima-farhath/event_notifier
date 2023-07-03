// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class ResetScreen extends StatefulWidget {
//   @override
//   _ResetScreenState createState() => _ResetScreenState();
// }

// class _ResetScreenState extends State<ResetScreen> {
//   String _email = '';
//   final auth = FirebaseAuth.instance;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Reset Password'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               keyboardType: TextInputType.emailAddress,
//               decoration: InputDecoration(hintText: 'Email'),
//               onChanged: (value) {
//                 setState(() {
//                   _email = value.trim();
//                 });
//               },
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               ElevatedButton(
//                 child: Text('Send Request'),
//                 onPressed: () {
//                   auth.sendPasswordResetEmail(email: _email);
//                   Navigator.of(context).pop();
//                 },
//                 style: ElevatedButton.styleFrom(
//                   primary: Theme.of(context).colorScheme.secondary,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String? userEmail = user?.email;

    return Scaffold(
      appBar: AppBar(
        title: Text('Password Reset'),
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
}
