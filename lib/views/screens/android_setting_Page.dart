import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../provider/settings_provider.dart';
import '../../provider/profile_provider.dart';

class SettingsPage extends StatelessWidget {
  final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<SettingProvider, ProfileProvider>(
        builder: (context, settingProvider, profileProvider, child) =>
            SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                title: Text("Profile"),
                subtitle: Text("Update Profile Data"),
                trailing: Switch(
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
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                padding: const EdgeInsets.all(18),
                                height: 170,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Profile photo",
                                        ),
                                        // IconButton(
                                        //     onPressed: () {},
                                        //     icon: Icon(Icons.delete))
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              height: 65,
                                              child: ElevatedButton(
                                                  child: Icon(
                                                    Icons.camera_alt,
                                                    size: 35,
                                                  ),
                                                  // title: Text('Camera'),
                                                  onPressed: () async {
                                                    final pickedPhoto =
                                                        await picker.pickImage(
                                                      source:
                                                          ImageSource.camera,
                                                    );
                                                    if (pickedPhoto != null) {
                                                      profileProvider.setImage(
                                                          File(pickedPhoto
                                                              .path));
                                                    }
                                                    Navigator.of(context).pop();
                                                  }),
                                            ),
                                            SizedBox(
                                              height: 9,
                                            ),
                                            Text(
                                              "Camera",
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 65,
                                              child: ElevatedButton(
                                                  child: Icon(
                                                    Icons.photo_library,
                                                    size: 35,
                                                  ),
                                                  // title: Text('Gallery'),
                                                  onPressed: () async {
                                                    final pickedPhoto =
                                                        await picker.pickImage(
                                                      source:
                                                          ImageSource.gallery,
                                                    );
                                                    if (pickedPhoto != null) {
                                                      profileProvider.setImage(
                                                          File(pickedPhoto
                                                              .path));
                                                    }
                                                    Navigator.of(context).pop();
                                                  }),
                                            ),
                                            SizedBox(
                                              height: 9,
                                            ),
                                            Text(
                                              "Gallery",
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );

                          // return AlertDialog(
                          //   title: const Text(
                          //       'What do you want to take photos from?'),
                          //   actions: [
                          //     ElevatedButton(
                          //       onPressed: () async {
                          //         final pickedPhoto =
                          //             await picker.pickImage(
                          //           source: ImageSource.gallery,
                          //         );
                          //         if (pickedPhoto != null) {
                          //           profileProvider
                          //               .setImage(File(pickedPhoto.path));
                          //         }
                          //         Navigator.of(context).pop();
                          //       },
                          //       child: const Text("ALBUMS"),
                          //     ),
                          //     ElevatedButton(
                          //       onPressed: () async {
                          //         final pickedFile = await picker.pickImage(
                          //           source: ImageSource.camera,
                          //         );
                          //         if (pickedFile != null) {
                          //           profileProvider
                          //               .setImage(File(pickedFile.path));
                          //         }
                          //         Navigator.of(context).pop();
                          //       },
                          //       child: const Text("CAMERA"),
                          //     ),
                          //   ],
                          // );
                        },
                        child: CircleAvatar(
                          radius: 50,
                          foregroundImage: profileProvider.image != null
                              ? FileImage(profileProvider.image!)
                              : null,
                          child: const Icon(
                            Icons.add_a_photo_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Form(
                        key: profileFormKey,
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 118.0),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: nameController,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter Your Name First...";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter your name...",
                                ),
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: bioController,
                                textInputAction: TextInputAction.done,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter your bio...",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (profileFormKey.currentState!.validate()) {
                                profileFormKey.currentState!.save();
                                profileProvider.setName(nameController.text);
                                profileProvider.setBio(bioController.text);
                              }
                            },
                            child: const Text(
                              "SAVE",
                              style: TextStyle(color: Colors.blue),
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
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                )
              else
                Container(),
              const Divider(),
              ListTile(
                leading: Icon(
                  Icons.sunny,
                  color: Colors.grey,
                ),
                title: Text("Theme"),
                subtitle: Text("Change Theme"),
                trailing: Switch(
                  value: settingProvider.isDark,
                  onChanged: (value) => settingProvider.isDark = value,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
