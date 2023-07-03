import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'feed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
class Readnotification extends StatefulWidget {
  
  const Readnotification({super.key});
   

  @override
  State<Readnotification> createState() => _ReadnotificationState();
}

class _ReadnotificationState extends State<Readnotification> {

 var defaultText=TextStyle(color: Colors.black,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,fontSize: 21.0);
  var linkText=TextStyle(color: Colors.blue,
);

  @override
  Widget build(BuildContext context) {
    final args=ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    final String? imageURL = args['imageURL'];
    final String? fileUrl = args['fileUrl'];
    String title = args['title'];
    // Check if imageURL is not null or empty
    final bool hasImage = imageURL != null && imageURL.isNotEmpty;
    final bool hasFile = fileUrl != null && fileUrl.isNotEmpty;
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
        
              SizedBox(
                height: 15.0,
              ),
            
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
                  
                  if (hasImage)
                    Container(
                      child: Image.network(imageURL!),
                    ),
                    SizedBox(
                height: 15.0,
              ),
              
              if (hasFile)
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
                       IconButton(onPressed: (){
                         Navigator.push(context, MaterialPageRoute
                         (builder: (context)=>View(url:fileUrl)));
                       }, icon:  Icon(Icons.remove_red_eye_outlined),color: Colors.white,iconSize: 28.0,),
                       Text('$title.pdf',style: TextStyle(fontSize:18.0),),
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
class View extends StatelessWidget {
  final url;
  View({this.url});
  PdfViewerController? _pdfViewerController;
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF Viewer"),
       
      ),
      body: SfPdfViewer.network(
      url,
      controller: _pdfViewerController,
    ),
    );
  }
}

