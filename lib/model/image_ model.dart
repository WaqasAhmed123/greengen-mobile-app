// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:greengen/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class ImageModel {
  final int id;
  // final String folderByRespnse;
  // final String constructionSiteId;
  // final String uploadedBy;
  // final String name;
  // final String path;
  // final String updatedAt;
  // final String createdAt;

  ImageModel({
    required this.id,
    // required this.folderByRespnse,
    // required this.constructionSiteId,
    // required this.uploadedBy,
    // required this.name,
    // required this.path,
    // required this.updatedAt,
    // required this.createdAt,
  });

  static Future<bool> deleteImage({int? imageId}) async {
    bool success = false;
    const baseUrl =
        'https://www.crm-crisaloid.com/api/images'; // Replace with your API endpoint

    try {
      final token = await UserModel.getToken();
      final headers = {'Authorization': 'Bearer $token'};

      final response =
          await http.delete(Uri.parse('$baseUrl/$imageId'), headers: headers);

      if (response.statusCode == 200) {
        print(response);
        return success = true;
        print('Image deleted successfully');
      } else {
        print('Failed to delete image. Status code: ${response.statusCode}');
        return success;
      }
    } catch (e) {
      print('Error deleting image: $e');
    }
    return success;
  }

  static Future<void> deleteImages({List? imageIds}) async {
    // bool success = false;

    const baseUrl =
        'https://www.crm-crisaloid.com/api/images'; // Replace with your API endpoint

    try {
      final token = await UserModel.getToken();
      final headers = {'Authorization': 'Bearer $token'};

      if (imageIds == null || imageIds.isEmpty) {
        print('No image IDs provided for deletion.');
      }

      for (int imageId in imageIds!) {
        try {
          final response = await http.delete(Uri.parse('$baseUrl/$imageId'),
              headers: headers);

          if (response.statusCode == 200) {
            // return success = true;

            print('Image with ID $imageId deleted successfully');
          } else {
            // return success;
            print(
                'Failed to delete image with ID $imageId. Status code: ${response.statusCode}');
          }
        } catch (e) {
          // return success;
          print('Error deleting image with ID $imageId: $e');
        }
      }
    } catch (e) {
      print('Error deleting images: $e');
    }
    // return success;
  }

  static List<ImageModel> imageModels = [];

  static Future<bool> uploadImages({
    List<File>? images,
    String? folder,
    constructionSiteId,
  }) async {
    String baseUrl = 'https://www.crm-crisaloid.com/api/construction/images';
    final token = await UserModel.getToken();
    bool success = false;

    try {
      const batchSize = 20;
      final totalImages = images?.length ?? 0;
      final numBatches = (totalImages / batchSize).ceil();

      for (var i = 0; i < numBatches; i++) {
        var startIdx = i * batchSize;
        var endIdx = (i + 1) * batchSize;
        var batch = images!
            .sublist(startIdx, endIdx > totalImages ? totalImages : endIdx);

        var request = http.MultipartRequest('POST', Uri.parse(baseUrl));
        final headers = {"Authorization": "Bearer $token"};
        request.headers.addAll(headers);

        for (var image in batch) {
          request.files
              .add(await http.MultipartFile.fromPath('images[]', image.path));
        }

        request.fields['construction_site_id'] = constructionSiteId.toString();
        request.fields['folder'] = folder!;

        var response = await request.send();

        if (response.statusCode == 200 || response.statusCode == 201) {
          // Handle the response for each batch if needed
          // For example, you can parse the response and update the imageModels list.
          // var responseData = await response.stream.transform(utf8.decoder).join();
          // var jsonResponse = json.decode(responseData);
          // ...
          success = true;
        } else {
          print('Failed to upload images. Status code: ${response.statusCode}');
          success = false;
          break; // Exit the loop if any batch fails to upload.
        }
      }

      return success;
    } catch (e) {
      print('Error uploading images: $e');
      return false;
    }
  }
}
