import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:greengen/model/img_upload.dart';
import 'package:greengen/model/user_model.dart';
import 'package:greengen/screens/all_users_scrn.dart';
import 'package:greengen/screens/login.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({super.key});

  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  void dispose() {
    searchController.dispose(); // Dispose the TextEditingController
    super.dispose();
  }

  String _selectedOption = '';
  // File? imageFile;
  List<String> pickedImagesPath = [];
  List<File> images = [];
  List<String> popUpOptionsList = [
    UserModel.name.toString(),
    // UserModel.email.toString()=="null"?"NA":UserModel.email.toString(),
    UserModel.locallyStoredemail.toString(),
    "Password Reset",
    "Logout"
  ];

  Widget _buildImageWidget(int index) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Image.file(
                File(pickedImagesPath[index]),
                fit: BoxFit.contain,
              ),
            );
          },
        );
      },
      child: SizedBox(
        width: 50,
        height: 50,
        child: Image.file(
          File(pickedImagesPath[index]),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Future<void> _getFromGallery() async {
    // List<XFile> pickedFiles = await ImagePicker().pickMultiImage();
    List<XFile> pickedFiles = await ImagePicker().pickMultiImage();

    if (pickedFiles.isNotEmpty) {
      List<File> imageFiles = [];

      for (var pickedFile in pickedFiles) {
        final file = File(pickedFile.path);
        imageFiles.add(file);
        // pickedImagesPath.add(file.path);
        print(file.path);
      }
      images.addAll(imageFiles);

      setState(() {
        // images = imageFiles;
        // images.addAll(imageFiles);
      });
      print(images);
      print(images.length);

      if (await ImageUpload.uploadImage(
              // token: token,
              images: images,
              // constructionSideId: 551,
              folder: _selectedOption) ==
          true) {
        setState(() {
          for (var image in imageFiles) {
            pickedImagesPath.add(image.path);
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image(s) Uploaded'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to Upload'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  // _getFromCamera() async {
  //   PickedFile? pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.camera,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  //   if (pickedFile != null) {
  //     File imageFile = File(pickedFile.path);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Close the app completely
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            titleSpacing: 0,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Image.asset(
                    'assets/pictures/logo.png',
                    width: 100,
                    // height: 32,
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      showMenu(
                        context: context,
                        position: const RelativeRect.fromLTRB(20, 0, 0, 0),
                        items: <PopupMenuEntry>[
                          PopupMenuItem(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List<Widget>.generate(
                                popUpOptionsList.length,
                                (index) => Align(
                                  alignment: Alignment.topLeft,
                                  child: TextButton(
                                    onPressed: () async {
                                      // Handle option based on index
                                      if (index == 0) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AllUsersScreen()),
                                        );
                                      } else if (index == 1) {
                                        // Handle email option
                                      } else if (index == 2) {
                                        // Handle password reset option
                                      } else if (index == 3) {
                                        if (await UserModel.logout() == true) {
                                          print(
                                              'Logout successful. Navigating to Login screen.');
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Login()),
                                            (route) => false,
                                          );
                                        }
                                        // Handle logout option
                                      }
                                    },
                                    child: Text(
                                      popUpOptionsList[index],
                                      style: TextStyle(
                                          color: index == 2 || index == 3
                                              ? Colors.blue
                                              : index == 1
                                                  ? Colors.black
                                                      .withOpacity(0.5)
                                                  : Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const PopupMenuItem(
                              child: Divider(
                            height: 0,
                            color: Colors.black,
                          )),
                          PopupMenuItem(
                              child: TextButton(
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AllUsersScreen())),
                                  child: const Text(
                                    "All Users",
                                    style: TextStyle(color: Colors.black),
                                  ))),
                          // PopupMenuItem(
                          //   child: ListTile(
                          //     title: const Text('Username'),
                          //     onTap: () {
                          //       // Handle username option
                          //     },
                          //   ),
                          // ),
                          // PopupMenuItem(
                          //   child: ListTile(
                          //     title: const Text('Email'),
                          //     onTap: () {
                          //       // Handle email option
                          //     },
                          //   ),
                          // ),
                          // PopupMenuItem(
                          //   child: ListTile(
                          //     title: const Text('Reset Password'),
                          //     onTap: () {
                          //       // Handle reset password option
                          //     },
                          //   ),
                          // ),
                          // PopupMenuItem(
                          //   child: ListTile(
                          //     title: const Text('Logout'),
                          //     onTap: () {
                          //       // Handle logout option
                          //     },
                          //   ),
                          // ),
                          // const PopupMenuItem(
                          //     child: Divider(
                          //   color: Colors.black,
                          // )),
                          // PopupMenuItem(
                          //   child: ListTile(
                          //     title: const Text('All User'),
                          //     onTap: () {
                          //       Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (context) => AllUsersScreen()));

                          //       // Handle logout option
                          //     },
                          //   ),
                          // ),
                        ],
                      );
                    },
                    child: const Text(
                      'PASQUALE',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => const AllUsersScreen()),
                  //     );
                  //   },
                  //   child: const Text(
                  //     'PASQUALE',
                  //     style: TextStyle(
                  //         fontSize: 15,
                  //         color: Colors.white,
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.person,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        "Immagini Anti Opera",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const Row(
                    children: [
                      Text(
                        "Premi sui tre puniti (1) per scaricare o eliminare un'immagnini",
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          _showUploadOptions();
                          // _getFromGallery();
                        },
                        child: Container(
                          height: 20,
                          width: 80,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColorLight)),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "CARRICA IMMAGINE",
                              style: TextStyle(
                                  fontSize: 7,
                                  color: Theme.of(context).primaryColorDark),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 30,
                    child: TextField(
                      controller: searchController,
                      // textAlignVertical: TextAlignVertical.center,

                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                      decoration: const InputDecoration(
                        hintText: 'Cerca Immagine',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        contentPadding: EdgeInsets.all(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 7,
                                crossAxisSpacing: 7,
                                crossAxisCount: 3),
                        itemBuilder: ((context, index) =>
                            _buildImageWidget(index)),
                        // itemCount: images.length,
                        itemCount: pickedImagesPath.length,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  void _showUploadOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Upload Options'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<String>(
                    title: const Text('ante'),
                    value: 'ante',
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('cantiere'),
                    value: 'cantiere',
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('post'),
                    value: 'post',
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('durante'),
                    value: 'durante',
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value!;
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    _getFromGallery();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Upload'),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
