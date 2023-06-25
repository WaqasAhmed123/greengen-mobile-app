import 'dart:io';

import 'package:flutter/material.dart';
import 'package:greengen/model/img_upload.dart';
import 'package:greengen/screens/all_users_scrn.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({super.key});

  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  String _selectedOption = '';
  // File? imageFile;
  List<String> pickedImagesPath = [];
  List<File> images = [];

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
        pickedImagesPath.add(file.path);
        print(file.path);
      }

      setState(() {
        images.addAll(imageFiles);
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
    return Scaffold(
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AllUsersScreen()),
                    );
                  },
                  child: const Text(
                    'PASQUALE',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.person,
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
                const SizedBox(
                  height: 30,
                  child: TextField(
                    // textAlignVertical: TextAlignVertical.center,

                    style: TextStyle(fontSize: 10, color: Colors.grey),
                    decoration: InputDecoration(
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
        ));
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
