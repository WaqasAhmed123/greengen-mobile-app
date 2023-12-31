import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:path/path.dart' as path;

class UserModel {
  // static String? locallyStoredtoken;
  // static String? locallyStoredname;
  static String? locallyStoredemail;
  static String? locallyStoredpassword;
  static String? locallyStoredtoken;
  static String? locallyStoredname;
  static bool? locallyStoredlogincheck;

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

  static Future saveToken({String? token}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token!);
  }

  static Future saveEmail({String? email}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email!);
    locallyStoredemail = prefs.getString("email") as String;
  }

  static Future savePassword({String? password}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("password", password!);
    locallyStoredpassword = prefs.getString("password") as String;
  }

  static Future saveLogincheck({bool? logincheck}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("logincheck", logincheck!);
    locallyStoredlogincheck = prefs.getBool("logincheck") as bool;
    print("locallyStoredlogincheck is set successfully");
    print(locallyStoredlogincheck);
  }

  static Future saveName({String? name}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("name", name!);
    locallyStoredname = prefs.getString("name") as String;
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
    locallyStoredtoken = prefs.getString("token") as String;
    return prefs.getString("token") as String;
  }

  static Future getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    locallyStoredemail = prefs.getString("email") as String;
  }

  static Future getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    locallyStoredpassword = prefs.getString("password") as String;
  }

  static Future getName() async {
    final prefs = await SharedPreferences.getInstance();
    locallyStoredname = prefs.getString("name") as String;
  }

  static Future<bool> getLogincheck() async {
    final prefs = await SharedPreferences.getInstance();
    locallyStoredlogincheck = prefs.getBool("logincheck") as bool;
    print("locallyStoredlogincheck form get login check");
    print(locallyStoredlogincheck);
    return prefs.getBool("logincheck") as bool;
  }

  static Future removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
  }

  static Future removeEmail() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("email");
  }

  static Future removePassword() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("password");
  }

  static Future removeLogincheck() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("logincheck");
  }

  static Future<bool> isConnectedToInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true; // Connected to mobile or Wi-Fi network
    } else {
      return false; // Not connected to any network
    }
  }
}
