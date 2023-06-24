import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

// import 'package:path/path.dart' as path;

class UserModel {
  String? token;
  List<File> images = [];
  int? constructionSideId;
  String? folder;

  Future getToken({String? email, String? password}) async {
    final Map<String, dynamic> data = {
      'email': email,
      'password': password,
    };

    final Uri uri = Uri.parse('https://crm-crisaloid.com/api/login');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      try {
        final responseData = json.decode(response.body);
        final user = responseData['user'];
        final token = responseData['token'];

        print("User ID: ${user['id']}");
        print("User Name: ${user['name']}");
        print("User Email: ${user['email']}");
        print("Token: $token");
      } catch (e) {
        print('Error parsing JSON response: $e');
        throw Exception('Failed to obtain token');
      }
    } else if (response.statusCode == 302) {
      final redirectUrl = response.headers['location'];
      if (redirectUrl != null) {
        final redirectResponse = await http.get(Uri.parse(redirectUrl));
        if (redirectResponse.statusCode == 200) {
          try {
            final responseData = json.decode(redirectResponse.body);
            final user = responseData['user'];
            final token = responseData['token'];

            print("User ID: ${user['id']}");
            print("User Name: ${user['name']}");
            print("User Email: ${user['email']}");
            print("Token: $token");
          } catch (e) {
            print('Error parsing JSON response: $e');
            throw Exception('Failed to obtain token from redirect');
          }
        } else {
          print('Request failed with status: ${redirectResponse.statusCode}');
          throw Exception('Failed to obtain token from redirect');
        }
      } else {
        throw Exception('Redirect URL not found');
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
      throw Exception('Failed to obtain token');
    }
  }

  // Future<void> uploadImages() async {
  //   // Iterate through the list of images and upload each one
  //   for (final image in images) {
  //     final imagePath = image.path;

  //     // Create a multipart request
  //     final request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse(
  //           'IMAGE_UPLOAD_API_URL'), // Replace with your image upload API URL
  //     );

  //     // Add the token to the request headers
  //     request.headers['Authorization'] = 'Bearer $token';

  //     // Obtain the absolute path using the path package
  //     final absolutePath = path.absolute(imagePath);

  //     // Add the image file to the request
  //     request.files.add(
  //       await http.MultipartFile.fromPath('image', absolutePath),
  //     );

  //     // Add other parameters if required
  //     request.fields['constructionSideId'] = constructionSideId.toString();
  //     request.fields['folder'] = folder;

  //     // Send the request and get the response
  //     final response = await request.send();

  //     // Check if the request was successful
  //     if (response.statusCode == 200) {
  //       // Handle the successful image upload response
  //       print('Image uploaded successfully');
  //     } else {
  //       // Handle error if the request fails
  //       throw Exception('Failed to upload image');
  //     }
  //   }
  // }
}
