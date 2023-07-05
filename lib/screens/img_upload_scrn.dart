import 'dart:io';

import 'package:flutter/material.dart';
import 'package:greengen/model/image_%20model.dart';
import 'package:greengen/screens/all_users_scrn.dart';
import 'package:greengen/widgets/appbar_show_menu.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/grid_view_Image.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({super.key});

  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  TextEditingController searchController = TextEditingController();
  bool _uploadInProgress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose(); // Dispose the TextEditingController
    super.dispose();
  }

  String _selectedOption = '';
  List<String> pickedImagesPath = [];
  List<File> images = [];

  Future<void> _getFromGallery() async {
    // List<XFile> pickedFiles = await ImagePicker().pickMultiImage();
    List<XFile> pickedFiles = await ImagePicker().pickMultiImage();

    if (pickedFiles.isNotEmpty) {
      setState(() {
        _uploadInProgress = true; // Set upload flag to true
      });

      List<File> imageFiles = [];

      for (var pickedFile in pickedFiles) {
        final file = File(pickedFile.path);
        imageFiles.add(file);
        // pickedImagesPath.add(file.path);
        print(file.path);
      }
      images.addAll(imageFiles);

      print(images);
      print(images.length);

      if (await ImageModel.uploadImage(
              // token: token,
              images: images,
              // constructionSideId: 551,
              folder: _selectedOption) ==
          true) {
        setState(() {
          for (var image in imageFiles) {
            pickedImagesPath.add(image.path);
          }
          _uploadInProgress = false; // Set upload flag to false
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image(s) Uploaded'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        setState(() {
          _uploadInProgress = false; // Set upload flag to false
        });
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
              showPopUp(
                context: context,
                scrName: "Tutti gli utenti",
                navFunc: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AllUsersScreen(),
                    ),
                  );
                },
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              const Row(
                children: [
                  Text(
                    // "Immagini Anti Opera",
                    "Immagini Post Opera",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "Premi sui tre puntini (I) per scaricare o eliminare un'immagnini",
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 7,
              ),
              InkWell(
                onTap: () {
                  _showUploadOptions();
                  // _getFromGallery();
                },
                child: Container(
                  height: 20,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: _uploadInProgress // Show indicator based on flag
                        ? const CircularProgressIndicator(
                            strokeWidth: 2,
                          ) // Circular indicator when upload is in progress
                        : Text(
                            "CARRICA IMMAGINE",
                            style: TextStyle(
                              fontSize: 7,
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                child: Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      // childAspectRatio: 1.3,
                      mainAxisSpacing: 7,
                      crossAxisSpacing: 7,
                      mainAxisExtent: 200,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: ((context, index) => buildImageWidget(
                          index: index,
                          pickedImagesPath: pickedImagesPath,
                          // deleteImage: ImageModel.imageModels,
                          removeImage: () {
                            setState(() {
                              pickedImagesPath.removeAt(index);
                            });
                          },
                          context: context,
                        )),
                    // itemCount: images.length,
                    itemCount: pickedImagesPath.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
