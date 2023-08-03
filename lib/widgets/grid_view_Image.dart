import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../model/fetched_image_model.dart';
import '../model/image_model.dart';
import '../model/user_model.dart';

// Import the API service
List selectedImagesId = [];
List selectedImagesPath = [];
bool isSelected = false;
String baseUrl = 'https://crm-crisaloid.com';
bool _downloadInProgress = false;
bool _deleteInProgress = false;
// bool _isImagesDeleted=false;

String _truncateImageName(String name, {int maxLength = 15}) {
  if (name.length > maxLength) {
    return '${name.substring(0, maxLength)}...';
  } else {
    return name;
  }
}

Widget buildImageWidget(
    {
    // int? index,
    required List<FetchedImagesModel> images,
    context,
    constructionSiteId,
    token,
    required Function() onDelete}) {
  List<bool> checkMarkList = List.generate(images.length, (index) => false);
  return StatefulBuilder(
    builder: (context, setState) {
      void _toggleSelection(int index) {
        setState(() {
          checkMarkList[index] = !checkMarkList[index];
          if (checkMarkList[index]) {
            selectedImagesId.add(images[index].id);
            selectedImagesPath.add(images[index].path);
          } else {
            selectedImagesId.remove(images[index].id);
            selectedImagesPath.remove(images[index].path);
          }
        });
      }

      // if (selectedImages.length <= index) {
      //   selectedImages.add([false, "path", "id"]);
      // }
      // bool isSelected = checkMarkList[index]
      // String imagePath = selectedImages[index][1];
      // String imageId = selectedImages[index][2];
      return Stack(children: [
        GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              mainAxisExtent: 200,
              crossAxisCount: 2,
            ),
            itemCount: images.length,
            itemBuilder: (context, index) {
              final image = images[index];

              return GestureDetector(
                onLongPress: () {
                  // setState(() {
                  //   isSelected = !isSelected;
                  //   checkMarkList[index] = isSelected;
                  //   // selectedImages[index][0] = isSelected;
                  //   // !isSelected;
                  //   if (!selectedImagesId.contains(image.id)) {
                  //     selectedImagesId.add(image.id);
                  //     selectedImagesPath.add(image.path);
                  //   }
                  // });
                  _toggleSelection(index);
                  print(selectedImagesId);
                  print(selectedImagesPath);
                  print(index);
                },
                onTap: () {
                  if (checkMarkList[index]) {
                    _toggleSelection(index);
                  }
                  // if (checkMarkList[index] == true) {
                  //   setState(() {
                  //     isSelected = false;
                  //     checkMarkList[index] = isSelected;
                  //     selectedImagesId.remove(image.id);
                  //     selectedImagesPath.remove(image.path);
                  //     print(selectedImagesId);
                  //     print(selectedImagesPath);

                  //     // selectedImages[index] = isSelected;
                  //   });
                  // }
                  else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: Image.network(
                            "$baseUrl/construction-assets/$constructionSiteId/${image.path}",
                            // headers: {'Authorization': 'Bearer $token'},
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                  'assets/pictures/error_image.png');
                            },
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  }
                },
                child: Container(
                    padding: const EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            child: IntrinsicWidth(
                              child: Stack(children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    height:
                                        MediaQuery.sizeOf(context).height * 1.0,
                                    child: Image.network(
                                      "$baseUrl/construction-assets/$constructionSiteId/${image.path}",
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          'assets/pictures/error_image.png',
                                          fit: BoxFit.cover,
                                        );
                                      },
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                if (checkMarkList[index] == true)
                                  Positioned.fill(
                                    // top: 10,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        color: Colors.black.withOpacity(0.5),
                                        child: const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 32,
                                        ),
                                      ),
                                    ),
                                  ),
                              ]),
                            ),
                          ),
                        ),
                        // if (isSelected)

                        Padding(
                          padding:
                              const EdgeInsets.only(left: 8, top: 16, right: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  _truncateImageName(image.name,
                                      maxLength:
                                          10), // Use the image's name property
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 9),
                                ),
                              ),
                              // const Spacer(),
                              Align(
                                alignment: Alignment.topRight,
                                child: PopupMenuButton(
                                  padding: EdgeInsets.all(0.0),
                                  constraints: BoxConstraints(minWidth: 0.0),
                                  child: Icon(
                                    Icons.more_vert,
                                    size: 18.0,
                                  ),
                                  // position: PopupMenuPosition.[10,23,],
                                  // icon: Icon(Icons.more_vert),
                                  // iconSize: 15.0,
                                  itemBuilder: (BuildContext context) => [
                                    PopupMenuItem(
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        onTap: () {
                                          _downloadImage(
                                              '$baseUrl/construction-assets/$constructionSiteId/${image.path}',
                                              context); // Use the image's path
                                          Navigator.of(context).pop();
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.download,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'Scarica',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        onTap: () async {
                                          // removeImage();

                                          if (await ImageModel.deleteImage(
                                                  imageId: image.id) ==
                                              true) {
                                            onDelete();

                                            // setState(
                                            //   () {},
                                            // );

                                            Navigator.of(context).pop();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text('Image deleted'),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                          } else {
                                            Navigator.of(context).pop();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Failed to delete Image'),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                          }

                                          // print("deleted");
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.delete,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            SizedBox(width: 8),
                                            Text('Elimina',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8, top: 8),
                          child: Text(
                            "Caricato da:",
                            style: TextStyle(color: Colors.black, fontSize: 9),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              Text(
                                "${UserModel.locallyStoredname}",
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 9),
                              ),
                              const Spacer(),
                              Text(
                                DateFormat('dd/MM/yy').format(DateTime.now()),
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 9),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              );
            }),
        if (_downloadInProgress || _deleteInProgress)
          Container(
            color:
                Colors.transparent.withOpacity(0.2), // Adjust the opacity here
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        if (selectedImagesId.isNotEmpty)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: 40,
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () async {
                      setState(() {
                        _downloadInProgress = true;
                      });
                      await _downloadImages(
                          imagePaths: selectedImagesPath,
                          context: context,
                          constructionSiteId: constructionSiteId);
                      setState(() {
                        _downloadInProgress = false;

                        // isSelected = false;
                        // checkMarkList[index] = isSelected;
                        selectedImagesId.clear();
                        selectedImagesPath.clear();
                        for (int i = 0; i < checkMarkList.length; i++) {
                          if (checkMarkList[i] == true) {
                            checkMarkList[i] = false;
                          }
                        }
                        // selectedImagesPath.remove(image.path);
                        print(selectedImagesId);
                        print(selectedImagesPath);

                        // selectedImages[index] = isSelected;
                      });
                    },
                    icon: const Icon(
                      Icons.download,
                      color: Colors.green,
                    ),
                  ),
                  // const SizedBox(
                  //   width: 10,
                  // ),
                  IconButton(
                    onPressed: () async {
                      setState(() {
                        _deleteInProgress = true;

                        // selectedImages[index] = isSelected;
                      });
                      await ImageModel.deleteImages(imageIds: selectedImagesId);
                      setState(() {
                        _deleteInProgress = false;
                        // isSelected = false;
                        // checkMarkList[index] = isSelected;
                        selectedImagesId.clear();
                        selectedImagesPath.clear();

                        // selectedImagesPath.remove(image.path);
                        print(selectedImagesId);
                        print(selectedImagesPath);

                        // selectedImages[index] = isSelected;
                      });

                      onDelete();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Images deleted'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ]);
    },
  );
}

// isVisible({context}) {
//   return StatefulBuilder(builder: (context, setState) {
//     return Visibility(
//       visible: selectedImagesId.isNotEmpty,
//       child: Align(
//         alignment: Alignment.bottomRight,
//         child: Container(
//           child: const Row(
//             children: [
//               Icon(
//                 Icons.download,
//                 color: Colors.blue,
//               ),
//               Icon(
//                 Icons.delete,
//                 color: Colors.blue,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   });
// }

Future<void> _downloadImage(String imagePath, context) async {
  // _deleteInProgress = true;
  try {
    final response = await http.get(Uri.parse(imagePath));
    print(response.statusCode);
    // if (response.statusCode == 200) {

    final result = await ImageGallerySaver.saveImage(response.bodyBytes);

    if (result['isSuccess']) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Image downloaded and saved to gallery'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to download image'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: $e'),
        duration: const Duration(seconds: 2),
      ),
    );
  } finally {
    // _deleteInProgress = false;
  }
}

Future<void> _downloadImages(
    {List? imagePaths, context, constructionSiteId}) async {
  int successCount = 0;
  int totalCount = imagePaths!.length;

  try {
    for (String imagePath in imagePaths) {
      final response = await http.get(Uri.parse(
          '$baseUrl/construction-assets/$constructionSiteId/$imagePath'));

      if (response.statusCode == 200) {
        final result = await ImageGallerySaver.saveImage(response.bodyBytes);
        if (result['isSuccess']) {
          successCount++;
        }
      }
    }

    if (successCount == totalCount) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All images downloaded and saved to gallery'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: successCount > 0
              ? Text('$successCount out of $totalCount images downloaded')
              : const Text('Failed to download images'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: $e'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
