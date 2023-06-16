import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'notifications.dart';
import 'readevent.dart';
import  'package:intl/intl.dart';

class MyFeed extends StatefulWidget {
  const MyFeed({super.key});

  @override
  State<MyFeed> createState() => _MyFeedState();
}

class _MyFeedState extends State<MyFeed> {
  final CollectionReference event = FirebaseFirestore.instance.collection('events');

  @override
  Widget build(BuildContext context) {
    DateTime datetime = DateTime.now();
    String datetime4 = DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY).format(datetime);

    return Scaffold(
      appBar: AppBar(
        title: Text("Eventify"),
        elevation: 10,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyNotifications(),
                ),
              );
            },
            icon: Icon(Icons.notifications_active),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.event_available),
          ),
        ],
      ),
      drawer: Drawer(
  child: ListView(
    children:[
     
      UserAccountsDrawerHeader(
        accountName: Text("Aavani P K",
      style: TextStyle(fontSize: 18,
      fontWeight: FontWeight.bold),
      ),
       accountEmail: Text("aavanipk2002@gmail.com",
       style: TextStyle(fontSize: 17)),
      
       decoration: BoxDecoration(color: Color.fromARGB(255, 7, 25, 127),),
       
       currentAccountPicture: CircleAvatar(
        child: Text("A",style: TextStyle(color: Color.fromARGB(255, 7, 25, 127),fontSize: 30.0,fontWeight: FontWeight.bold,),),
        backgroundColor: Colors.white,
        radius: 100,
        )
        ,),
        Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 49, 120, 242),
            borderRadius: BorderRadius.only(
              topLeft:Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(40)
            )
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Semester: IV",style: TextStyle(
                  fontSize: 18.0,
                  color:  Color.fromARGB(255, 255, 255, 255),
                ),),
                SizedBox(height: 3,),
                Text("Department: Information Technology",style: TextStyle(
                  fontSize: 18.0,
                  color:  Color.fromARGB(255, 255, 255, 255),
                ),),
                SizedBox(height: 3,),
                Text("Gender: Female",style: TextStyle(
                  fontSize: 18.0,
                  color:  Color.fromARGB(255, 255, 255, 255),
                ),),
                SizedBox(height: 3,),
                Text("Phone no: 9496035580",style: TextStyle(
                  fontSize: 18.0,
                  color:  Color.fromARGB(255, 255, 255, 255),
                ),),
              ],
            ),
          ),
        ),
        ListTile(
          leading:IconButton(onPressed: (){}, icon: Icon(Icons.edit_sharp)),
          title: Text("Edit Profile"),
        ),
        ListTile(
          leading:IconButton(onPressed: (){}, icon: Icon(Icons.password_outlined)),
          title: Text("Reset Password"),

        ),
        // ListTile(
        //   leading:IconButton(onPressed: (){}, icon: Icon(Icons.dashboard)),
        //   title: Text("Go to dashboard"),
        // ),
        ListTile(
          leading:IconButton(onPressed: (){}, icon: Icon(Icons.logout)),
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
                stream: event.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot eventSnap =
                            snapshot.data!.docs[index];

                        final Timestamp? timestamp =
                            eventSnap['date'] as Timestamp?;

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
                                ),
                              );
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
                                  topRight: Radius.circular(0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(0),
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                        topRight: Radius.circular(0),
                                      ),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              eventSnap['title'] ?? '',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              eventSnap['organizer'] ?? '',
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
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 3, 15, 5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            eventSnap['shortDescription'] ?? '',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 3, 15, 10),
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
                                                        CrossAxisAlignment.start,
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
                                                        DateFormat('hh:mm a')
                                                            .format(dateTime),
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
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.calendar_month, color: Colors.white),
      ),
    );
  }
}