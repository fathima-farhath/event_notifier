import 'package:flutter/material.dart';
import 'readnotify.dart';
class MyNotifications extends StatefulWidget {
  const MyNotifications({super.key});

  @override
  State<MyNotifications> createState() => _MyNotificationsState();
}

class _MyNotificationsState extends State<MyNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      title: Text("Notifications"),
      centerTitle: true,
      elevation: 10,
     ),


    //  bod
     body: ListView(
      children: [
        Padding(
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
                  children: [IconButton(onPressed: (){}, icon: Icon(Icons.star),color:Colors.white ,),
                    Text("CHMS Scholarship",style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 253, 253, 253),
                    ),)
                  ],
                ),
              ),
              Container (
               child:Row(children: [
                Expanded
                (child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text("The call for CH Mohammed Koya Scholarshp has been Started.",style: 
                  TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.normal,
                
                  ),),
                ))
               ]),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.indigo[300],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(0),
                    ),),
      
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                  
                      
                         TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(Color.fromARGB(255, 254, 254, 254)),
                            textStyle: MaterialStatePropertyAll(
                              TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ))
                          ),
                        onPressed:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Readnotification()));
                        },
                        child:Text("View More"),
                      ),
                      
                    ],
                  ),
                ),
              ),

              SizedBox(
                  height:25.0,
                 ),

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
                  children: [IconButton(onPressed: (){}, icon: Icon(Icons.star),color:Colors.white ,),
                    Text("CHMS Scholarship",style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 253, 253, 253),
                    ),)
                  ],
                ),
              ),
              Container (
               child:Row(children: [
                Expanded
                (child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text("The call for CH Mohammed Koya Scholarshp has been Started.",style: 
                  TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.normal,
                
                  ),),
                ))
               ]),
              ),

             

              Container(
                decoration: BoxDecoration(
                  color: Colors.indigo[300],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(0),
                    ),),
      
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                  
                      
                         TextButton(
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all(Color.fromARGB(255, 254, 254, 254)),
                            textStyle: MaterialStatePropertyAll(
                              TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ))
                          ),
                        onPressed:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Readnotification()));
                        },
                        child:Text("View More"),
                      ),
                       
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
     ),

    );
  }
}
