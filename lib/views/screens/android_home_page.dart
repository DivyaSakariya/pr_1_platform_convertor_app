import 'dart:io';

import 'package:flutter/material.dart';
import 'package:platform_convertar/provider/platform_provider.dart';
import 'package:platform_convertar/views/screens/android_add_contact_page.dart';
import 'package:platform_convertar/views/screens/android_call_page.dart';
import 'package:platform_convertar/views/screens/android_chat_page.dart';
import 'package:provider/provider.dart';

import 'android_setting_Page.dart';

class HomePage_Android extends StatefulWidget {
  HomePage_Android({Key? key}) : super(key: key);

  @override
  State<HomePage_Android> createState() => _HomePage_AndroidState();
}

class _HomePage_AndroidState extends State<HomePage_Android>
    with TickerProviderStateMixin {
  late TabController tabbarController;

  @override
  void initState() {
    super.initState();
    tabbarController = TabController(length: 4, vsync: this);
  }

  bool isAndroid = Platform.isAndroid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Text(isAndroid ? "Android App" : "iOS App"),
          centerTitle: true,
          actions: [
            Consumer<PlatformProvider>(
              builder: (context, provider, child) => Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: provider.isAndroid,
                  onChanged: (val) {
                    provider.changePlatform(value: val);
                  },
                ),
              ),
            ),
          ],
          bottom: TabBar(
            controller: tabbarController,
            tabs: const [
              Tab(
                icon: Icon(Icons.add_ic_call_outlined),
              ),
              Tab(
                child: Text("CHATS"),
              ),
              Tab(
                child: Text("CALLS"),
              ),
              Tab(
                child: Text("SETTINGS"),
              ),
            ],
          ),
        ),
        body: TabBarView(controller: tabbarController, children: [
          const AddContactPage(),
          const ContactListPage(),
          const ChatContactPage(),
          SettingsPage(),
        ]));
  }
}
