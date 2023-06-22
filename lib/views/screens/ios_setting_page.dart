import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../provider/settings_provider.dart';
import '../../provider/profile_provider.dart';

class IOsSettingsPage extends StatelessWidget {
  final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Consumer2<SettingProvider, ProfileProvider>(
        builder: (context, settingProvider, profileProvider, child) =>
            SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 120),
              CupertinoFormSection(
                children: [
                  CupertinoListTile(
                    title: const Text('Profile'),
                    leading: const Icon(
                      CupertinoIcons.person,
                      color: CupertinoColors.systemGrey,
                    ),
                    subtitle: const Text('Update Profile Data'),
                    trailing: CupertinoSwitch(
                      value: settingProvider.isSwitched,
                      onChanged: (value) => settingProvider.isSwitched = value,
                    ),
                  ),
                  if (settingProvider.isSwitched)
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (BuildContext context) {
                                  return CupertinoActionSheet(
                                    title: const Text("Profile photo"),
                                    actions: [
                                      CupertinoActionSheetAction(
                                        onPressed: () async {
                                          final pickedPhoto =
                                              await picker.pickImage(
                                            source: ImageSource.camera,
                                          );
                                          if (pickedPhoto != null) {
                                            profileProvider.setImage(
                                                File(pickedPhoto.path));
                                          }
                                          Navigator.of(context).pop();
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              CupertinoIcons.camera,
                                              size: 35,
                                            ),
                                            SizedBox(width: 8),
                                            Text("Camera"),
                                          ],
                                        ),
                                      ),
                                      CupertinoActionSheetAction(
                                        onPressed: () async {
                                          final pickedPhoto =
                                              await picker.pickImage(
                                            source: ImageSource.gallery,
                                          );
                                          if (pickedPhoto != null) {
                                            profileProvider.setImage(
                                                File(pickedPhoto.path));
                                          }
                                          Navigator.of(context).pop();
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              CupertinoIcons.photo,
                                              size: 35,
                                            ),
                                            SizedBox(width: 8),
                                            Text("Gallery"),
                                          ],
                                        ),
                                      ),
                                    ],
                                    cancelButton: CupertinoActionSheetAction(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Cancel"),
                                    ),
                                  );
                                },
                              );
                            },
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: profileProvider.image != null
                                  ? FileImage(profileProvider.image!)
                                  : null,
                              child: const Icon(
                                CupertinoIcons.add_circled,
                                size: 30,
                                color: CupertinoColors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Form(
                            key: profileFormKey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 98.0),
                              child: Column(
                                children: [
                                  CupertinoTextField(
                                    controller: nameController,
                                    placeholder: "Enter your name...",
                                    decoration: const BoxDecoration(
                                      border: null,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  CupertinoTextField(
                                    controller: bioController,
                                    placeholder: "Enter your bio...",
                                    decoration: const BoxDecoration(
                                      border: null,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (profileFormKey.currentState!.validate()) {
                                    profileFormKey.currentState!.save();
                                    profileProvider
                                        .setName(nameController.text);
                                    profileProvider.setBio(bioController.text);
                                  }
                                },
                                child: const Text(
                                  "SAVE",
                                  style: TextStyle(
                                      color: CupertinoColors.activeBlue),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  profileProvider.setName(null);
                                  profileProvider.setBio(null);
                                  nameController.clear();
                                  bioController.clear();
                                  profileProvider.setImage(null);
                                },
                                child: const Text(
                                  "CLEAR",
                                  style: TextStyle(
                                      color: CupertinoColors.activeBlue),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    )
                  else
                    Container(),
                ],
              ),
              CupertinoFormSection(
                children: [
                  CupertinoListTile(
                    title: const Text('Theme'),
                    leading: const Icon(
                      CupertinoIcons.sun_max_fill,
                      color: CupertinoColors.systemGrey,
                    ),
                    subtitle: const Text('Change Theme'),
                    trailing: CupertinoSwitch(
                      value: settingProvider.isDark,
                      onChanged: (value) => settingProvider.isDark = value,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
