import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'feed.dart';
class Readnotification extends StatefulWidget {
  const Readnotification({super.key});

  @override
  State<Readnotification> createState() => _ReadnotificationState();
}

class _ReadnotificationState extends State<Readnotification> {
//  launchURL(String url) async {
//   if(await canLaunch(url)){
//     await launch(url,forceWebView:true);
//   }else{
//     throw 'Could not launch $url';
//   }
//  }
 var defaultText=TextStyle(color: Colors.black,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,fontSize: 21.0);
  var linkText=TextStyle(color: Colors.blue,
);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      title: Text("CHMS"),
      centerTitle: true,
      elevation: 10,
     
     actions: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyFeed()));
            }, icon: Icon(Icons.home)),
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
                  Text("C H Mohammed Koya Scolarship Renewal 2023",style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
    ]
            ),
            ),
            SizedBox(
              height: 20.0,
            ),
           Text("Dear Students,",style: TextStyle(fontSize: 18.0,),),

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
          //     Text("Link:",style: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.underline,fontSize: 21.0),),
          //  TextButton(onPressed: (){
          //   final url="https://www.youtube.com/watch?v=nf4_Ke5B1K8";
          //   launchURL(url);
          //  }, child:Text("Click here to visit the official website")),
              
              RichText(text: 
              TextSpan(children: [
              TextSpan(
                style: defaultText,
                text: "Link:\n"
              ),
              TextSpan(
                style: linkText,
                text: "Click here to go to the official website",
                recognizer: TapGestureRecognizer()..onTap = () async {
                  var url=Uri.parse("https://mightytechno.com/create-hyperlink-for-text-in-flutter/");
                  if(await canLaunchUrl(url)){
                    await launchUrl(url);
                  }
                  else{
                    throw "Cannot load url";
                  }
                }
              ),]
              ),),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                      ),
          
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       IconButton(onPressed: (){}, icon:  Icon(Icons.remove_red_eye_outlined),color: Colors.white,iconSize: 28.0,),
                       Text("CHMS.pdf",style: TextStyle(fontSize:18.0),),
                         IconButton(onPressed: (){}, icon:  Icon(Icons.download),color: Colors.white,iconSize: 28.0,)
                    ],
                  ),
                ),
              ],
          ),
    ),
    ]
    ),
    );
  }
}