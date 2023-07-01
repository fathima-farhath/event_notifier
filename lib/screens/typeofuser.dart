// import 'package:flutter/material.dart';
// import 'signup.dart';

// class SettingItem {
//   final String title;
//   final String imagePath;
//   final VoidCallback onPressed;

//   SettingItem(
//       {required this.title, required this.imagePath, required this.onPressed});
// }

// class ScreenUser extends StatelessWidget {
//   final List<SettingItem> settingItems = [
//     SettingItem(
//       title: 'Profile',
//       imagePath: 'images/student.png',
//       onPressed: () {},
//     ),
//     SettingItem(
//       title: 'Notifications',
//       imagePath: 'images/student.png',
//       onPressed: () {
//         // Redirect to the notifications page
//         // Add your navigation logic here
//       },
//     ),
//     SettingItem(
//       title: 'Privacy',
//       imagePath: 'images/student.png',
//       onPressed: () {
//         // Redirect to the privacy page
//         // Add your navigation logic here
//       },
//     ),
//     SettingItem(
//       title: 'Help',
//       imagePath: 'images/student.png',
//       onPressed: () {
//         // Redirect to the help page
//         // Add your navigation logic here
//       },
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.only(top: 136.0),
//         child: GridView.builder(
//           itemCount: settingItems.length,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             childAspectRatio: 1.0,
//           ),
//           itemBuilder: (context, index) {
//             return GestureDetector(
//               onTap: settingItems[index].onPressed,
//               child: Card(
//                 elevation: 2.0,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       settingItems[index].imagePath,
//                       width: 80,
//                       height: 80,
//                     ),
//                     SizedBox(height: 8),
//                     Text(settingItems[index].title),
//                     SizedBox(height: 8),
//                     ElevatedButton(
//                       onPressed: settingItems[index].onPressed,
//                       child: Text('Go'),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'datalist.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'Studentsignup.dart';
import 'Teachersignup.dart';

class ScreenUser extends StatefulWidget {
  const ScreenUser({super.key});

  @override
  State<ScreenUser> createState() => _ScreenUserState();
}

class _ScreenUserState extends State<ScreenUser> {
  final List<Map<String, dynamic>> data = [
    {
      "title": "Student",
      "image": "images/student.png",
      "loc": () => registerScreen()
    },
    {
      "title": "Faculty",
      "image": "images/teacher.png",
      "loc": () => TeacherSignup()
    },
    {
      "title": "Club",
      "image": "images/others.jfif",
      "loc": () => registerScreen()
    },
  ];

  var listScrollController = new ScrollController();
  var scrollDirection = ScrollDirection.idle;

  @override
  void initState() {
    listScrollController.addListener(() {
      setState(() {
        scrollDirection = listScrollController.position.userScrollDirection;
      });
    });
    super.initState();
  }

  bool _scrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      setState(() {
        scrollDirection = ScrollDirection.idle;
      });
    }
    return true;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color.fromARGB(255, 243, 250, 255),
        body: Container(
          child: Center(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Select the User Type: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: 300,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: NotificationListener<ScrollNotification>(
                      onNotification: _scrollNotification,
                      child: ListView(
                        controller: listScrollController,
                        scrollDirection: Axis.horizontal,
                        children: data.map((item) {
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 100),
                            transform: Matrix4.rotationZ(
                                scrollDirection == ScrollDirection.forward
                                    ? 0.07
                                    : scrollDirection == ScrollDirection.reverse
                                        ? -0.07
                                        : 0),
                            width: 200,
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(147, 106, 136, 255),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(147, 109, 132, 226)
                                          .withOpacity(0.6),
                                      offset: Offset(-6, 4),
                                      blurRadius: 10)
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipPath(
                                  clipper: ShapeBorderClipper(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(110.0),
                                    ),
                                  ),
                                  child: Image.asset(
                                    item["image"].toString(),
                                    height: 100,
                                  ),
                                ),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 16)),
                                Text(
                                  item['title'].toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                  ),
                                  // onPressed: item['loc'].onPressed,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                // registerScreen()),
                                                item["loc"]!()));
                                  },
                                  child: Text('Lets go'),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
