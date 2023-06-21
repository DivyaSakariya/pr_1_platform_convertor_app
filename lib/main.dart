import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:platform_convertar/provider/add_contact_android.dart';
import 'package:platform_convertar/provider/profile_provider.dart';
import 'package:platform_convertar/provider/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:platform_convertar/provider/platform_provider.dart';
import 'package:platform_convertar/views/screens/android_home_page.dart';
import 'package:platform_convertar/views/screens/ios_home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PlatformProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ContactProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<PlatformProvider, SettingProvider>(
      builder: (context, platformProvider, settingProvider, child) {
        return platformProvider.isAndroid
            ? MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: settingProvider.isDark
                    ? ThemeData.dark(useMaterial3: true)
                    : ThemeData.light(useMaterial3: true),
                home: HomePage_Android(),
              )
            : CupertinoApp(
                debugShowCheckedModeBanner: false,
                theme: CupertinoThemeData(
                  brightness: settingProvider.isDark
                      ? Brightness.dark
                      : Brightness.light,
                ),
                home: HomePage_Ios(),
              );
      },
    );
  }
}
