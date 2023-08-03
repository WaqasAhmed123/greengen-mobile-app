import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/all_users.dart';
import '../model/fetched_image_model.dart';
import '../model/user_model.dart';

class ApiServices {
  static const String baseUrl = 'https://crm-crisaloid.com';

  // static Future<Map<String, String>> getTokenHeader() async {
  //   final token = await UserModel.getToken();
  //   return {
  //     'Authorization': 'Bearer $token',
  //   };
  // }

//login api __________________________________________________________
  static Future<bool> login({String? email, String? password}) async {
    bool successful = false;
    final Map<String, dynamic> data = {
      'email': email,
      'password': password,
    };

    final response = await http.post(
      Uri.parse("$baseUrl/api/login"),
      // uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      try {
        final responseData = json.decode(response.body);
        final user = responseData['user'];

        // user.forEach((key, value) {
        //   if (UserModel.contains(key)) {
        //     setFieldValue(key, value);
        //   }
        // });

        UserModel.id = user['id'];
        UserModel.name = user['name'];
        UserModel.email = user['email'];
        UserModel.phone = user['phone'];
        UserModel.status = user['status'];
        UserModel.birthplace = user['birthplace'];
        UserModel.birthCountry = user['birth_country'];
        UserModel.dob = user['dob'];
        UserModel.residenceCity = user['residence_city'];
        UserModel.residenceProvince = user['residence_province'];
        UserModel.residence = user['residence'];
        UserModel.fiscalCode = user['fiscal code'];
        UserModel.professionalCollege = user['professional_college'];
        UserModel.commonCollege = user['common_college'];
        UserModel.registrationNumber = user['registration_numbe'];
        UserModel.originalPassword = user['originalpass'];
        UserModel.emailVerifiedAt = user['email_verified_at'];
        UserModel.createdAt = user['created_at'];
        UserModel.updatedAt = user['updated_at'];
        UserModel.token = responseData['token'];

        // authToken = responseData['token'];
        // name = responseData['name'];
        // email = responseData['email'];

        // print(email);
        // await removeToken();
        await UserModel.saveToken(token: UserModel.token!);
        await UserModel.saveEmail(email: UserModel.email);
        await UserModel.savePassword(password: password);
        await UserModel.saveName(name: UserModel.name);
        await UserModel.saveLogincheck(logincheck: true);
        await UserModel.getToken();
        print(await UserModel.getToken());

        return successful = true;
      } catch (e) {
        return successful;
      }
    }
    return successful;
  }

//logout api __________________________________________________________
  static Future<bool> logout() async {
    bool successful = false;
    final token = await UserModel.getToken();

    final Map<String, dynamic> logoutdata = {
      'token': token,
    };
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/api/logout"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(logoutdata),
      );

      if (response.statusCode == 200) {
        await UserModel.removeEmail();
        await UserModel.removePassword();
        await UserModel.removeToken();
        await UserModel.removeLogincheck();
        return successful = true;
        // Logout successful
      } else {
        return successful;
        // Logout failed
      }
    } catch (e) {
      // Error occurred during the request
      print('Error: $e');
    }
    return successful;
  }

  // static Stream<List<AllUsers>> search({keyword}) async* {
  //   // bool successful = false;
  //   final Map<String, dynamic> data = {
  //     // 'email': email,
  //     'SearchKeyword': keyword,
  //   };
  //   print("$keyword");

  //   final response = await http.post(
  //     Uri.parse("$baseUrl/api/search/cantieri"),
  //     // uri,
  //     headers: {
  //       'Authorization': 'Bearer ${await UserModel.getToken()}',
  //     },
  //     body: jsonEncode(data),
  //   );
  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     final jsonData = json.decode(response.body);
  //     // print(jsonData);
  //     if (jsonData["total Results"] > 0) {
  //       final userList = List<AllUsers>.from(jsonData['users']
  //               .map((json) => AllUsers.fromJson(json as Map<String, dynamic>)))
  //           .toList();
  //       yield userList;
  //     }
  //   } else {
  //     throw Exception('Failed to load users from API');
  //   }
  // }
  static Future<List<AllUsers>> search({required String keyword}) async {
    print("searched users");

    final Map<String, dynamic> data = {
      'SearchKeyword': keyword,
    };

    final response = await http.post(
      Uri.parse("$baseUrl/api/search/cantieri"),
      headers: {
        'Authorization': 'Bearer ${await UserModel.getToken()}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print(response.statusCode);
      final jsonData = json.decode(response.body);
      print(jsonData);
      if (jsonData["total Results"] > 0) {
        final userList = List<AllUsers>.from(jsonData['users']
                .map((json) => AllUsers.fromJson(json as Map<String, dynamic>)))
            .toList();
        print(userList.length);
        return userList;
      } else {
        return []; // Return an empty list if no results found
      }
    } else {
      throw Exception('Failed to load users from API');
    }
  }

//fetching all users through api_______________________________________
  static Stream<List<AllUsers>> getUsersFromApi() async* {
    print("all users");
    final response = await http.get(
      Uri.parse("$baseUrl/api/constructionUser"),
      headers: {
        'Authorization': 'Bearer ${await UserModel.getToken()}',
        // ...tokenHeader
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      // print(jsonData);
      final userList = List<AllUsers>.from(jsonData['users']
              .map((json) => AllUsers.fromJson(json as Map<String, dynamic>)))
          .toList();
      yield userList;
    } else {
      throw Exception('Failed To Load Users');
    }
  }

  //____________________________________ get images

  // static Stream<List<FetchedImagesModel>> getImages({id, folderName}) async* {
  //   final response = await http
  //       .post(Uri.parse("$baseUrl/api/construction-site/images/$id"), headers: {
  //     'Authorization': 'Bearer ${await UserModel.getToken()}',
  //     // ...tokenHeader
  //   }, body: {
  //     'folderName': '$folderName'
  //   });

  //   if (response.statusCode == 200) {
  //     // print(response.statusCode);
  //     final jsonData = json.decode(response.body);
  //     // print(jsonData);
  //     final List<FetchedImagesModel> imagesList =
  //         (jsonData['imageFolder'] as Map<String, dynamic>)
  //             .values
  //             .map((json) => FetchedImagesModel.fromJson(json))
  //             .toList();
  //     yield imagesList;
  //   } else {
  //     throw Exception('Failed to load images from API');
  //   }
  // }
  static Future<List<FetchedImagesModel>> getImages({id, folderName}) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/construction-site/images/$id"),
      headers: {
        'Authorization': 'Bearer ${await UserModel.getToken()}',
        // ...tokenHeader
      },
      body: {
        'folderName': '$folderName',
      },
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonData = json.decode(response.body);

      List<FetchedImagesModel> imagesList;

      if (jsonData['imageFolder'] is List) {
        imagesList = (jsonData['imageFolder'] as List)
            .map((json) => FetchedImagesModel.fromJson(json))
            .toList();
        print("list data $jsonData");
      } else if (jsonData['imageFolder'] is Map) {
        imagesList = (jsonData['imageFolder'] as Map<String, dynamic>)
            .values
            .map((json) => FetchedImagesModel.fromJson(json))
            .toList();
        print("map data $jsonData");
      } else {
        throw Exception('Unexpected format for imageFolder data');
      }

      print("length of images ${imagesList.length}");
      print("status code of fetched images api ${response.statusCode}");
      print(imagesList);
      return imagesList;
    } else {
      print(response.statusCode);

      throw Exception('Failed to load images from API');
    }
  }
}
