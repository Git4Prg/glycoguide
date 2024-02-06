import 'package:flutter/material.dart';
import 'package:glycoguide/home_page.dart';
import 'package:glycoguide/login_page.dart';
import 'package:glycoguide/profile_page.dart';
import 'package:glycoguide/profile_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}
