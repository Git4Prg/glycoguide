import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glycoguide/home_page.dart';
import 'package:glycoguide/signup_screen.dart';
import 'package:glycoguide/reusable_widget.dart';
// import 'package:glycoguide/profile_details.dart';
import 'package:glycoguide/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:glycoguide/utils/constants.dart';

class ProfileDetailsScreen extends StatefulWidget {
  ProfileDetailsScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<ProfileDetailsScreen> {
  final _nameTextController = TextEditingController();
  final _ageTextController = TextEditingController();
  final _genderTextController = TextEditingController();
  final _heightTextController = TextEditingController();
  final _weightTextController = TextEditingController();
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
                userDetailsTextField("Name ", _nameTextController),
                const SizedBox(
                  height: 20,
                ),
                userDetailsTextField("Age", _ageTextController),
                const SizedBox(
                  height: 20,
                ),
                userDetailsTextField("Gender", _genderTextController),
                const SizedBox(
                  height: 20,
                ),
                userDetailsTextField("Height", _heightTextController),
                const SizedBox(
                  height: 20,
                ),
                userDetailsTextField("Weight", _weightTextController),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Next", () {
                  userDetails.doc('General').set({
                    'Name': _nameTextController.text,
                    'Age': _ageTextController.text,
                    'Gender': _genderTextController.text,
                    'Height': _heightTextController.text,
                    'Weight': _weightTextController.text,
                  });
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
                  userDetails.doc('Medical History').set({
                    'Date of Diagnosis': _input1.text,
                    'Heart Disease': _input2.text,
                    'Insulin Pump': _input3.text,
                    'Blood Sugar': _input4.text,
                    'Other Complications': _input5.text,
                    'Exercise frequency': _input6.text,
                  });
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
