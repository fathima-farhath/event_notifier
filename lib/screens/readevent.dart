import 'package:flutter/material.dart';


class EventRead extends StatefulWidget {
  const EventRead({super.key});

  @override
  State<EventRead> createState() => _EventReadState();
}

class _EventReadState extends State<EventRead> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("ME WARRIOR 2023"),
      centerTitle: true,
      elevation: 10,
     
     actions: [
            // IconButton(onPressed: (){
            //   Navigator.push(context, MaterialPageRoute(builder: (context)=>MyFeed()));
            // }, icon: Icon(Icons.home)),
            IconButton(onPressed: (){},icon:Icon(Icons.more_vert_outlined))
          ],
),

    //  body
  
  body:ListView(
    children: [ Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: 
            Row(
              children: [
                Expanded(child: 
                  Text("ME WARRIOR 2023",style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),)
                ),
    ]
            ),
            ),
             Container(
            child: 
            Row(
              children: [
                Expanded(child: 
                  Text("Mind Empowered",style: TextStyle(
                    color: Color.fromARGB(255, 52, 60, 61),
                    fontSize: 21,
                    fontWeight: FontWeight.w500
                  ),),
                ),
    ]
            ),
            ),
            SizedBox(
                height: 10.0,
              ),

               
             
 

              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  Expanded(child: 
                  Text("The scholarships are open to students who are pursuing undergraduate or graduate studies in any field of study at any accredited university in the United States. For more information and to apply, please visit the CH Muhammed Koya website. A new scheme has been created by the Directorate of Minority Welfare Government of Kerala to provide educational opportunities among the girl applicant of minority communities such as the Muslim Community, Converted Christian, and Latin Catholic.\n\nThe scholarship amount of Rs. 5,000/6,000/7,000 will be provided to the students carrying out UG/PG/professional courses under the CH Muhammed Koya Scholarship. This scholarship will only be provided to the girl students who belong to the minority communities such as Muslims, Sikhs, Christians, Buddhists, Jain, and Zoroastrians (Parsis).The scholarships are open to students who are pursuing undergraduate or graduate studies in any field of study at any accredited university in the United States. For more information and to apply, please visit the CH Muhammed Koya website. A new scheme has been created by the Directorate of Minority Welfare Government of Kerala to provide educational opportunities among the girl applicant of minority communities such as the Muslim Community, Converted Christian, and Latin Catholic.",style: TextStyle(fontSize: 18.0,),))
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Text("Link:",style: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.underline,fontSize: 21.0),),
           TextButton(onPressed: (){
            // final url="https://www.youtube.com/watch?v=nf4_Ke5B1K8";
            // launchURL(url);
           }, child:Text("Click here to visit the official website")),
              
              ],
          ),
    ),
    ]
    ),
    );
  }
}