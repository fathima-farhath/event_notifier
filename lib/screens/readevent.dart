import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import  'package:intl/intl.dart';

class EventRead extends StatefulWidget {
  const EventRead({super.key});

  @override
  State<EventRead> createState() => _EventReadState();
}

class _EventReadState extends State<EventRead> {
  @override
  Widget build(BuildContext context) {
    
    final args=ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
     final String? imageURL = args['imageURL'];
     final String? link = args['link'];

    // Check if imageURL is not null or empty
    final bool hasImage = imageURL != null && imageURL.isNotEmpty;
    final bool hasUrl = link != null && link.isNotEmpty;

    DateTime dateTime = DateTime.now();
    return Scaffold(
      appBar: AppBar(
      title: Text(args['title']),
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
  
body: ListView(
  children: [
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    args['title'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    args['organizer'],
                    style: TextStyle(
                      color: Color.fromARGB(255, 52, 60, 61),
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Hey folks,",
                  style: TextStyle(
                    color: Color.fromARGB(255, 52, 60, 61),
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: Text(
                  args['longDescription1'],
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.0),
          Row(
            children: [
              Expanded(
                child: Text(
                  args['longDescription2'],
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.date_range,
                          color: Colors.black,
                          size: 35.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('dd/MM/yyyy').format(dateTime),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                              ),
                            ),
                            Text(
                              args['time'],
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: 175.0,
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.black,
                      size: 35.0,
                    ),
                    Expanded(
                      child: Text(
                        args['place'] ?? '',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15.0),
          if(hasUrl)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Link:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  fontSize: 21.0,
                ),
              ),
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
            ],
          ),
          SizedBox(height: 15.0),
          if (hasImage)
            Container(
              child: Image.network(imageURL!),
            ),
        ],
      ),
    ),
  ],
),
    );
  }
}