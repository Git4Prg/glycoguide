import 'package:firebase_auth/firebase_auth.dart';
import 'package:glycoguide/home_page.dart';
import 'package:glycoguide/reusable_widget.dart';
// import 'package:glycoguide/profile_details.dart';
import 'package:glycoguide/utils/color_utils.dart';
import 'package:flutter/material.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<ProfileDetailsScreen> {
  final _passwordTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _userNameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "User Profile",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexStringToColor("CB2B93"),
            hexStringToColor("9546C4"),
            hexStringToColor("5E61F4")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                userDetailsTextField("Name ", _userNameTextController),
                const SizedBox(
                  height: 20,
                ),
                userDetailsTextField("Age", _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                userDetailsTextField("Gender", _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                userDetailsTextField("Height", _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                userDetailsTextField("Weight", _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Next", () {
                  // FirebaseAuth.instance
                  //     .createUserWithEmailAndPassword(
                  //         email: _emailTextController.text,
                  //         password: _passwordTextController.text)
                  //     .then((value) {
                  //   print("Created New Account");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MedicalHistory()));
                  // }).onError((error, stackTrace) {
                  //   print("Error ${error.toString()}");
                  // });
                })
              ],
            ),
          ))),
    );
  }
}

class MedicalHistory extends StatefulWidget {
  const MedicalHistory({super.key});

  @override
  State<MedicalHistory> createState() => _MedicalHistoryState();
}

class _MedicalHistoryState extends State<MedicalHistory> {
  final _input1 = TextEditingController();
  final _input2 = TextEditingController();
  final _input3 = TextEditingController();
  final _input4 = TextEditingController();
  final _input5 = TextEditingController();
  final _input6 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: hexStringToColor("CB2B93"),
        elevation: 0,
        title: const Text(
          "Medical History",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexStringToColor("CB2B93"),
            hexStringToColor("9546C4"),
            hexStringToColor("5E61F4"),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              children: <Widget>[
                userDetailsTextField(
                    "When were you diagnosed with diabetes?", _input1),
                const SizedBox(
                  height: 20,
                ),
                userDetailsTextField("Do you have a heart disease?", _input2),
                const SizedBox(
                  height: 20,
                ),
                userDetailsTextField("Do you use an insulin pump?", _input3),
                const SizedBox(
                  height: 20,
                ),
                userDetailsTextField("Do you test your blood sugar?", _input4),
                const SizedBox(
                  height: 20,
                ),
                userDetailsTextField(
                    "Please specify any other complications(if any)", _input5),
                const SizedBox(
                  height: 20,
                ),
                userDetailsTextField("How often do you exercise?", _input6),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Next", () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                })
              ],
            ),
          ))),
    );
  }
}
