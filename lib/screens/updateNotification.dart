import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'editnotification.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UpdateNotification extends StatefulWidget {
  const UpdateNotification({super.key});

  @override
  State<UpdateNotification> createState() => _UpdateNotificationState();
}

class _UpdateNotificationState extends State<UpdateNotification> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _broadTitleController=TextEditingController();
  TextEditingController _shortDescriptionController = TextEditingController();
  TextEditingController _para1DescController=TextEditingController();
  TextEditingController _para2DescController=TextEditingController();
  TextEditingController _linkController = TextEditingController();
  String imageUrl='';
  String newImageUrl = '';
  String url="";
  String selectedPdfFileName = '';
  XFile? selectedImage;
  uploadToFirebase() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    File pick=File(result!.files.single.path.toString());
    var file=pick.readAsBytesSync();
    String uniqueFilename=DateTime.now().millisecondsSinceEpoch.toString();
    var pdfFile=FirebaseStorage.instance.ref().child(uniqueFilename).child('Notification_docs');
    UploadTask task=pdfFile.putData(file);
    TaskSnapshot snapshot=await task;
    url=await snapshot.ref.getDownloadURL();
    // await FirebaseFirestore.instance.collection('notifications').doc().set({
    //   'fileUrl':url,
    // });
    // setState(() {
    //   selectedPdfFileName = pick.path.split('/').last;
    // });
  }
  final CollectionReference notification=FirebaseFirestore.instance.collection('notifications');

  void updateNotification(docId){
    final data={
    'title':_titleController.text,
    'broadTitle':_broadTitleController.text,
    'shortDescription':_shortDescriptionController.text,
    'para1Desc':_para1DescController.text,
    'para2Desc':_para2DescController.text,
    'link':_linkController.text,
    'timestamp': FieldValue.serverTimestamp(),
    'imageURL': imageUrl, 
    'fileUrl': url,
    };
    notification.doc(docId).update(data);
  }
  void _showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Success'),
        content: const Text('Notification updated successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => EditNotifications(),),); // Close the dialog
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
  @override
  Widget build(BuildContext context) {
  final args=ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
  _titleController.text=args['title'];
  _broadTitleController.text=args['broadTitle'];
  _shortDescriptionController.text=args['shortDescription'];
  _para1DescController.text=args['para1Desc'];
  _para2DescController.text=args['para2Desc'];
  _linkController.text=args['link'];
  final docId=args['id'];
  imageUrl = args['imageURL'];
  url = args['fileUrl'];
   return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Update Notifications')),
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
                        // fillColor: Color.fromARGB(255, 255, 255, 255),
                        
                        contentPadding: const EdgeInsets.all(15),
                      ),
                      maxLines: null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the title';
                        }
                        return null;
                      },
                    ),
                  ),
                 SizedBox(
                  height: 20,
                 ),
        
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
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
                          return 'Please enter the full title. If not, your title itself';
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
                    height: 200,
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
                      maxLines: null,
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
                        contentPadding: const EdgeInsets.all(10),
                      ),

                    )
                  ),
        
                  SizedBox(height:20,),
        
                  // attach image
                  ElevatedButton(
                    onPressed: () async {
                       ImagePicker imagePicker=ImagePicker();  
                    XFile? file= await imagePicker.pickImage(source: ImageSource.gallery);
                  if (file==null) return;
                 
                    //  setState(() {
                    //   selectedImage = file; // Store the selected image file
                    // });
                      String uniqueFilename=DateTime.now().millisecondsSinceEpoch.toString();
                      Reference referenceRoot=FirebaseStorage.instance.ref();
                      Reference ReferenceDirImage=referenceRoot.child('Notimages');
                      Reference ReferenceImageToUpload=ReferenceDirImage.child(uniqueFilename);                 
                      try{
                      await ReferenceImageToUpload.putFile(File(file!.path));
                      imageUrl=await ReferenceImageToUpload.getDownloadURL();
                      }
                      catch(error){           
                      }
                    },
                    style: ButtonStyle(              
                       backgroundColor:
                          MaterialStateProperty.all<Color>(Color.fromARGB(255, 185, 185, 185),),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.attach_file,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Attach an Image',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
        
          Text(
                selectedImage != null ? selectedImage!.name : '',  
                style: TextStyle(fontSize: 12.0),
                ),
                    
                         ElevatedButton(
        onPressed:() => uploadToFirebase(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.file_copy,
              color: Colors.black,
            ),
            SizedBox(
              height: 30,
              width: 10,
            ),
            Text(
              "Attach a file(pdf only)",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Color.fromARGB(255, 185, 185, 185),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
       Text(
  selectedPdfFileName,
  style: TextStyle(fontSize: 12.0),
),           //submit button
        
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Builder(
                      builder: (context) {
                        return ElevatedButton(
                          onPressed: () {
                             if (_formKey.currentState!.validate()){
                            updateNotification(docId);
                            _showSuccessDialog(context); 
                            
                          };
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
                              'Update Notification',
                              style: TextStyle(
                                fontSize: 20,
                                
                              ),
                            ),
                          );
                      }
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