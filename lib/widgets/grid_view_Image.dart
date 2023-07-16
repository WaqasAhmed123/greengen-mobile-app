import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../model/fetched_image_model.dart';
import '../model/image_ model.dart';
import '../model/user_model.dart';
// Import the API service

Widget buildImageWidget(
    {int? index,
    required List<FetchedImagesModel> images,
    context,
    constructionSiteId,
    required Function() onDelete}) {
  String apiUrl = 'https://crm-crisaloid.com';
  final image = images[index!];
  return GestureDetector(
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Image.network(
              "$apiUrl/construction-assets/$constructionSiteId/${image.path}",
              fit: BoxFit.cover,
            ),
          );
        },
      );
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
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Image.network(
                  "$apiUrl/construction-assets/$constructionSiteId/${image.path}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('dd/MM/yy').format(
                      image.createdAt), // Use the image's createdAt property
                  style: const TextStyle(color: Colors.grey, fontSize: 9),
                ),
                const Spacer(),
                Expanded(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: PopupMenuButton(
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                          child: InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              _downloadImage(
                                  '$apiUrl/construction-assets/$constructionSiteId/${image.path}',
                                  context); // Use the image's path
                              Navigator.of(context).pop();
                            },
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.download,
                                  color: Colors.blue,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Scarica',
                                  style: TextStyle(color: Colors.blue),
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

                              await ImageModel.deleteImage(imageId: image.id);
                              onDelete();

                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Image deleted'),
                                  duration: Duration(seconds: 2),
                                ),
                              );

                              // print("deleted");
                            },
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Colors.blue,
                                ),
                                SizedBox(width: 8),
                                Text('Elimina',
                                    style: TextStyle(color: Colors.blue)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8),
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
                  "${UserModel.name}",
                  style: const TextStyle(color: Colors.black, fontSize: 9),
                ),
                const Spacer(),
                Text(
                  DateFormat('dd/MM/yy').format(DateTime.now()),
                  style: const TextStyle(color: Colors.grey, fontSize: 9),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Future<void> _downloadImage(String imagePath, context) async {
  try {
    final response = await http.get(Uri.parse(imagePath));
    if (response.statusCode == 200) {
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
