import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
class AddEvent extends StatefulWidget {
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
 TextEditingController _titleController = TextEditingController();
  TextEditingController _shortDescriptionController = TextEditingController();
  TextEditingController _fullDescriptionController = TextEditingController();
  TextEditingController _linkController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _placeController = TextEditingController();
  File? _image;

  @override
  void dispose() {
    _titleController.dispose();
    _shortDescriptionController.dispose();
    _fullDescriptionController.dispose();
    _linkController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _placeController.dispose();
    super.dispose();
  }
Future<void> _getImage() async {
  if (Platform.isAndroid || Platform.isIOS) {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  } else if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _image = File(result.files.single.path!);
      });
    }
  }
}

  
void _submitForm() async {
  // Get form input values
  String title = _titleController.text;
  String shortDescription = _shortDescriptionController.text;
  String fullDescription = _fullDescriptionController.text;
  String link = _linkController.text;
  String date = _dateController.text;
  String time = _timeController.text;
  String place = _placeController.text;

  // Create a document in the Firestore collection
  DocumentReference documentRef = FirebaseFirestore.instance.collection('event').doc();

  // Upload image to Firebase Storage
  if (_image != null) {
    String imagePath = 'event_images/${documentRef.id}.jpg'; // Define image path in storage

    Reference storageRef = FirebaseStorage.instance.ref().child(imagePath);
    await storageRef.putFile(_image!);

    String downloadURL = await storageRef.getDownloadURL();

    // Save form data and image URL in Firestore
    await documentRef.set({
      'title': title,
      'shortDescription': shortDescription,
      'fullDescription': fullDescription,
      'link': link,
      'date': date,
      'time': time,
      'place': place,
      'imageURL': downloadURL,
    });
  } else {
    // Save form data without the image URL in Firestore
    await documentRef.set({
      'title': title,
      'shortDescription': shortDescription,
      'fullDescription': fullDescription,
      'link': link,
      'date': date,
      'time': time,
      'place': place,
    });
  }

  // Print the form values for demonstration
  print('Title: $title');
  print('Short Description: $shortDescription');
  print('Full Description: $fullDescription');
  print('Link: $link');
  print('Date: $date');
  print('Time: $time');
  print('Place: $place');
  print('Image Path: ${_image?.path}');

  // Navigate to another page and pass necessary data
  // Navigator.push(
  //   context,
  //   MaterialPageRoute(
  //     builder: (context) => AnotherPage(/* pass necessary data */),
  //   ),
  // );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
           
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(border:OutlineInputBorder(),labelText: 'Title'),
            ),
            TextFormField(
              controller: _shortDescriptionController,
              decoration: InputDecoration(labelText: 'Short Description'),
            ),
            TextFormField(
              controller: _fullDescriptionController,
              decoration: InputDecoration(labelText: 'Full Description'),
              maxLines: null,
            ),
            TextFormField(
              controller: _linkController,
              decoration: InputDecoration(labelText: 'Link'),
            ),
            TextFormField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Date'),
              keyboardType: TextInputType.datetime,
            ),
            TextFormField(
              controller: _timeController,
              decoration: InputDecoration(labelText: 'Time'),
              keyboardType: TextInputType.datetime,
            ),
            TextFormField(
              controller: _placeController,
              decoration: InputDecoration(labelText: 'Place'),
            ),
             GestureDetector(
              onTap: _getImage,
              child: _image != null
                  ? Image.file(
                      _image!,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 200,
                      width: 200,
                      color: Colors.grey,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                    ),
            ),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

