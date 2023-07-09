import 'package:badges/badges.dart' as badges;
import 'package:event_notifier/screens/addNotification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'notifications.dart';
import 'addNotification.dart';
import 'addEvent.dart';
import 'editnotification.dart';
import 'readevent.dart';
import 'calendar.dart';
import 'package:intl/intl.dart';
import 'resetpass.dart';
import 'typeofuser.dart';
import 'editevents.dart';
import 'editprofile.dart';

class MyFeed extends StatefulWidget {
  const MyFeed({Key? key}) : super(key: key);

  @override
  State<MyFeed> createState() => _MyFeedState();
}

class _MyFeedState extends State<MyFeed> {
  final user = FirebaseAuth.instance.currentUser!;
  final CollectionReference event =
      FirebaseFirestore.instance.collection('events');
  final CollectionReference notifications =
      FirebaseFirestore.instance.collection('notifications');
  Icon cusIcon = Icon(Icons.search);
  Widget cusSearchBar = Text("Eventify");
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController searchController = TextEditingController();
  List<DocumentSnapshot> events = [];
  List<DocumentSnapshot> allEvents = [];
  int unreadNotificationsCount = 0;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  String username = '';
  String dept = '';
  var phno = '';

  @override
  void initState() {
    //userdatain drawyer
    super.initState();
    _getUserData();

    // Get all events from Firestore
    event.orderBy('timestamp', descending: true).get().then((snapshot) {
      events = snapshot.docs;
      allEvents = snapshot.docs;
      setState(() {});
    });

    notifications.snapshots().listen((snapshot) {
      setState(() {
        unreadNotificationsCount = snapshot.docs.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime datetime = DateTime.now();
    String datetime4 =
        DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY).format(datetime);

    return Scaffold(
      appBar: AppBar(
        title: cusSearchBar,
        elevation: 10,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (this.cusIcon.icon == Icons.search) {
                  this.cusIcon = Icon(Icons.cancel);
                  this.cusSearchBar = TextField(
                      controller: searchController,
                      textInputAction: TextInputAction.go,
                      onChanged: (val) {
                        setState(() {
                          final String value =
                              searchController.text.toLowerCase();
                          if (value.isEmpty) {
                            events = allEvents; // Restore the complete list
                          } else {
                            events = allEvents
                                .where((event) =>
                                    event['title']
                                        .toLowerCase()
                                        .contains(value) ||
                                    event['organizer']
                                        .toLowerCase()
                                        .contains(value) ||
                                    event['place']
                                        .toLowerCase()
                                        .contains(value))
                                .toList();
                            //|| event['time'].toLowerCase().contains(value)||
                            //  event['organizer'].toLowerCase().contains(value)).toList();
                          }
                        });
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search here...",
                          hintStyle: TextStyle(
                            color: Colors.white,
                          )),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ));
                } else {
                  this.cusIcon = Icon(Icons.search);
                  this.cusSearchBar = Text("Eventify");
                  events = allEvents;
                  searchController.clear();
                }
              });
            },
            icon: cusIcon,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyNotifications(),
                ),
              );
              setState(() {
                unreadNotificationsCount = 0; // Mark all notifications as read
              });
            },
            icon: Stack(
              children: [
                Icon(Icons.notifications_active),
                if (unreadNotificationsCount > 0)
                  badges.Badge(
                    position: badges.BadgePosition.topEnd(top: 0, end: 0),
                    badgeContent: Text(''),
                  ),
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                username,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(user.email!, style: TextStyle(fontSize: 17)),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 7, 25, 127),
              ),
              currentAccountPicture: CircleAvatar(
                child: Text(
                  username.isNotEmpty ? username[0].toUpperCase() : '',
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
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "$dept",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Phone no: $phno",
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ResetScreen()),
                    );
                  },
                  icon: Icon(Icons.password_outlined)),
              title: Text("Reset Password"),
            ),
            ListTile(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => EditEvent()),
                    );
                  },
                  icon: Icon(Icons.add_card)),
              title: Text("Manage Event"),
            ),
            ListTile(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditNotifications()),
                    );
                  },
                  icon: Icon(Icons.notification_add_outlined)),
              title: Text("Manage Notification"),
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
      body: Padding(
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
                  topRight: Radius.circular(80),
                ),
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
                    blurRadius: 10,
                    color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.9),
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\" Never miss a Single Event \"",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "All the Event \nNotification at one Place",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.add_a_photo_sharp, color: Colors.white),
                        Row(
                          children: [
                            Icon(Icons.date_range, color: Colors.white),
                            SizedBox(width: 5),
                            Text(
                              datetime4,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Upcoming Events",
              style: TextStyle(
                color: Color.fromARGB(255, 29, 31, 142),
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    event.orderBy('timestamp', descending: true).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      reverse: false,
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot eventSnap = events[index];

                        final Timestamp? timestamp =
                            eventSnap['date'] as Timestamp?;

                        final String? imageURL = eventSnap['imageURL'];
                        // Check if imageURL is not null or empty
                        final bool hasImage =
                            imageURL != null && imageURL.isNotEmpty;

                        // Field validation
                        if (timestamp == null) {
                          // Handle case where 'date' field is missing or null
                          return Container();
                        }

                        final DateTime dateTime = timestamp.toDate();

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EventRead(),
                                    settings: RouteSettings(arguments: {
                                      'title': eventSnap['title'],
                                      'place': eventSnap['place'],
                                      'time': eventSnap['time'],
                                      'toTime': eventSnap['toTime'],
                                      'date': eventSnap['date'],
                                      'toDate': eventSnap['toDate'],
                                      'organizer': eventSnap['organizer'],
                                      'shortDescription':
                                          eventSnap['shortDescription'],
                                      'longDescription1':
                                          eventSnap['longDescription1'],
                                      'longDescription2':
                                          eventSnap['longDescription2'],
                                      'link': eventSnap['link'],
                                      'id': eventSnap.id,
                                      'imageURL': eventSnap[
                                          'imageURL'], // Include the imageURL field
                                      'timestamp': FieldValue.serverTimestamp(),
                                    })),
                              );
                            },
                            child: Container(
                              // key:ValueKey(eventSnap.id),
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
                                  topRight: Radius.circular(0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (hasImage)
                                    Container(
                                      width: double.infinity,
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(0),
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                            topRight: Radius.circular(0),
                                          ),
                                          child: Image.network(
                                            imageURL!,
                                            fit: BoxFit.fill,
                                          )),
                                    ),
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      eventSnap['title'] ?? '',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                      overflow: TextOverflow
                                                          .ellipsis, // Handles text overflow by ellipsis
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    eventSnap['organizer'] ??
                                                        '',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 3, 15, 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          eventSnap['shortDescription'],
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white),
                                        ))
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        15, 3, 15, 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.date_range,
                                                    color: Colors.white,
                                                    size: 35.0,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        DateFormat('dd/MM/yyyy')
                                                            .format(dateTime),
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15.0,
                                                        ),
                                                      ),
                                                      Text(
                                                        eventSnap['time'],
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      )
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
                                              Icon(
                                                Icons.location_on_outlined,
                                                color: Colors.white,
                                                size: 35.0,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  eventSnap['place'] ?? '',
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
                        );
                      },
                    );
                  } else {
                    return Container(
                      child: Text("No Events Exists!!"),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScreenCalendar(),
              ));
        },
        child: Icon(Icons.calendar_month, color: Colors.white),
      ),
    );
  }

  void _getUserData() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        final userId = user.uid;
        print(userId);
        final HODDoc =
            await _firebaseFirestore.collection('Department').doc(userId).get();
        final clubDoc =
            await _firebaseFirestore.collection('Club').doc(userId).get();
        if (HODDoc.exists) {
          setState(() {
            username = HODDoc.get('name');
            dept = HODDoc.get('dept');
            phno = HODDoc.get('Phno');
          });
        } else if (clubDoc.exists) {
          setState(() {
            username = clubDoc.get('name');
            dept = clubDoc.get('dept');
            phno = clubDoc.get('Phno');
          });
        } else {
          print("Document does not exist for the user");
        }
      } else {
        print("User is not authenticated");
      }
    } catch (e) {
      print("Error in fetching: $e");
    }
  }
}
