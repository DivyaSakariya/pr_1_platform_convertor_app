// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
//
// class ChatPage extends StatelessWidget {
//   @override
//
//   Widget build(BuildContext context) {
//     final contactProvider = Provider.of<ContactProvider>(context);
//     final contacts = contactProvider.contacts;
//
//     return CupertinoPageScaffold(
//       child: SafeArea(
//         child: ListView.builder(
//           itemCount: contacts.length,
//           itemBuilder: (context, index) {
//             final contact = contacts[index];
//             return ListTile(
//               leading: CircleAvatar(
//                 radius: 30,
//                 backgroundImage:
//                     contactProvider.contacts[index].imageFile != null
//                         ? FileImage(contactProvider.contacts[index].imageFile!)
//                         : null,
//                 child: contactProvider.contacts[index].imageFile == null
//                     ? Icon(CupertinoIcons.person)
//                     : null,
//               ),
//               title: Text(contact.fullName ?? ''),
//               subtitle: Text(contact.chat ?? ''),
//               trailing: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(contact.date ?? ''),
//                   SizedBox(height: 4),
//                   Text(contact.time ?? ''),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
