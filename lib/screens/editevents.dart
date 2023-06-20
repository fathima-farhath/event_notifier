import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminTeacher extends StatefulWidget {
  const AdminTeacher({super.key});

  @override
  State<AdminTeacher> createState() => _AdminTeacherState();
}

class _AdminTeacherState extends State<AdminTeacher> {
   final CollectionReference event =
      FirebaseFirestore.instance.collection('events');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Events"),
        
      ),

     body: StreamBuilder(
        stream: event.orderBy('timestamp',descending: false).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot eventSnap =snapshot.data!.docs.reversed.toList()[index];

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
                      child: Text(eventSnap['title'].substring(0, 1),style: 
                      TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:  CrossAxisAlignment.start,
                  children: [
                    Text(
                       eventSnap['title'],style: TextStyle(
                        fontSize: 18,fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      eventSnap['organizer'].toString(),style: TextStyle(
                        fontSize: 18,
                     
                    ),)
                  ],
     
                ),
                Row(
                  children: [
                     IconButton(onPressed: (){}, icon: Icon(Icons.edit,
                     size: 30,
                      color: Colors.blue)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.delete,
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
      floatingActionButton: FloatingActionButton(onPressed: 
      (){},
      child: Icon(Icons.add),
      elevation: 0.2,
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );

        
        
      } 
}