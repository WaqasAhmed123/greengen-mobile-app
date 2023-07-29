import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:greengen/model/image_%20model.dart';
import 'package:image_picker/image_picker.dart';

import '../apis/api_services.dart';
import '../model/fetched_image_model.dart';
import '../widgets/grid_view_Image.dart';

class ImageUploadScreen extends StatefulWidget {
  String imageFolder;
  String? constructionSiteId;
  String sentenceCase(String input) {
    if (input.isEmpty) {
      return '';
    }
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }

  ImageUploadScreen(this.imageFolder, {super.key, this.constructionSiteId});

  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  TextEditingController searchController = TextEditingController();
  String? token;
  Future<List<FetchedImagesModel>> _fetchImages() async {
    return await ApiServices.getImages(
      id: widget.constructionSiteId,
      folderName: widget.imageFolder,
    );
  }

  @override
  void initState() {
    // token = UserModel.getToken().toString();
    // print(token);
    // TODO: implement initState
    // ApiServices.getImages(id: "1184", folderName: "post");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // List<String> pickedImagesPath = [];
  List<File> images = [];
  bool _uploadInProgress = false;
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

      if (await ImageModel.uploadImages(
              // token: token,
              images: images,
              constructionSiteId: widget.constructionSiteId,
              folder: widget.imageFolder) ==
          true) {
        print(widget.imageFolder);
        setState(() {
          // for (var image in imageFiles) {
          //   pickedImagesPath.add(image.path);
          // }
          _uploadInProgress = false; // Set upload flag to false
        });
        images.clear();
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
              Row(
                children: [
                  Text(
                    "Immagini ${widget.sentenceCase(widget.imageFolder)} Opera",
                    style: const TextStyle(
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
                  _getFromGallery();
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
                    child:
                        // _uploadInProgress // Show indicator based on flag
                        //     ? const CircularProgressIndicator(
                        //         strokeWidth: 2,
                        //       ) // Circular indicator when upload is in progress
                        //     :
                        Text(
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
                  child: Stack(
                    children: [
                      FutureBuilder<List<FetchedImagesModel>>(
                        future: _fetchImages(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasData) {
                            final images = snapshot.data!;
                            if (images.isEmpty) {
                              return const Center(child: Text('No Images'));
                            }
                            return buildImageWidget(
                              constructionSiteId: widget.constructionSiteId!,
                              images: images,
                              context: context,
                              onDelete: onDelete,
                            );
                          } else {
                            if (!snapshot.hasData) {
                              return const Center(child: Text('No Images'));
                            } else {
                              return const Text('Failed To Load Images');
                            }
                          }
                        },
                      ),
                      if (_uploadInProgress)
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onDelete() {
    setState(() {});
  }
}
