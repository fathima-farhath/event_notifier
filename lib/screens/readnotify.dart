import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'feed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
// final String documentId;
// ReadNotification({required this.documentId});
 var defaultText=TextStyle(color: Colors.black,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,fontSize: 21.0);
  var linkText=TextStyle(color: Colors.blue,
);
  @override
  Widget build(BuildContext context) {
    final args=ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    return Scaffold(
     appBar: AppBar(
      title: Text(args['title']),
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
                  Text(args['broadTitle'],style: TextStyle(
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
                  Text(args['para1Desc'],style: TextStyle(fontSize: 18.0,),))
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  Expanded(child: 
                  Text(args['para2Desc'],style: TextStyle(fontSize: 18.0,),))
                ],
              ),
          //     Text("Link:",style: TextStyle(fontWeight: FontWeight.bold,decoration: TextDecoration.underline,fontSize: 21.0),),
          //  TextButton(onPressed: (){
          //   final url="https://www.youtube.com/watch?v=nf4_Ke5B1K8";
          //   launchURL(url);
          //  }, child:Text("Click here to visit the official website")),
              SizedBox(
                height: 15.0,
              ),
            
              
              // TextSpan(
              //   style: linkText,
              //   text: "Click here to go to the official website",
              //   recognizer: TapGestureRecognizer()..onTap = () async {
              //     var url=Uri.parse(args['link']);
              //     if(await canLaunchUrl(url)){
              //       await launchUrl(url);
              //     }
              //     else{
              //       throw "Cannot load url";
              //     }
              //   }
              // ),]
              // ),),
             
            Text("Link",
            style: TextStyle(
              fontSize: 15,

            ),),
            GestureDetector(
              onTap: () async {
                final url = args['link']; // Replace with your desired URL
                final uri = Uri.parse(url);
                await launchUrl(uri);
              },
              child: Text(
                args['link'],
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
              SizedBox(
                height: 15.0,
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