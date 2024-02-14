import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:glycoguide/home_page.dart';
import 'package:glycoguide/login_page.dart';
import 'package:glycoguide/reusable_widget.dart';
import 'package:glycoguide/signin_screen.dart';
// import 'package:glycoguide/login_page.dart';
// import 'package:glycoguide/profile_page.dart';
// import 'package:glycoguide/profile_details.dart';

void main() async {
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
      home: const SignInScreen(),
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Lato',
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.green.shade900,
      ),
    );
  }
}
