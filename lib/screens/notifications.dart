import 'package:flutter/material.dart';
import 'readnotify.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MyNotifications extends StatefulWidget {
  const MyNotifications({Key? key}) : super(key: key);

  @override
  State<MyNotifications> createState() => _MyNotificationsState();
}

class _MyNotificationsState extends State<MyNotifications> {
   
  final CollectionReference notification =
      FirebaseFirestore.instance.collection('notifications');

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        centerTitle: true,
        elevation: 10,
      ),
      body: StreamBuilder(
        stream: notification.orderBy('timestamp', descending: false).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot notificationSnap =
                    snapshot.data!.docs.reversed.toList()[index];
                final timestamp = notificationSnap['timestamp'] as Timestamp;
                final dateTime = timestamp.toDate();
                final formatter = DateFormat('MM/dd/yyyy  hh:mm a');
                final formattedDateTime = formatter.format(dateTime);

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
                            Text(
                              notificationSnap['title'],
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 253, 253, 253),
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
                                          'title':notificationSnap['title'],
                                          'broadTitle':notificationSnap['broadTitle'],
                                          'shortDescription':notificationSnap['shortDescription'],
                                          'para1Desc':notificationSnap['para1Desc'],
                                          'para2Desc':notificationSnap['para2Desc'],
                                          'link':notificationSnap['link'],
                                          'id':notificationSnap.id,
                                          'imageURL':notificationSnap['imageURL'],
                                          'fileUrl':notificationSnap['fileUrl']
                                        }
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
                        height:1.0,
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
          return Container();
        },
      ),
    );
  }
}