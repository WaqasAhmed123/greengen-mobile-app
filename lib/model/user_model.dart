import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:path/path.dart' as path;

class UserModel {
  static String? locallyStoredtoken;
  static String? locallyStoredname;
  static String? locallyStoredemail;
  // static String? token;
  // assignTokenValue() async {
  //   token = await getToken();
  // }
  // List<File> images = [];
  // int? constructionSideId;
  // String? folder;

  static int? id;
  static String? name;
  static String? email;
  static String? phone;
  static String? status;
  static String? birthplace;
  static String? birthCountry;
  static String? dob;
  static String? residenceCity;
  static String? residenceProvince;
  static String? residence;
  static String? fiscalCode;
  static String? professionalCollege;
  static String? commonCollege;
  static String? registrationNumber;
  static String? originalPassword;
  static String? emailVerifiedAt;
  static String? createdAt;
  static String? updatedAt;
  static String? token;

// handle local storage
  static Future saveToken({String? token}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token!);
  }

  static Future saveEmail({String? email}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email!);
    locallyStoredemail = prefs.getString("email") as String;
  }
  // static Future saveToken(
  //     {String? token, String? name, String? email}) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.setString("token", token!);
  //   prefs.setString("name", name!);
  //   prefs.setString("token", email!);
  // }

  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    // token = prefs.get("token") as String;
    // locallyStoredtoken = prefs.getString("token") as String;
    // locallyStoredtoken = prefs.getString("name") as String;
    // locallyStoredtoken = prefs.getString("email") as String;

    return prefs.getString("token") as String;
  }

  static Future getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    locallyStoredemail = prefs.getString("email") as String;
    // token = prefs.get("token") as String;
    // locallyStoredtoken = prefs.getString("token") as String;
    // locallyStoredtoken = prefs.getString("name") as String;
    // locallyStoredtoken = prefs.getString("email") as String;
  }

  static Future removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
  }

//get token and saved in local storage
  static Future<bool> login({String? email, String? password}) async {
    bool successful = false;
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

        // user.forEach((key, value) {
        //   if (UserModel.contains(key)) {
        //     setFieldValue(key, value);
        //   }
        // });

        id = user['id'];
        name = user['name'];
        email = user['email'];
        phone = user['phone'];
        status = user['status'];
        birthplace = user['birthplace'];
        birthCountry = user['birth_country'];
        dob = user['dob'];
        residenceCity = user['residence_city'];
        residenceProvince = user['residence_province'];
        residence = user['residence'];
        fiscalCode = user['fiscal code'];
        professionalCollege = user['professional_college'];
        commonCollege = user['common_college'];
        registrationNumber = user['registration_numbe'];
        originalPassword = user['originalpass'];
        emailVerifiedAt = user['email_verified_at'];
        createdAt = user['created_at'];
        updatedAt = user['updated_at'];
        token = responseData['token'];
        // name = responseData['name'];
        // email = responseData['email'];
        print(token);
        print(id);
        print(name);

        // print(email);
        // await removeToken();
        await saveToken(token: token!);
        await getToken();
        return successful = true;
      } catch (e) {
        return successful;
        print('Error parsing JSON response: $e');
        throw Exception('Failed to obtain token');
      }
    }
    return successful;
  }

  static Future<bool> logout() async {
    bool successful = false;
    // final url = 'https://example.com/logout'; // Replace with your API endpoint URL
    final token = await UserModel.getToken();

    print(token);
    final Map<String, dynamic> logoutdata = {
      'token': token,
    };
    try {
      final Uri uri = Uri.parse('https://crm-crisaloid.com/api/logout');

      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(logoutdata),
      );

      // final response = await http.post(
      //   Uri.parse("https://crm-crisaloid.com/api/logout"),
      //   headers: {
      //     // 'Authorization': 'Bearer ${await UserModel.getToken()}',
      //     'Authorization': 'Bearer $token',
      //     // 'Content-Type': 'application/json',
      //   },
      //   // body: '{"token": "${await UserModel.getToken()}"}',
      //   body: '{"token": "$token"}',
      // );

      if (response.statusCode == 200) {
        return successful = true;
        // Logout successful
        print('api Response: ${response.body}');
        print('Logout successful');
      } else {
        return successful;
        // Logout failed
        print('Logout failed: ${response.statusCode}');
        print('Error uploading image: ${response.headers}');
      }
    } catch (e) {
      // Error occurred during the request
      print('Error: $e');
    }
    return successful;
  }
}
