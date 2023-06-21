// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart' hide TextField;
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
//
// import '../../models/contact.dart';
// import '../../provider/add_contact_android.dart';
//
// class ADDContactScreen extends StatefulWidget {
//   @override
//   State<ADDContactScreen> createState() => _ADDContactScreenState();
// }
//
// class _ADDContactScreenState extends State<ADDContactScreen> {
//   final TextEditingController fullNameController = TextEditingController();
//   final TextEditingController phoneNoController = TextEditingController();
//   final TextEditingController chatController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   File? _imageFile;
//
//   _pickImage() async {
//     final imagePicker = ImagePicker();
//     final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//     }
//   }
//
//   _pickImage_g() async {
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
//     return CupertinoPageScaffold(
//       child: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             children: [
//               Align(
//                 alignment: Alignment.center,
//                 child: Stack(
//                   alignment: Alignment.bottomRight,
//                   children: [
//                     CircleAvatar(
//                       radius: 60,
//                       backgroundImage:
//                           _imageFile != null ? FileImage(_imageFile!) : null,
//                       child: _imageFile == null
//                           ? Icon(
//                               Icons.person,
//                               size: 75,
//                             )
//                           : null,
//                     ),
//                     SizedBox(
//                       width: 38,
//                       child: CupertinoButton(
//                         padding: EdgeInsets.zero,
//                         child: Icon(CupertinoIcons.add),
//                         onPressed: () {
//                           showCupertinoModalPopup(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return CupertinoActionSheet(
//                                 title: Text("Profile photo"),
//                                 actions: [
//                                   CupertinoActionSheetAction(
//                                     onPressed: _pickImage,
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Icon(CupertinoIcons.camera),
//                                         SizedBox(width: 8),
//                                         Text('Camera'),
//                                       ],
//                                     ),
//                                   ),
//                                   CupertinoActionSheetAction(
//                                     onPressed: _pickImage_g,
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Icon(CupertinoIcons
//                                             .photo_fill_on_rectangle_fill),
//                                         SizedBox(width: 8),
//                                         Text('Gallery'),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                                 cancelButton: CupertinoActionSheetAction(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                   },
//                                   child: const Text("Cancel"),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                         minSize: 30,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 16),
//               CupertinoTextField(
//                 controller: fullNameController,
//                 decoration: BoxDecoration(
//                   border: Border.all(),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 prefix: Icon(CupertinoIcons.person),
//                 placeholder: 'Full Name',
//               ),
//               SizedBox(height: 16),
//               CupertinoTextField(
//                 controller: phoneNoController,
//                 decoration: BoxDecoration(
//                   border: Border.all(),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 prefix: Icon(CupertinoIcons.phone),
//                 placeholder: 'Phone Number',
//               ),
//               SizedBox(height: 16),
//               CupertinoTextField(
//                 controller: chatController,
//                 decoration: BoxDecoration(
//                   border: Border.all(),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 prefix: Icon(CupertinoIcons.chat_bubble),
//                 placeholder: 'Chat Conversation',
//               ),
//               SizedBox(height: 16),
//               CupertinoTextField(
//                 controller: emailController,
//                 decoration: BoxDecoration(
//                   border: Border.all(),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 prefix: Icon(CupertinoIcons.mail),
//                 placeholder: 'Email',
//               ),
//               SizedBox(height: 16),
//               CupertinoButton(
//                 onPressed: () {
//                   showCupertinoModalPopup(
//                     context: context,
//                     builder: (BuildContext context) {
//                       DateTime? pickedDate;
//                       return Container(
//                         height: 300,
//                         color: CupertinoColors.white,
//                         child: Column(
//                           children: [
//                             Container(
//                               height: 200,
//                               child: CupertinoDatePicker(
//                                 mode: CupertinoDatePickerMode.date,
//                                 initialDateTime: DateTime.now(),
//                                 minimumYear: 1900,
//                                 maximumYear: 2100,
//                                 onDateTimeChanged: (DateTime dateTime) {
//                                   pickedDate = dateTime;
//                                 },
//                               ),
//                             ),
//                             CupertinoButton(
//                               onPressed: () {
//                                 if (pickedDate != null) {
//                                   final formattedDate =
//                                       DateFormat.yMMMd().format(pickedDate!);
//                                   contactProvider.contacts.last.date =
//                                       formattedDate; // Assign the selected date
//                                   contactProvider.notifyListeners();
//                                 }
//                                 Navigator.pop(context);
//                               },
//                               child: Text('Done'),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 },
//                 child: Text('Pick Date'),
//               ),
//               SizedBox(height: 16),
//               CupertinoButton(
//                 onPressed: () {
//                   showCupertinoModalPopup(
//                     context: context,
//                     builder: (BuildContext context) {
//                       DateTime? pickedTime;
//                       return Container(
//                         height: 300,
//                         color: CupertinoColors.white,
//                         child: Column(
//                           children: [
//                             Container(
//                               height: 200,
//                               child: CupertinoDatePicker(
//                                 mode: CupertinoDatePickerMode.time,
//                                 initialDateTime: DateTime.now(),
//                                 onDateTimeChanged: (DateTime dateTime) {
//                                   pickedTime = dateTime;
//                                 },
//                               ),
//                             ),
//                             CupertinoButton(
//                               onPressed: () {
//                                 if (pickedTime != null) {
//                                   final formattedTime =
//                                       DateFormat.Hm().format(pickedTime!);
//                                   contactProvider.contacts.last.time =
//                                       formattedTime; // Assign the selected time
//                                   contactProvider.notifyListeners();
//                                 }
//                                 Navigator.pop(context);
//                               },
//                               child: Text('Done'),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 },
//                 child: Text('Pick Time'),
//               ),
//               SizedBox(height: 16),
//               CupertinoButton(
//                 onPressed: () {
//                   final fullName = fullNameController.text;
//                   final phoneNo = phoneNoController.text;
//                   final chat = chatController.text;
//                   final email = emailController.text;
//                   final contact = Contact(
//                     fullName: fullName,
//                     phoneNo: phoneNo,
//                     chat: chat,
//                     email: email,
//                     imageFile: _imageFile, // Assign the selected image file
//                   );
//                   contactProvider.saveContact(contact);
//
//                   // Rest of the code...
//                 },
//                 child: Text('Save'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
