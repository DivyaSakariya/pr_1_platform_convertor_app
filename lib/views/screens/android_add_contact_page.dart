import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/conatact_models.dart';
import '../../provider/add_contact_android.dart';

class ADDContactScreen extends StatefulWidget {
  @override
  State<ADDContactScreen> createState() => _ADDContactScreenState();
}

class _ADDContactScreenState extends State<ADDContactScreen> {
  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController phoneNoController = TextEditingController();

  final TextEditingController chatController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  File? _imageFile;

  _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  _pickImage_g() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Contact'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: const EdgeInsets.all(18),
                        height: 170,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Profile photo",
                                ),
                                // IconButton(
                                //     onPressed: () {},
                                //     icon: Icon(Icons.delete))
                              ],
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 65,
                                      child: ElevatedButton(
                                          child: Icon(
                                            Icons.add_a_photo_outlined,
                                            size: 35,
                                          ),
                                          // title: Text('Camera'),
                                          onPressed: _pickImage),
                                    ),
                                    SizedBox(
                                      height: 9,
                                    ),
                                    Text(
                                      "Camera",
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 65,
                                      child: ElevatedButton(
                                          child: Icon(
                                            Icons.photo_library,
                                            size: 35,
                                          ),
                                          // title: Text('Gallery'),
                                          onPressed: _pickImage_g),
                                    ),
                                    SizedBox(
                                      height: 9,
                                    ),
                                    Text(
                                      "Gallery",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      _imageFile != null ? FileImage(_imageFile!) : null,
                  child: _imageFile == null
                      ? Icon(
                          Icons.person,
                          size: 75,
                        )
                      : null,
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: fullNameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: phoneNoController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: chatController,
              decoration: InputDecoration(
                labelText: 'Chat Conversation',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.chat),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Text('Pick Date'),
                ],
              ),
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  final formattedDate = DateFormat.yMMMd().format(pickedDate);
                  contactProvider.contacts.last.date =
                      formattedDate; // Assign the selected date
                  contactProvider.notifyListeners();
                }
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.watch_later_outlined,
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Text('Pick Time'),
                ],
              ),
              onTap: () async {
                final pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  final formattedTime = pickedTime.format(context);
                  contactProvider.contacts.last.time =
                      formattedTime; // Assign the selected time
                  contactProvider.notifyListeners();
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                final fullName = fullNameController.text;
                final phoneNo = phoneNoController.text;
                final chat = chatController.text;
                final email = emailController.text;
                final contact = Contact(
                  fullName: fullName,
                  phoneNo: phoneNo,
                  chat: chat,
                  email: email,
                  imageFile: _imageFile, // Assign the selected image file
                );
                contactProvider.saveContact(contact);

                // Rest of the code...
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
