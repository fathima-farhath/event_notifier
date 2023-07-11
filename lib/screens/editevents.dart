import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'addEvent.dart';
import 'updateEvent.dart';
import 'feedHOD.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'feedHOD.dart';
import 'feedTeach.dart';
import 'feedStud.dart';

class EditEvent extends StatefulWidget {
  const EditEvent({super.key});

  @override
  State<EditEvent> createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  final CollectionReference event =
      FirebaseFirestore.instance.collection('events');
  final User? currentUser = FirebaseAuth.instance.currentUser;

  void _confirmDelete(String docId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this event?'),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                deleteEvent(docId);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Delete'),
              isDestructiveAction: true,
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void deleteEvent(docId) {
    event.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Events"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            goTofeed(context);
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyFeed()));
              },
              icon: Icon(Icons.home)),
        ],
      ),
      body: StreamBuilder(
        stream: event
            .where('creatorId',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .orderBy('timestamp', descending: false)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error in displaying: ${snapshot.error}');
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot eventSnap =
                    snapshot.data!.docs.reversed.toList()[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 15.0, // soften the shadow
                          spreadRadius: 5.0, //extend the shadow
                          offset: Offset(
                            5.0, // Move to right 5  horizontally
                            5.0, // Move to bottom 5 Vertically
                          ),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: CircleAvatar(
                              // backgroundColor: Colors.red,
                              radius: 30,
                              child: Text(
                                eventSnap['title'].substring(0, 1),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 150.0,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            eventSnap['title'],
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(eventSnap['organizer']),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UpdateEvent(),
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
                                          'timestamp':
                                              FieldValue.serverTimestamp(),
                                        })),
                                  );
                                },
                                icon: Icon(Icons.edit,
                                    size: 30, color: Colors.blue)),
                            IconButton(
                                onPressed: () {
                                  _confirmDelete(eventSnap.id);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: Colors.red,
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateEvent(),
            ),
          );
        },
        child: Icon(Icons.add),
        elevation: 0.2,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
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

        final clubDoc = await FirebaseFirestore.instance
            .collection('Club')
            .doc(userId)
            .get();
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
}
