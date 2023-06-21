import 'package:flutter/material.dart';
import 'package:greengen/helper/theme.dart';
import 'package:greengen/screens/login.dart';
import 'package:greengen/screens/img_upload_scrn.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xff0076d32),
        primaryColorLight: const Color(0XFF7db841),
        primarySwatch: const MaterialColor(0XFF076D32, color),
        // scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
            titleMedium: textTheme['titleMedium'],
            bodyMedium: textTheme['bodyMedium']),
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0XFF076D32)),
        useMaterial3: true,
      ),
      home: const Login(),
    );
  }
}
