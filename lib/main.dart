import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:glycoguide/app_screens/navbar_screen.dart';
import 'package:glycoguide/app_screens/homepage_screen.dart';
import 'package:glycoguide/app_screens/profile_page.dart';
import 'package:glycoguide/utils/reusable_widget.dart';
import 'package:glycoguide/app_screens/signin_screen.dart';
import 'package:glycoguide/app_screens/profile_details_screen.dart';
import 'package:glycoguide/app_screens/signup_screen.dart';
import 'package:glycoguide/utils/constants.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  Gemini.init(apiKey: "${dotenv.env["APIKEY"]}");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Lato',
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.black,
      ),
    );
  }
}
