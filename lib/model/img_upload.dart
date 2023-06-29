// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:greengen/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class ImageUpload {
  // assignTokenValue()async {
  //   UserModel.

  // }
  // List<File> images = [];
  // static int? constructionSideId = UserModel.id;
  String? folder;

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
      // Image uploaded successfully
      // print('Image uploaded');
      success = true;
      return success;
    } else {
      return success;
    }
  }
}
