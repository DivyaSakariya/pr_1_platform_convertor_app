import 'dart:io';

import 'package:flutter/material.dart';
import 'package:platform_convertar/provider/platform_provider.dart';
import 'package:platform_convertar/views/screens/add_contact_page.dart';
import 'package:platform_convertar/views/screens/contact_list_page.dart';
import 'package:platform_convertar/views/screens/chat_page.dart';
import 'package:provider/provider.dart';

import 'settings_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin {
  late TabController tabBarController;

  @override
  void initState() {
    super.initState();
    tabBarController = TabController(length: 4, vsync: this);
  }

  bool isAndroid = Platform.isAndroid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: const Text("PlatForm Convertor App"),
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
            controller: tabBarController,
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
        body: TabBarView(controller: tabBarController, children: [
          const AddContactPage(),
          const ChatContactPage(),
          const ContactListPage(),
          SettingsPage(),
        ]));
  }
}
