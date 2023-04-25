import 'package:flutter/material.dart';
import 'notifications.dart';
class MyFeed extends StatefulWidget {
  const MyFeed({super.key});

  @override
  State<MyFeed> createState() => _MyFeedState();
}

class _MyFeedState extends State<MyFeed> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      appBar: AppBar(
      title: Text("Eventify"),
      elevation: 10,
     
     actions: [
       IconButton(onPressed: (){},icon:Icon(Icons.search)),
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyNotifications()));
            }, icon: Icon(Icons.notifications_active)),
            IconButton(onPressed: (){},icon:Icon(Icons.event_available))
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


body: Container(
  padding: EdgeInsets.fromLTRB(10, 15, 10,0),
  child:   Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: MediaQuery.of(context).size.width,
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft:Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(80)
          ) ,
         gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 5, 29, 163),
                Color.fromARGB(255, 149, 107, 228),
              ],
              
            ),
            boxShadow: [BoxShadow(
              offset: Offset(5, 10),
              blurStyle: BlurStyle.outer,
              blurRadius: 10,
              color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.9),
            )]
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               
              Text("\" Never miss a Single Event \"",style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              )),
              SizedBox(height: 10,),
              Text("All the Event \nNotification at one Place",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w700
              ),),
             SizedBox(height: 20,),

              Row(
                children: [
                  Icon(Icons.date_range,color: Colors.white),
                  SizedBox(width: 5,),
                  Text("27 Apr",style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w700
              ),)
                ],
              ),

           
          ],),
        ),
        ),
        SizedBox(height: 20,),
        Text("Upcoming Events",style: TextStyle(
                color: Color.fromARGB(255, 29, 31, 142),
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),),
          SizedBox(height: 10,),
          Container(
            child: Column(
              children: [
                Image.asset(
                  
                ),
              ],
            ),
          )

          
        ],
  
  ),
),


    );
  }
}