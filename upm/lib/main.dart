import 'package:flutter/material.dart';
import 'package:upm/screens/home.dart';
import 'package:upm/screens/login.dart';
import 'package:upm/screens/settings.dart';
import 'package:upm/screens/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: Home(),
      theme: ThemeData.dark(),
      darkTheme: ThemeData(brightness: Brightness.dark),
      initialRoute: "/",
      routes: {
        "/": (context) => const Home(),
        "/login": (context) => const Login(),
        "/signup": (context) => const Signup(),
        "/settings": (context) => const Settings(),
      },
    );
  }
}
