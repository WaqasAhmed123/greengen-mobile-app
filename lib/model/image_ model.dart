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

  static Future<void> deleteImage(int id) async {
    const apiUrl =
        'https://www.crm-crisaloid.com/api/images'; // Replace with your API endpoint

    try {
      final token = await UserModel.getToken();
      final headers = {'Authorization': 'Bearer $token'};

      final response =
          await http.delete(Uri.parse('$apiUrl/$id'), headers: headers);

      if (response.statusCode == 200) {
        print('Image deleted successfully');
        // Remove the image from the list or update the state
        // setState(() {
        //   images.removeWhere((image) => image.id == id);
        // });
      } else {
        print('Failed to delete image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting image: $e');
    }
  }

  // assignTokenValue()async {
  //   UserModel.

  // }
  // List<File> images = [];
  // static int? constructionSideId = UserModel.id;
  // String? folder;
  static List<ImageModel> imageModels = [];

  static Future<bool> uploadImage({List<File>? images, String? folder}) async {
    // String? token=await
    // Create the multipart request
    String apiUrl = 'https://www.crm-crisaloid.com/api/construction/images';
    // String token = await UserModel.getUserCredentials();

    final token = await UserModel.getToken();

    // print(token);
    bool success = false;

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    final headers = {"Authorization": "Bearer $token"};

    // request.headers['Authorization'] = 'Bearer ${token}';
    //  final headers = {
    //         "Authorization": "Bearer $token",
    //         "Content-Type": "multipart/form-data",
    //         // "Content-Length": bytesData.length.toString(),
    //         "Accept": "*/*",
    //       };
    request.headers.addAll(headers);
    // 'Bearer ${await UserModel.getToken().toString()}';

    // Add the image files to the request
    for (var image in images!) {
      request.files
          .add(await http.MultipartFile.fromPath('images[]', image.path));
    }
    // var stream=new http.ByteStream(images.ope)
    // Add the image files to the request
    // for (var image in images!) {
    //   var stream = http.ByteStream(image.openRead());
    //   stream.cast();
    //   var length = await image.length();

    //   var multipartFile = http.MultipartFile(
    //     'images[]', stream, length,
    //     // filename: basename(image.path), contentType: ()
    //     // filename: path.basename(image.path),
    //     // contentType: MediaType('image', 'jpeg'), // Adjust the content type as needed
    //   );

    //   // request.files.add(multipartFile);
    // }

    // Add the other parameters
    // request.fields['construction_site_id'] = constructionSideId.toString();
    request.fields['construction_site_id'] = "1184";
    request.fields['folder'] = folder!;

    // Send the request and get the response
    var response = await request.send();

    // Check the response status
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.statusCode);
      var responseData = await response.stream.transform(utf8.decoder).join();

      print('Response: $responseData');
      var jsonResponse = json.decode(responseData);

      // Create an ImageModel object using the response data
      var imageModel = ImageModel(
        id: jsonResponse['id'],
        // folderByRespnse: jsonResponse['folder'],
        // constructionSiteId: jsonResponse['construction_site_id'],
        // uploadedBy: jsonResponse['uploaded_by'],
        // name: jsonResponse['name'],
        // path: jsonResponse['path'],
        // updatedAt: jsonResponse['updated_at'],
        // createdAt: jsonResponse['created_at'],
      );

      // Append the ImageModel object to the list
      imageModels.add(imageModel);
      // print(respons.e)
      // Image uploaded successfully
      // print('Image uploaded');
      print(imageModel);
      success = true;
      return success;
    } else {
      return success;
    }
  }
}
