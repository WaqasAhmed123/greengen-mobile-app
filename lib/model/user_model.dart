import 'package:shared_preferences/shared_preferences.dart';

// import 'package:path/path.dart' as path;

class UserModel {
  // static String? locallyStoredtoken;
  // static String? locallyStoredname;
  static String? locallyStoredemail;

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
  // static Future isLogin() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   prefs.containsKey("token");
  // }

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


}
