// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../../provider/add_contact_android.dart';
//
// class ContactListPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final contactProvider = Provider.of<AddContactProvider>(context);
//     final contacts = contactProvider.contacts;
//
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: contacts.length,
//         itemBuilder: (context, index) {
//           final contact = contacts[index];
//           return ListTile(
//             leading: CircleAvatar(
//               radius: 35,
//               backgroundImage: contactProvider.contacts[index].imageFile != null
//                   ? FileImage(contactProvider.contacts[index].imageFile!)
//                   : null,
//               child: contactProvider.contacts[index].imageFile == null
//                   ? Icon(Icons.person)
//                   : null,
//             ),
//             title: Text(contact.fullName ?? ''),
//             subtitle: Text(contact.phoneNo ?? ''),
//             trailing: IconButton(
//               onPressed: () async {
//                 Uri call = Uri(
//                     scheme: 'tel',
//                     path: contactProvider.contacts[index].phoneNo);
//                 await launchUrl(call);
//               },
//               icon: Icon(Icons.call),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/global.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({Key? key}) : super(key: key);

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: (Global.allContacts.isEmpty)
            ? Container(
                alignment: Alignment.center,
                child: const Text("No any calls yet..."),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: Global.allContacts.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    shadowColor: Colors.indigo,
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed('contact_detail_page',
                                arguments: Global.allContacts[index])
                            .then((value) => setState(() {}));
                      },
                      leading: CircleAvatar(
                        radius: 30,
                        foregroundImage:
                            (Global.allContacts[index].image != null)
                                ? FileImage(Global.allContacts[index].image!)
                                : null,
                        child: Text(
                          Global.allContacts[index].fullName![0].toUpperCase(),
                        ),
                      ),
                      title: Text("${Global.allContacts[index].fullName}"),
                      subtitle:
                          Text("+91 ${Global.allContacts[index].phoneNo}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.phone),
                        color: Colors.green,
                        onPressed: () async {
                          Uri call = Uri(
                            scheme: 'tel',
                            path: Global.allContacts[index].phoneNo,
                          );
                          await launchUrl(call);
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
