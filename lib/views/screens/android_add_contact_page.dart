// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
//
// import '../../models/contact.dart';
// import '../../provider/add_contact_android.dart';
//
// class AddContactPage extends StatefulWidget {
//   @override
//   State<AddContactPage> createState() => _AddContactPageState();
// }
//
// class _AddContactPageState extends State<AddContactPage> {
//   final TextEditingController fullNameController = TextEditingController();
//   final TextEditingController phoneNoController = TextEditingController();
//   final TextEditingController chatController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   File? _imageFile;
//
//   _pickImage_camera() async {
//     final imagePicker = ImagePicker();
//     final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//     }
//   }
//
//   _pickImage_gallery() async {
//     final imagePicker = ImagePicker();
//     final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final contactProvider = Provider.of<AddContactProvider>(context);
//
//     return Scaffold(
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Align(
//               alignment: Alignment.center,
//               child: GestureDetector(
//                 onTap: () {
//                   showModalBottomSheet(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return Container(
//                         padding: const EdgeInsets.all(18),
//                         height: 170,
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: const [
//                                 Text(
//                                   "Profile photo",
//                                 ),
//                               ],
//                             ),
//                             Spacer(),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Column(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     SizedBox(
//                                       height: 65,
//                                       child: ElevatedButton(
//                                           child: Icon(
//                                             Icons.add_a_photo_outlined,
//                                             size: 35,
//                                           ),
//                                           // title: Text('Camera'),
//                                           onPressed: _pickImage_camera),
//                                     ),
//                                     SizedBox(
//                                       height: 9,
//                                     ),
//                                     Text(
//                                       "Camera",
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   width: 8,
//                                 ),
//                                 Column(
//                                   children: [
//                                     SizedBox(
//                                       height: 65,
//                                       child: ElevatedButton(
//                                           child: Icon(
//                                             Icons.photo_library,
//                                             size: 35,
//                                           ),
//                                           // title: Text('Gallery'),
//                                           onPressed: _pickImage_gallery),
//                                     ),
//                                     SizedBox(
//                                       height: 9,
//                                     ),
//                                     Text(
//                                       "Gallery",
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 },
//                 child: CircleAvatar(
//                   radius: 60,
//                   backgroundImage:
//                       _imageFile != null ? FileImage(_imageFile!) : null,
//                   child: _imageFile == null
//                       ? Icon(
//                           Icons.person,
//                           size: 75,
//                         )
//                       : null,
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: fullNameController,
//               decoration: InputDecoration(
//                 labelText: 'Full Name',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.person),
//               ),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: phoneNoController,
//               decoration: InputDecoration(
//                 labelText: 'Phone Number',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.phone),
//               ),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: chatController,
//               decoration: InputDecoration(
//                 labelText: 'Chat Conversation',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.chat),
//               ),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: emailController,
//               decoration: InputDecoration(
//                 labelText: 'Email',
//                 border: OutlineInputBorder(),
//                 prefixIcon: Icon(Icons.email),
//               ),
//             ),
//             ListTile(
//               title: Row(
//                 children: [
//                   Icon(
//                     Icons.calendar_month_outlined,
//                     size: 18,
//                   ),
//                   SizedBox(width: 8),
//                   Text('Pick Date'),
//                 ],
//               ),
//               onTap: () async {
//                 final pickedDate = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(1900),
//                   lastDate: DateTime(2100),
//                 );
//                 if (pickedDate != null) {
//                   final formattedDate = DateFormat.yMMMd().format(pickedDate);
//                   contactProvider.contacts.last.date =
//                       formattedDate; // Assign the selected date
//                   contactProvider.notifyListeners();
//                 }
//               },
//             ),
//             ListTile(
//               title: Row(
//                 children: [
//                   Icon(
//                     Icons.watch_later_outlined,
//                     size: 18,
//                   ),
//                   SizedBox(width: 8),
//                   Text('Pick Time'),
//                 ],
//               ),
//               onTap: () async {
//                 final pickedTime = await showTimePicker(
//                   context: context,
//                   initialTime: TimeOfDay.now(),
//                 );
//                 if (pickedTime != null) {
//                   final formattedTime = pickedTime.format(context);
//                   contactProvider.contacts.last.time =
//                       formattedTime; // Assign the selected time
//                   contactProvider.notifyListeners();
//                 }
//               },
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 final fullName = fullNameController.text;
//                 final phoneNo = phoneNoController.text;
//                 final chat = chatController.text;
//                 final email = emailController.text;
//                 final contact = Contact(
//                   fullName: fullName,
//                   phoneNo: phoneNo,
//                   chat: chat,
//                   email: email,
//                   imageFile: _imageFile, // Assign the selected image file
//                 );
//                 contactProvider.saveContact(contact);
//
//                 // Rest of the code...
//               },
//               child: Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../models/contact.dart';
import '../../models/global.dart';
import '../../provider/add_contact_android.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final ImagePicker picker = ImagePicker();
  File? image;

  GlobalKey<FormState> addContactFormKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController chatController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String pickedDate = "";
  String pickedTime = "";

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h * 0.04),
              Center(
                child: GestureDetector(
                  onTap: () => showImageActionSheet(context),
                  child: CircleAvatar(
                    foregroundImage: (image != null) ? FileImage(image!) : null,
                    backgroundColor: Colors.indigo,
                    radius: 60,
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: h * 0.04),
              Form(
                key: addContactFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: h * 0.02),
                    const Text("Full Name"),
                    SizedBox(height: h * 0.01),
                    TextFormField(
                      controller: fullNameController,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Your Name First...";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.account_circle_outlined),
                        hintText: "Full Name",
                      ),
                    ),
                    SizedBox(height: h * 0.02),
                    const Text("Phone No."),
                    SizedBox(height: h * 0.01),
                    TextFormField(
                      controller: phoneNoController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Your Phone Number...";
                        } else if (value.length != 10) {
                          return "Enter 10 Digits Phone Number...";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.call),
                        hintText: "Phone No.",
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    const Text("Chat Conversation"),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    TextFormField(
                      controller: chatController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.chat_outlined),
                        hintText: "Chat Conversation",
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    const Text("Email I'd"),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    TextFormField(
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Your Email I'd...";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                        hintText: "Email",
                      ),
                    ),
                    SizedBox(height: h * 0.02),
                    Consumer<AddContactProvider>(
                      builder: (context, provider, child) => Row(
                        children: [
                          GestureDetector(
                              child: Row(
                                children: const [
                                  Icon(Icons.calendar_month_outlined),
                                  Text("Pick Date"),
                                ],
                              ),
                              onTap: () {
                                provider.showMyDate(context);
                              }),
                          SizedBox(width: w * 0.08),
                          Text(provider.date),
                        ],
                      ),
                    ),
                    SizedBox(height: h * 0.02),
                    Consumer<AddContactProvider>(
                      builder: (context, provider, child) => Row(
                        children: [
                          GestureDetector(
                            child: Row(
                              children: const [
                                Icon(Icons.watch_later_outlined),
                                Text("Pick Time"),
                              ],
                            ),
                            onTap: () {
                              provider.showMyTime(context);
                              // setState(() {
                              //   pickedTime = provider.time;
                              // });
                            },
                          ),
                          SizedBox(width: w * 0.08),
                          Text(provider.time),
                        ],
                      ),
                    ),
                    SizedBox(height: h * 0.02),
                    Center(
                      child: OutlinedButton(
                        onPressed: () {
                          if (addContactFormKey.currentState!.validate()) {
                            addContactFormKey.currentState!.save();

                            Contact c1 = Contact(
                              fullName: fullNameController.text,
                              phoneNo: phoneNoController.text,
                              chat: chatController.text,
                              email: emailController.text,
                              image: image,
                              date: Provider.of<AddContactProvider>(context,
                                      listen: false)
                                  .date,
                              time: Provider.of<AddContactProvider>(context,
                                      listen: false)
                                  .time,
                            );

                            if (chatController == "") {
                              null;
                            } else if (chatController != "") {
                              Global.allChats.add(c1);
                            }

                            fullNameController.clear();
                            phoneNoController.clear();
                            chatController.clear();
                            emailController.clear();
                            image = null;
                            Provider.of<AddContactProvider>(context,
                                    listen: false)
                                .date = "";
                            Provider.of<AddContactProvider>(context,
                                    listen: false)
                                .time = "";
                            Global.allContacts.add(c1);
                          }
                        },
                        child: const Text("SAVE"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showImageActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text("Image Picker"),
        message: const Text("Click Any One For Take Image"),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () async {
                  XFile? pickedPhoto =
                      await picker.pickImage(source: ImageSource.gallery);
                  setState(() {
                    image = File(pickedPhoto!.path);
                  });
                  Navigator.pop(context);
                },
                child: const Icon(Icons.photo),
              ),
              ElevatedButton(
                onPressed: () async {
                  XFile? pickedFile =
                      await picker.pickImage(source: ImageSource.camera);
                  setState(() {
                    image = File(pickedFile!.path);
                  });
                  Navigator.pop(context);
                },
                child: const Icon(Icons.camera),
              ),
            ],
          )
        ],
      ),
    );
  }
}
