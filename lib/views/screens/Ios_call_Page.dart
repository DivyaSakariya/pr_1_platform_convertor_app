import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../provider/add_contact_android.dart';

class CallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contactProvider = Provider.of<ContactProvider>(context);
    final contacts = contactProvider.contacts;

    return CupertinoPageScaffold(
      child: SafeArea(
        child: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            final contact = contacts[index];
            return ListTile(
              leading: CircleAvatar(
                radius: 35,
                backgroundImage:
                    contactProvider.contacts[index].imageFile != null
                        ? FileImage(contactProvider.contacts[index].imageFile!)
                        : null,
                child: contactProvider.contacts[index].imageFile == null
                    ? Icon(CupertinoIcons.person)
                    : null,
              ),
              title: Text(contact.fullName ?? ''),
              subtitle: Text(contact.phoneNo ?? ''),
              trailing: CupertinoButton(
                onPressed: () async {
                  Uri call = Uri(
                    scheme: 'tel',
                    path: contactProvider.contacts[index].phoneNo,
                  );
                  await launchUrl(call);
                },
                child: Icon(CupertinoIcons.phone),
              ),
            );
          },
        ),
      ),
    );
  }
}
