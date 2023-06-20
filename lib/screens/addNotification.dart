import 'dart:io';
import 'editnotification.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddNotification extends StatefulWidget {
  const AddNotification({super.key});

  @override
  State<AddNotification> createState() => _AddNotificationState();
}

class _AddNotificationState extends State<AddNotification> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _broadTitleController=TextEditingController();
  TextEditingController _shortDescriptionController = TextEditingController();
  // TextEditingController _fullDescriptionController = TextEditingController();
  TextEditingController _para1DescController=TextEditingController();
  TextEditingController _para2DescController=TextEditingController();
  TextEditingController _linkController = TextEditingController();
  String imageUrl='';
  final CollectionReference notification=FirebaseFirestore.instance.collection('notifications');

  void addNotification(){
    final data= {
    'title':_titleController.text,
    'broadTitle':_broadTitleController.text,
    'shortDescription':_shortDescriptionController.text,

    'para1Desc':_para1DescController.text,
    'para2Desc':_para2DescController.text,
    //  'time':selectedFromTime!.format(context),
    //  'toTime': selectedToTime!.format(context),
    // 'date':  DateTime.parse(fromDateString!),
    // 'toDate':DateTime.parse(toDateString!),
    // 'longDescription':_fullDescriptionController.text,
    'link':_linkController.text,
    'timestamp': FieldValue.serverTimestamp(),
    
    // 'imageURL':imageUrl,
    };
    
   notification.add(data);
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Notifications')),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Enter the Title',
                      labelStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)
                      ),
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      filled: true,
                      contentPadding: const EdgeInsets.all(15),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    controller: _broadTitleController,
                    decoration: InputDecoration(
                      labelText: 'Enter the Broad Title',
                      labelStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)
                      ),
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      filled: true,
                      contentPadding: const EdgeInsets.all(15),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height:20,
                ),
               Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.black,
                    )
                  ),
                  child: TextFormField(
                    controller: _shortDescriptionController,
                    decoration: InputDecoration(
                      border:InputBorder.none,
                      labelText: 'Breif Notification Description',
                      // labelStyle: TextStyle(fontSize: 18.0),
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      filled: true,
                      contentPadding: const EdgeInsets.all(15),
                    ),
                    maxLines:null,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  )
                ),
                const SizedBox(
                  height: 20,
                ),
                
 // para 1 Description
                Container(
                  width: double.infinity,
                 height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.black,
                    ),),
                  child: TextFormField(
                    controller: _para1DescController,
                    decoration: InputDecoration(
                      labelText: 'Notification Description paragraph 1',
                      // labelStyle: TextStyle(fontSize: 18.0),
                      border: InputBorder.none,
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      filled: true,
                      contentPadding: const EdgeInsets.all(15),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  )
                ),
                SizedBox(height:20,),

                // para2 Description
                Container(
                      width: double.infinity,
                      height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.black,
                    )),
                        child: TextFormField(
                          controller: _para2DescController,
                          // Set maxLines to null for a multi-line text area
                          decoration: InputDecoration(
                            labelText: 'Notification Description paragraph 2',
                            border: InputBorder.none,
                            fillColor: Color.fromARGB(255, 255, 255, 255),
                            filled: true,
                            contentPadding: const EdgeInsets.all(15),
                          ),
                          maxLines: null,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                      ),
                    

                const SizedBox(
                  height: 20,
                ),
              
              // Link
               Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: _linkController,
                    decoration: InputDecoration(
                      labelText: 'Link',
                      // labelStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)
                      ),
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      filled: true,
                      contentPadding: const EdgeInsets.all(15),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  )
                ),

                SizedBox(height:20,),

                //attach image
                // ElevatedButton(
                //   onPressed: () async {
                //     // _pickedImage = (await ImagePicker()
                //     //     .pickImage(source: ImageSource.camera))!;
                // ImagePicker imagePicker=ImagePicker();  
                //   XFile? file= await imagePicker.pickImage(source: ImageSource.camera);
                // if (file==null) return;

                //     // String uniqueFilename=DateTime.now().millisecondsSinceEpoch.toString();



                //     // Reference referenceRoot=FirebaseStorage.instance.ref();
                //     // Reference ReferenceDirImage=referenceRoot.child('images');
                //     // Reference ReferenceImageToUpload=ReferenceDirImage.child(uniqueFilename);
                  
                //     // try{
                //     // await ReferenceImageToUpload.putFile(File(file!.path));
                //     // imageUrl=await ReferenceImageToUpload.getDownloadURL();
                //     // }
                //     // catch(error){
                      
                //     // }
                //   },
                //   style: ButtonStyle(
                
                //      backgroundColor:
                //         MaterialStateProperty.all<Color>(Color.fromARGB(255, 185, 185, 185),),
                //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //       RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //     ),
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: const [
                //       Icon(
                //         Icons.attach_file,
                //         color: Colors.black,
                //       ),
                //       SizedBox(
                //         width: 10,
                //       ),
                //       Text(
                //         'Attach an Image',
                //         style: TextStyle(color: Colors.black),
                //       ),
                //     ],
                //   ),
                // ),

                ElevatedButton(onPressed: (){

                }, child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.file_copy,
                    color: Colors.black,
                    ),
                     SizedBox(
                        width: 10,
                      ),
                    Text("Attach a file",
                        style: TextStyle(
                          color: Colors.black,
                        ),)
                    
                  ],

                ),
                style: ButtonStyle(
                  backgroundColor:MaterialStateProperty.all<Color>(Color.fromARGB(255, 185, 185, 185)!),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                ),),
                
                
                //submit button

                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                       addNotification();
                       Navigator.push(context, MaterialPageRoute(builder: (context) => EditNotifications(),),);
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStatePropertyAll(Size(2500,50)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                      child: Text(
                        'Add Notification',
                        style: TextStyle(
                          fontSize: 20,
                          
                        ),
                      ),
                    ),
                  ),
              ]
            ),
          ),
        ),
      ),
    );
 }
}