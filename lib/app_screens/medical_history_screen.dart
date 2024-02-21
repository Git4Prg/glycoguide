import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glycoguide/app_screens/homepage_screen.dart';
import 'package:glycoguide/utils/constants.dart';
import 'package:glycoguide/utils/reusable_widget.dart';

class MedicalHistory extends StatefulWidget {
  const MedicalHistory({super.key});

  @override
  State<MedicalHistory> createState() => _MedicalHistoryState();
}

class _MedicalHistoryState extends State<MedicalHistory> {
  final input1 = TextEditingController();
  final input2 = TextEditingController();
  final input3 = TextEditingController();
  final input4 = TextEditingController();
  final input5 = TextEditingController();
  final input6 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "medical history",
          style: TextStyle(
            fontFamily: 'Righteous',
            fontSize: 35,
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
                userDetailsTextField(
                    "When were you diagnosed with diabetes?", input1),
                const SizedBox(
                  height: 20,
                ),
                userDetailsTextField("Do you have a heart disease?", input2),
                const SizedBox(
                  height: 20,
                ),
                userDetailsTextField("Do you use an insulin pump?", input3),
                const SizedBox(
                  height: 20,
                ),
                userDetailsTextField("Do you test your blood sugar?", input4),
                const SizedBox(
                  height: 20,
                ),
                userDetailsTextField(
                    "Please specify any other complications(if any)", input5),
                const SizedBox(
                  height: 20,
                ),
                userDetailsTextField("How often do you exercise?", input6),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Next", () {
                  CollectionReference userDetails = FirebaseFirestore.instance
                      .collection('Users')
                      .doc(emailTextController.text)
                      .collection('userDetails');
                  userDetails.doc('Medical History').set({
                    'Date of Diagnosis': input1.text,
                    'Heart Disease': input2.text,
                    'Insulin Pump': input3.text,
                    'Blood Sugar': input4.text,
                    'Other Complications': input5.text,
                    'Exercise frequency': input6.text,
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
