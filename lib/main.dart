// import 'dart:js_interop';

// import 'dart:js_interop';

// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:Greengen/model/user_model.dart';
import 'package:Greengen/screens/all_users_scrn.dart';
import 'package:Greengen/screens/login.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _appBadgeSupported = 'Unknown';

  @override
  initState() {
    super.initState();
    initPlatformState();
    _addBadge();
  }

  void _addBadge() {
    FlutterAppBadger.updateBadgeCount(1);
  }

  initPlatformState() async {
    String appBadgeSupported;
    print(_appBadgeSupported);
    try {
      bool res = await FlutterAppBadger.isAppBadgeSupported();
      print(res);
      if (res) {
        appBadgeSupported = 'Supported';
      } else {
        appBadgeSupported = 'Not supported';
      }
    } on PlatformException {
      appBadgeSupported = 'Failed to get badge support.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _appBadgeSupported = appBadgeSupported;
    });
  }

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
      await UserModel.getLogincheck();
      await UserModel.getName();
      await UserModel.getEmail();

      if (UserModel.locallyStoredlogincheck == true) {
        return Future.value(true);
      } else {
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
