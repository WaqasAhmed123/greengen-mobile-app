import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:path/path.dart' as path;

class UserModel {
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

  static Future<String> getToken({String? token}) async {
    final prefs = await SharedPreferences.getInstance();
    // token = prefs.get("token") as String;
    return prefs.get("token") as String;
  }

  static Future removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
  }

//get token and saved in local storage
  static Future login({String? email, String? password}) async {
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
        print(token);
        print(id);
        // await removeToken();
        await saveToken(token: token!);
        await getToken();

        // print("User ID: ${user['id']}");
        // print("User Name: ${user['name']}");
        // print("User Email: ${user['email']}");
        // print("Token: $token");
      } catch (e) {
        print('Error parsing JSON response: $e');
        throw Exception('Failed to obtain token');
      }
    }
  }
}

