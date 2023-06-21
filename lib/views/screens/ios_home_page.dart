import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_convertar/provider/platform_provider.dart';
import 'package:platform_convertar/views/screens/Ios_add_Page.dart';
import 'package:platform_convertar/views/screens/Ios_call_Page.dart';
import 'package:platform_convertar/views/screens/ios_setting_page.dart';
import 'package:provider/provider.dart';

import 'Ios_chat_Page.dart';
import 'android_setting_Page.dart';

class HomePage_Ios extends StatefulWidget {
  const HomePage_Ios({Key? key}) : super(key: key);

  @override
  _HomePage_IosState createState() => _HomePage_IosState();
}

class _HomePage_IosState extends State<HomePage_Ios> {
  final List<Widget> _pages = [
    // Ios_AddPage(),
    // ADDContactScreen(),
    // ChatPage(),
    // CallPage(),
    IOS_SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor:
            CupertinoColors.extraLightBackgroundGray.withOpacity(0),
        trailing:
            Consumer<PlatformProvider>(builder: (context, provider, widget) {
          return Transform.scale(
            scale: 0.8,
            child: CupertinoSwitch(
              value: provider.isAndroid,
              onChanged: (val) => provider.changePlatform(value: val),
            ),
          );
        }),
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_add),
              label: 'ADD CONTACT',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble_2),
              label: 'CHATS',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.phone),
              label: 'CALLS',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings),
              label: 'SETTINGS',
            ),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
            builder: (BuildContext context) {
              return _pages[index];
            },
          );
        },
      ),
    );
  }
}
