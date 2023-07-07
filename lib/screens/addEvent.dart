import 'dart:io';
import 'editevents.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  TimeOfDay? selectedFromTime;
  TimeOfDay? selectedToTime;
  String? fromDateString;
  String? toDateString;
  final _formKey = GlobalKey<FormState>();
  // XFile? _pickedImage;
  Future<void> _selectFromTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedFromTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        selectedFromTime = pickedTime;
      });
    }
  }

  Future<void> _selectToTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedToTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        selectedToTime = pickedTime;
      });
    }
  }

  bool isTimeValid() {
    if (selectedFromTime != null && selectedToTime != null) {
      final DateTime fromDateTime =
          DateTime(0, 0, 0, selectedFromTime!.hour, selectedFromTime!.minute);
      final DateTime toDateTime =
          DateTime(0, 0, 0, selectedToTime!.hour, selectedToTime!.minute);
      return toDateTime.isAfter(fromDateTime);
    }
    return false;
  }

  TextEditingController _titleController = TextEditingController();
  TextEditingController _organizerController = TextEditingController();
  TextEditingController _shortDescriptionController = TextEditingController();
  TextEditingController _fullDescriptionControllerpara1 =
      TextEditingController();
  TextEditingController _fullDescriptionControllerpara2 =
      TextEditingController();
  TextEditingController _linkController = TextEditingController();
  TextEditingController _placeController = TextEditingController();
  final uid = FirebaseAuth.instance.currentUser!.uid;

  String imageUrl = '';
  final CollectionReference event =
      FirebaseFirestore.instance.collection('events');
  void addEvent() async {
    final data = {
      'title': _titleController.text,
      'place': _placeController.text,
      'time': selectedFromTime!.format(context),
      'toTime': selectedToTime!.format(context),
      'date': DateTime.parse(fromDateString!),
      'toDate': DateTime.parse(toDateString!),
      'organizer': _organizerController.text,
      'shortDescription': _shortDescriptionController.text,
      'longDescription1': _fullDescriptionControllerpara1.text,
      'longDescription2': _fullDescriptionControllerpara2.text,
      'link': _linkController.text,
      'imageURL': imageUrl, // Include the imageURL field
      'timestamp': FieldValue.serverTimestamp(),
      'creatorId': uid,
    };

    await event.add(data);
  }

  @override
  Widget build(BuildContext context) {
    String fromTimeText = selectedFromTime != null
        ? selectedFromTime!.format(context)
        : 'Select From Time';

    String toTimeText = selectedToTime != null
        ? selectedToTime!.format(context)
        : 'Select To Time';

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Create Event')),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Name of the event',
                    labelStyle: TextStyle(fontSize: 18.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5)),
                    fillColor: Color.fromARGB(255, 255, 255, 255),
                    filled: true,
                    contentPadding: const EdgeInsets.all(15),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the title';
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: _organizerController,
                    decoration: InputDecoration(
                      labelText: 'Name of the Club',
                      // labelStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      filled: true,
                      contentPadding: const EdgeInsets.all(15),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter the organizer's name";
                      }
                      return null;
                    },
                  )),
              const SizedBox(
                height: 20,
              ),

              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: DateTimePicker(
                      icon: const Icon(Icons.event),
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      dateLabelText: 'from',
                      onChanged: (val) {
                        setState(() {
                          fromDateString =
                              val.toString(); // Convert DateTime to String
                        });
                      },
                      validator: (val) {
                        // Validate the value if needed
                        return null;
                      },
                      onSaved: (val) {
                        // Save the value if needed
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: DateTimePicker(
                      icon: const Icon(Icons.event),
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      dateLabelText: 'to',
                      onChanged: (val) {
                        setState(() {
                          toDateString =
                              val.toString(); // Convert DateTime to String
                        });
                      },
                      validator: (val) {
                        // Validate the value if needed
                        return null;
                      },
                      onSaved: (val) {
                        // Save the value if needed
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 30,
              ),

              // From and to time
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () => _selectFromTime(context),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'From Time',
                        ),
                        child: Text(fromTimeText),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () => _selectToTime(context),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'To Time',
                        ),
                        child: Text(toTimeText),
                      ),
                    ),
                  ),
                ],
              ),

              Text(
                isTimeValid() ? '' : 'To Time must be greater than From Time',
                style: TextStyle(color: Colors.red),
              ),
              // Event Location
              const SizedBox(
                height: 20,
              ),

              Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: _placeController,
                    decoration: InputDecoration(
                      labelText: 'Event Location',
                      // labelStyle: TextStyle(fontSize: 18.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      filled: true,
                      contentPadding: const EdgeInsets.all(10),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the location';
                      }
                      return null;
                    },
                  )),

              SizedBox(
                height: 20,
              ),

              // short Description
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.black,
                    )),
                child: TextFormField(
                  controller: _shortDescriptionController,
                  // Set maxLines to null for a multi-line text area
                  decoration: InputDecoration(
                    labelText: 'Short Description of the event',
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

              Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.black,
                      )),
                  child: TextFormField(
                    controller: _fullDescriptionControllerpara1,
                    decoration: InputDecoration(
                      labelText: 'Long Description of the event(para-1)',
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
                  )),

              const SizedBox(
                height: 20,
              ),

              Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.black,
                      )),
                  child: TextFormField(
                    controller: _fullDescriptionControllerpara2,
                    decoration: InputDecoration(
                      labelText: 'Long Description of the event(para-2)',
                      // labelStyle: TextStyle(fontSize: 18.0),
                      border: InputBorder.none,
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      filled: true,
                      contentPadding: const EdgeInsets.all(15),
                    ),
                    maxLines: null,
                  )),

              const SizedBox(
                height: 20,
              ),

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
                          borderRadius: BorderRadius.circular(5)),
                      fillColor: Color.fromARGB(255, 255, 255, 255),
                      filled: true,
                      contentPadding: const EdgeInsets.all(15),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),

              //attach image
              ElevatedButton(
                onPressed: () async {
                  // _pickedImage = (await ImagePicker()
                  //     .pickImage(source: ImageSource.camera))!;
                  ImagePicker imagePicker = ImagePicker();
                  XFile? file =
                      await imagePicker.pickImage(source: ImageSource.camera);
                  if (file == null) return;

                  String uniqueFilename =
                      DateTime.now().millisecondsSinceEpoch.toString();

                  Reference referenceRoot = FirebaseStorage.instance.ref();
                  Reference ReferenceDirImage = referenceRoot.child('images');
                  Reference ReferenceImageToUpload =
                      ReferenceDirImage.child(uniqueFilename);

                  try {
                    await ReferenceImageToUpload.putFile(File(file!.path));
                    imageUrl = await ReferenceImageToUpload.getDownloadURL();
                  } catch (error) {}
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 185, 185, 185)!),
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

              //submit button
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      addEvent();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditEvent(),
                        ),
                      );
                    }
                    ;
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size(2500, 50)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  child: Text(
                    'Create Event',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
