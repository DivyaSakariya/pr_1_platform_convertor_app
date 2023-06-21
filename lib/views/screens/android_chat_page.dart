import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/add_contact_android.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context);
    final contacts = contactProvider.contacts;

    return Scaffold(
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            leading: CircleAvatar(
              radius: 55,
              backgroundImage: contactProvider.contacts[index].imageFile != null
                  ? FileImage(contactProvider.contacts[index].imageFile!)
                  : null,
              child: contactProvider.contacts[index].imageFile == null
                  ? Icon(Icons.person)
                  : null,
            ),
            title: Text(contact.fullName ?? ''),
            subtitle: Text(contact.chat ?? ''),
            trailing: Text('${contact.date ?? ''} \n ${contact.time ?? ''}'),
          );
        },
      ),
    );
  }
}
