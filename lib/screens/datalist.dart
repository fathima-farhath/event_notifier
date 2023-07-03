// import 'Studentsignup.dart';

// var data = [
//   {
//     "title": "Student",
//     "image": "images/student.png",
//     "loc": () => registerScreen()
//   },
//   {
//     "title": "Faculty",
//     "image": "images/teacher.png",
//     "loc": () => registerScreen()
//   },
//   {
//     "title": "Club",
//     "image": "images/others.jfif",
//     "loc": () => registerScreen()
//   },
// ];
//  children: [
//             UserAccountsDrawerHeader(
//               accountName: Text(
//                 "Aavani P K",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               accountEmail: Text(user.email!, style: TextStyle(fontSize: 17)),
//               decoration: BoxDecoration(
//                 color: Color.fromARGB(255, 7, 25, 127),
//               ),
//               currentAccountPicture: CircleAvatar(
//                 child: Text(
//                   "A",
//                   style: TextStyle(
//                     color: Color.fromARGB(255, 7, 25, 127),
//                     fontSize: 30.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 backgroundColor: Colors.white,
//                 radius: 100,
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                   color: Color.fromARGB(255, 49, 120, 242),
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(10),
//                       bottomLeft: Radius.circular(10),
//                       bottomRight: Radius.circular(10),
//                       topRight: Radius.circular(40))),
//               child: Padding(
//                 padding: const EdgeInsets.all(14.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Semester: IV",
//                       style: TextStyle(
//                         fontSize: 18.0,
//                         color: Color.fromARGB(255, 255, 255, 255),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 3,
//                     ),
//                     Text(
//                       "Department: Information Technology",
//                       style: TextStyle(
//                         fontSize: 18.0,
//                         color: Color.fromARGB(255, 255, 255, 255),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 3,
//                     ),
//                     Text(
//                       "Gender: Female",
//                       style: TextStyle(
//                         fontSize: 18.0,
//                         color: Color.fromARGB(255, 255, 255, 255),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 3,
//                     ),
//                     Text(
//                       "Phone no: 9496035580",
//                       style: TextStyle(
//                         fontSize: 18.0,
//                         color: Color.fromARGB(255, 255, 255, 255),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             ListTile(
//               leading: IconButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => EditProfilePage()),
//                     );
//                   },
//                   icon: Icon(Icons.edit_sharp)),
//               title: Text("Edit Profile"),
//             ),
//             ListTile(
//               leading: IconButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => ResetScreen()),
//                     );
//                   },
//                   icon: Icon(Icons.password_outlined)),
//               title: Text("Reset Password"),
//             ),
//             // ListTile(
//             //   leading:IconButton(onPressed: (){}, icon: Icon(Icons.dashboard)),
//             //   title: Text("Go to dashboard"),
//             // ),
//             ListTile(
//               leading: IconButton(
//                   onPressed: () {
//                     FirebaseAuth.instance.signOut();
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => LoginUI()),
//                     );
//                   },
//                   icon: Icon(Icons.logout)),
//               title: Text("SignOut"),
//             )
//           ],