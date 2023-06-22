import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/global.dart';

class IOsChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: (Global.allContacts.isEmpty)
            ? Container(
                alignment: Alignment.center,
                child: const Text("No any calls yet..."),
              )
            : ListView.builder(
                itemCount: Global.allContacts.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: CupertinoListTile(
                      leading: CircleAvatar(
                        radius: 35,
                        backgroundImage: Global.allContacts[index].image != null
                            ? FileImage(Global.allContacts[index].image!)
                            : null,
                        child: Global.allContacts[index].image == null
                            ? const Icon(CupertinoIcons.person)
                            : null,
                      ),
                      title: Text(Global.allContacts[index].fullName!),
                      subtitle: Text(Global.allContacts[index].chat!),
                      trailing: Row(
                        children: [
                          Text(Global.allContacts[index].date!),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.4),
                          Text(Global.allContacts[index].time!),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
