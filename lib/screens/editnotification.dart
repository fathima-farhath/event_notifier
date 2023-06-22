import 'addNotification.dart';
import 'package:flutter/cupertino.dart';
import 'updateNotification.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditNotifications extends StatefulWidget {
  const EditNotifications({super.key});

  @override
  State<EditNotifications> createState() => _EditNotificationsState();
}

class _EditNotificationsState extends State<EditNotifications> {
  final CollectionReference notification=FirebaseFirestore.instance.collection('notifications');
  void deleteNotification(docId){
    notification.doc(docId).delete();
  }
  void _confirmDelete(String docId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete this notification?'),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              deleteNotification(docId);
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        
      ),

     body: StreamBuilder(
        stream: notification.orderBy('timestamp', descending: false).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot notification= snapshot.data!.docs.reversed.toList()[index];

                return 
                Padding(
       padding: const EdgeInsets.all(8.0),
       child: Container(
            // color: Colors.amber,
            
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
                      child: Text(notification['title'].substring(0,1),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),),
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment:  CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                           notification['title'],
                           style: TextStyle(
                            fontSize: 18,fontWeight: FontWeight.bold,
                          ),
                        ),
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
        builder: (context) => UpdateNotification(),
        settings: RouteSettings(
         arguments: {
          'title':notification['title'],
          'broadTitle':notification['broadTitle'],
          'shortDescription':notification['shortDescription'],
          'para1Desc':notification['para1Desc'],
          'para2Desc':notification['para2Desc'],
          'link':notification['link'],
          'id':notification.id,
         }
            ),
          ),
        );
      },
      icon: Icon(
        Icons.edit,
        size: 30,
        color: Colors.blue,
      ),
    ),
                    IconButton(onPressed: (){
                      _confirmDelete(notification.id);
                    }, icon: Icon(Icons.delete,
                    size: 30,
                    color: Colors.red,))
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

      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddNotification()),
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          elevation: 2.0,
        ),
      ),
    
     );
  }
}