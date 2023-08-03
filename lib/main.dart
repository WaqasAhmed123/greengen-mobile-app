// import 'dart:js_interop';

// import 'dart:js_interop';

// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:Greengen/model/user_model.dart';
import 'package:Greengen/screens/all_users_scrn.dart';
import 'package:Greengen/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const Map<int, Color> color = {
      50: Color.fromRGBO(50, 205, 48, .1),
      100: Color.fromRGBO(50, 205, 48, .2),
      200: Color.fromRGBO(50, 205, 48, .3),
      300: Color.fromRGBO(50, 205, 48, .4),
      400: Color.fromRGBO(50, 205, 48, .5),
      500: Color.fromRGBO(50, 205, 48, .6),
      600: Color.fromRGBO(50, 205, 48, .7),
      700: Color.fromRGBO(50, 205, 48, .8),
      800: Color.fromRGBO(50, 205, 48, .9),
      900: Color.fromRGBO(50, 205, 48, 1),
    };
    Future<bool> checkUserLogin() async {
      // print("condition is checking");
      // print(UserModel.getLogincheck().runtimeType);
      // print(UserModel.getLogincheck());
      // print("UserModel.locallyStoredlogincheck from main.dart");
      await UserModel.getLogincheck();
      await UserModel.getName();
      await UserModel.getEmail();
      // UserModel.getName();

      if (UserModel.locallyStoredlogincheck == true) {
        // print("condition is ture");
        return Future.value(true);
      } else {
        // print("condition is false");
        return Future.value(false);
      }
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Greengen',
        theme: ThemeData(
          primaryColor: const Color(0xff0076d32),
          primaryColorLight: const Color(0XFF7db841),
          primarySwatch: const MaterialColor(0XFF076D32, color),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0XFF076D32)),
          useMaterial3: true,
        ),
        home: FutureBuilder<bool>(
            future:
                checkUserLogin(), // function to check if the user is logged in or not
            builder: (context, snapshot) {
              if (snapshot.data == true) {
                return const AllUsersScreen();
              } else {
                return const Login();
              }
            }));
  }
}
