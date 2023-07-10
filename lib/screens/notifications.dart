import 'package:flutter/material.dart';
import 'readnotify.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyNotifications extends StatefulWidget {
  const MyNotifications({Key? key}) : super(key: key);

  @override
  State<MyNotifications> createState() => _MyNotificationsState();
}

class _MyNotificationsState extends State<MyNotifications> {
  final CollectionReference notification =
      FirebaseFirestore.instance.collection('notifications');

  String? selectedDepartment; // Placeholder for the selected department

  @override
  void initState() {
    super.initState();

    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('Student')
          .doc(user.uid)
          .get()
          .then((DocumentSnapshot userSnapshot) {
        setState(() {
          selectedDepartment = userSnapshot['dept'];
        });
      });

      FirebaseFirestore.instance
          .collection('Teacher')
          .doc(user.uid)
          .get()
          .then((DocumentSnapshot userSnapshot) {
        setState(() {
          selectedDepartment = null;
        });
      });

      FirebaseFirestore.instance
          .collection('Department')
          .doc(user.uid)
          .get()
          .then((DocumentSnapshot departmentSnapshot) {
        if (departmentSnapshot.exists) {
          setState(() {
            selectedDepartment = null; // Set selectedDepartment to null to display all notifications
          });
        }
      });

      FirebaseFirestore.instance
          .collection('Club')
          .doc(user.uid)
          .get()
          .then((DocumentSnapshot clubSnapshot) {
        if (clubSnapshot.exists) {
          setState(() {
            selectedDepartment = null; // Set selectedDepartment to null to display all notifications
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        centerTitle: true,
        elevation: 10,
      ),
      body: StreamBuilder(
        stream:  selectedDepartment != null
        ? notification
            .where('department', arrayContains: selectedDepartment)
            .orderBy('timestamp', descending: true)
            .snapshots()
        : notification.orderBy('timestamp', descending: true).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot notificationSnap = snapshot.data!.docs[index];
                final Timestamp? timestamp = notificationSnap['timestamp'];
                final DateTime? dateTime = timestamp?.toDate();
                final formatter = DateFormat('MM/dd/yyyy  hh:mm a');
                final formattedDateTime = dateTime != null ? formatter.format(dateTime) : '';

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.indigo[300],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                          ),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.star),
                              color: Colors.white,
                            ),
                            Expanded(
                              child: Text(
                                notificationSnap['title'],
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 253, 253, 253),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  notificationSnap['shortDescription'],
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.indigo[300],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0),
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              TextButton(
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all(
                                    Color.fromARGB(255, 254, 254, 254),
                                  ),
                                  textStyle: MaterialStateProperty.all(
                                    TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Readnotification(),
                                      settings: RouteSettings(
                                        arguments: {
                                          'title': notificationSnap['title'],
                                          'broadTitle': notificationSnap['broadTitle'],
                                          'shortDescription': notificationSnap['shortDescription'],
                                          'para1Desc': notificationSnap['para1Desc'],
                                          'para2Desc': notificationSnap['para2Desc'],
                                          'link': notificationSnap['link'],
                                          'id': notificationSnap.id,
                                          'imageURL': notificationSnap['imageURL'],
                                          'fileUrl': notificationSnap['fileUrl']
                                        },
                                      ),
                                    ),
                                  );
                                },
                                child: Text("View More"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.0,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(formattedDateTime),
                      )
                    ],
                  ),
                );
              },
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}