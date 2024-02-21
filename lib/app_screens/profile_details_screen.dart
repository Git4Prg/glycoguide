import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:glycoguide/app_screens/homepage_screen.dart';
import 'package:glycoguide/app_screens/medical_history_screen.dart';
// import 'package:glycoguide/app_screens/signup_screen.dart';
import 'package:glycoguide/utils/reusable_widget.dart';
// import 'package:glycoguide/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:glycoguide/utils/constants.dart';

class ProfileDetailsScreen extends StatefulWidget {
  ProfileDetailsScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<ProfileDetailsScreen> {
  final nameTextController = TextEditingController();
  final ageTextController = TextEditingController();
  final genderTextController = TextEditingController();
  final heightTextController = TextEditingController();
  final weightTextController = TextEditingController();
  final eatingPrefTextController = TextEditingController();
  final toleranceTextController = TextEditingController();
  final allergyTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "User Profile",
          style: TextStyle(
            fontFamily: 'Righteous',
            fontSize: 28,
            // fontWeight: FontWeight,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black,
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              children: <Widget>[
                userDetailsTextField("Name ", nameTextController),
                const SizedBox(
                  height: 20,
                ),
                userDetailsTextField("Age", ageTextController),
                const SizedBox(
                  height: 20,
                ),
                userDetailsTextField("Gender", genderTextController),
                const SizedBox(
                  height: 20,
                ),
                userDetailsTextField("Height", heightTextController),
                const SizedBox(
                  height: 20,
                ),
                userDetailsTextField("Weight", weightTextController),
                const SizedBox(
                  height: 20,
                ),
                userDetailsTextField("Vegan/Vegetarian/Non-vegetarian",
                    eatingPrefTextController),
                const SizedBox(
                  height: 20,
                ),
                userDetailsTextField(
                    "Lactose/Gluten tolerance", toleranceTextController),
                const SizedBox(
                  height: 20,
                ),
                userDetailsTextField("Allergy", allergyTextController),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Next", () {
                  CollectionReference userDetails = FirebaseFirestore.instance
                      .collection('Users')
                      .doc(emailTextController.text)
                      .collection('userDetails');
                  userDetails.doc('General').set({
                    'Name': nameTextController.text,
                    'Age': ageTextController.text,
                    'Gender': genderTextController.text,
                    'Height': heightTextController.text,
                    'Weight': weightTextController.text,
                    'Eating Preference': eatingPrefTextController.text,
                    'Lactose/Gluten Tolerance': toleranceTextController.text,
                    'Allergy': allergyTextController.text,
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MedicalHistory()));
                  // }).onError((error, stackTrace) {});
                })
              ],
            ),
          ))),
    );
  }
}
