import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../provider/add_contact_android.dart';

class CallPage extends StatelessWidget {
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
              radius: 35,
              backgroundImage: contactProvider.contacts[index].imageFile != null
                  ? FileImage(contactProvider.contacts[index].imageFile!)
                  : null,
              child: contactProvider.contacts[index].imageFile == null
                  ? Icon(Icons.person)
                  : null,
            ),
            title: Text(contact.fullName ?? ''),
            subtitle: Text(contact.phoneNo ?? ''),
            trailing: IconButton(
              onPressed: () async {
                Uri call = Uri(
                    scheme: 'tel',
                    path: contactProvider.contacts[index].phoneNo);
                await launchUrl(call);
              },
              icon: Icon(Icons.call),
            ),
          );
        },
      ),
    );
  }
}
