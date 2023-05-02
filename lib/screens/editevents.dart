import 'package:flutter/material.dart';

class AdminTeacher extends StatefulWidget {
  const AdminTeacher({super.key});

  @override
  State<AdminTeacher> createState() => _AdminTeacherState();
}

class _AdminTeacherState extends State<AdminTeacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Events"),
        
      ),

     body: Padding(
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
                      child: Text("M",style: 
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
                       "ME Warrior 2023",style: TextStyle(
                        fontSize: 18,fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Mind Empowered".toString(),style: TextStyle(
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
     ),
      );

        
        
      } 
}