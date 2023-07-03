import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'notifications.dart';
import 'readevent.dart';
import 'login.dart';
import 'editprofile.dart';
import 'resetpass.dart';
import 'typeofuser.dart';

class MyFeed extends StatefulWidget {
  const MyFeed({super.key});

  @override
  State<MyFeed> createState() => _MyFeedState();
}

class _MyFeedState extends State<MyFeed> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    DateTime datetime = DateTime.now();
    String datetime4 =
        DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY).format(datetime);
    print(datetime4);
    return Scaffold(
      appBar: AppBar(
        title: Text("Eventify"),
        elevation: 10,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyNotifications()));
              },
              icon: Icon(Icons.notifications_active)),
          IconButton(onPressed: () {}, icon: Icon(Icons.event_available))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                "Aavani P K",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(user.email!, style: TextStyle(fontSize: 17)),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 7, 25, 127),
              ),
              currentAccountPicture: CircleAvatar(
                child: Text(
                  "A",
                  style: TextStyle(
                    color: Color.fromARGB(255, 7, 25, 127),
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.white,
                radius: 100,
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 49, 120, 242),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(40))),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Semester: IV",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Department: Information Technology",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Gender: Female",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Phone no: 9496035580",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfilePage()),
                    );
                  },
                  icon: Icon(Icons.edit_sharp)),
              title: Text("Edit Profile"),
            ),
            ListTile(
              leading: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResetScreen()),
                    );
                  },
                  icon: Icon(Icons.password_outlined)),
              title: Text("Reset Password"),
            ),
            // ListTile(
            //   leading:IconButton(onPressed: (){}, icon: Icon(Icons.dashboard)),
            //   title: Text("Go to dashboard"),
            // ),
            ListTile(
              leading: IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ScreenUser()),
                    );
                  },
                  icon: Icon(Icons.logout)),
              title: Text("SignOut"),
            )
          ],
        ),
      ),
      body: ListView(children: [
        Container(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(80)),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromARGB(255, 5, 29, 163),
                        Color.fromARGB(255, 149, 107, 228),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(5, 10),
                        blurStyle: BlurStyle.outer,
                        blurRadius: 10,
                        color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.9),
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("\" Never miss a Single Event \"",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "All the Event \nNotification at one Place",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.add_a_photo_sharp, color: Colors.white),
                          Row(
                            children: [
                              Icon(Icons.date_range, color: Colors.white),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                datetime4,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Upcoming Events",
                style: TextStyle(
                  color: Color.fromARGB(255, 29, 31, 142),
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              new GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EventRead()));
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10.0,
                      )
                    ],
                    color: Colors.indigo[300],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                        topRight: Radius.circular(0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        // height: 175,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                              topRight: Radius.circular(0)),
                          child: Image.asset(
                            'images/event1.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ME WARRIOR 2023",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  "Mind Empowered",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 3, 15, 5),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              "India's Biggest Women only Talk show is on the way at our own Cusat. stay tuned...",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 3, 15, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Icon(Icons.date_range,
                                          color: Colors.white, size: 35.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("13/07/2023",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.0,
                                              )),
                                          Text("Monday",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                              width: 175.0,
                              child: Row(
                                children: [
                                  Icon(Icons.location_on_outlined,
                                      color: Colors.white, size: 35.0),
                                  Expanded(
                                    child: Text(
                                      "SOE Auditorium,IT block",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              new GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EventRead()));
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10.0,
                      )
                    ],
                    color: Colors.indigo[300],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                        topRight: Radius.circular(0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        // height: 175,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                              topRight: Radius.circular(0)),
                          child: Image.asset(
                            'images/event2.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ME WARRIOR 2023",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  "Mind Empowered",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 3, 15, 5),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              "India's Biggest Women only Talk show is on the way at our own Cusat. stay tuned...",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 3, 15, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Icon(Icons.date_range,
                                          color: Colors.white, size: 35.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("13/07/2023",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.0,
                                              )),
                                          Text("Monday",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                              width: 175.0,
                              child: Row(
                                children: [
                                  Icon(Icons.location_on_outlined,
                                      color: Colors.white, size: 35.0),
                                  Expanded(
                                    child: Text(
                                      "SOE Auditorium,IT block",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.calendar_month, color: Colors.white),
      ),
    );
  }
}
