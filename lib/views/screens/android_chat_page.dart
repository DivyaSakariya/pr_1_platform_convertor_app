// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../provider/add_contact_android.dart';
//
// class ChatPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final contactProvider = Provider.of<ContactProvider>(context);
//     final contacts = contactProvider.contacts;
//
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: contacts.length,
//         itemBuilder: (context, index) {
//           final contact = contacts[index];
//           return ListTile(
//             leading: CircleAvatar(
//               radius: 55,
//               backgroundImage: contactProvider.contacts[index].imageFile != null
//                   ? FileImage(contactProvider.contacts[index].imageFile!)
//                   : null,
//               child: contactProvider.contacts[index].imageFile == null
//                   ? Icon(Icons.person)
//                   : null,
//             ),
//             title: Text(contact.fullName ?? ''),
//             subtitle: Text(contact.chat ?? ''),
//             trailing: Text('${contact.date ?? ''} \n ${contact.time ?? ''}'),
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/global.dart';

class ChatContactPage extends StatefulWidget {
  const ChatContactPage({Key? key}) : super(key: key);

  @override
  State<ChatContactPage> createState() => _ChatContactPageState();
}

class _ChatContactPageState extends State<ChatContactPage> {
  ImagePicker picker = ImagePicker();

  GlobalKey<FormState> chatEditFormKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: (Global.allChats.isEmpty)
            ? Container(
                alignment: Alignment.center,
                child: const Text("No any chats yet..."),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: Global.allChats.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    shadowColor: Colors.indigo,
                    child: ListTile(
                      onTap: () {
                        // Navigator.of(context).pushNamed('contact_detail_page', arguments: Global.allContacts[index]).then((value) => setState((){}));
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => SingleChildScrollView(
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              height: 350,
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'What do you want to take photos from?'),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () async {
                                                  XFile? pickedPhoto =
                                                      await picker.pickImage(
                                                          source: ImageSource
                                                              .gallery);
                                                  setState(() {
                                                    Global.allChats[index]
                                                            .image =
                                                        File(pickedPhoto!.path);
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("ALBUMS"),
                                              ),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  XFile? pickedFile =
                                                      await picker.pickImage(
                                                          source: ImageSource
                                                              .camera);
                                                  setState(() {
                                                    Global.allChats[index]
                                                            .image =
                                                        File(pickedFile!.path);
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("CAMERA"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 50,
                                      foregroundImage:
                                          (Global.allChats[index].image != null)
                                              ? FileImage(
                                                  Global.allChats[index].image!)
                                              : null,
                                      backgroundColor: Colors.indigo,
                                      child: const Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01),
                                  Form(
                                    key: chatEditFormKey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01),
                                        TextFormField(
                                          controller: fullNameController,
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.text,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Full Name",
                                          ),
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01),
                                        TextFormField(
                                          controller: chatController,
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.text,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Chat",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                  Center(
                                    child: CupertinoButton(
                                      color: Colors.indigo,
                                      onPressed: () {},
                                      child: const Text("CANCEL"),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                        radius: 30,
                        foregroundImage: (Global.allChats[index].image != null)
                            ? FileImage(Global.allChats[index].image!)
                            : null,
                        child: Text(
                          Global.allChats[index].fullName![0].toUpperCase(),
                        ),
                      ),
                      title: Text("${Global.allChats[index].fullName}"),
                      subtitle: Text("${Global.allChats[index].chat}"),
                      trailing: Text(
                          "${Global.allChats[index].date}, ${Global.allChats[index].time}"),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
