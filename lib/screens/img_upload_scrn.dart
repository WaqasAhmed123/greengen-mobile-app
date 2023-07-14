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

  final _imagesStreamController =
      StreamController<List<FetchedImagesModel>>.broadcast();

  Stream<List<FetchedImagesModel>> get _imagesStream =>
      _imagesStreamController.stream;

  ImageUploadScreen(this.imageFolder, {super.key, this.constructionSiteId});

  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  TextEditingController searchController = TextEditingController();
  bool _uploadInProgress = false;

  @override
  void initState() {
    // TODO: implement initState
    // ApiServices.getImages(id: "1184", folderName: "post");
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose(); // Dispose the TextEditingController
    super.dispose();
  }

  // List<String> pickedImagesPath = [];
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
              SizedBox(
                height: 30,
                child: TextField(
                  controller: searchController,
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
                  child: StreamBuilder<List<FetchedImagesModel>>(
                    stream: ApiServices.getImages(
                      id: widget.constructionSiteId,
                      folderName: widget.imageFolder,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData) {
                        final images = snapshot.data!;
                        if (images.isEmpty) {
                          return const Text('No Pictures');
                        }
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 7,
                            crossAxisSpacing: 7,
                            mainAxisExtent: 200,
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) => buildImageWidget(
                            constructionSiteId: widget.constructionSiteId,
                            index: index,
                            images: images,
                            context: context,
                          ),
                          itemCount: images.length,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
