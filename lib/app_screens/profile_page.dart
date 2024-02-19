import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glycoguide/app_screens/homepage_screen.dart';
import 'package:glycoguide/app_screens/signin_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "profile",
          style: TextStyle(
            fontFamily: 'Righteous',
            fontSize: 35,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 80.0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.edit),
          //   color: Colors.white,
          // ),
          // IconButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const SettingsPage()),
          //     );
          //   },
          //   icon: const Icon(Icons.settings),
          //   iconSize: 30.0,
          //   color: Colors.white,
          // ),
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                print("Signed Out");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInScreen()));
              });
            },
            icon: const Icon(Icons.logout_outlined),
            iconSize: 30.0,
            color: Colors.white,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: double.infinity,
              // padding: EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                color: Colors.grey.shade800,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal Details',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text(
                        'Name: ',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text(
                        'Age: ',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text(
                        'Gender: ',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text(
                        'Height: ',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text(
                        'Weight: ',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text(
                        'Dietary Prference: ',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text(
                        'Lactose Intolerance: ',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text(
                        'Allergy: ',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
            child: Card(
              elevation: 5,
              color: Colors.grey.shade800,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fasting Blood Sugar Level: ',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // SizedBox(
                    //   height: 3.0,
                    // ),
                    // Text(
                    //   'Fasting: ',
                    //   style: TextStyle(color: Colors.white),
                    // ),
                    // SizedBox(
                    //   height: 3.0,
                    // ),
                    // Text(
                    //   'Pre-meal: ',
                    //   style: TextStyle(color: Colors.white),
                    // ),
                    // SizedBox(
                    //   height: 3.0,
                    // ),
                    // Text(
                    //   'Post-meal: ',
                    //   style: TextStyle(color: Colors.white),
                    // ),
                    // SizedBox(
                    //   height: 3.0,
                    // ),
                    // Text(
                    //   'Bedtime: ',
                    //   style: TextStyle(color: Colors.white),
                    // ),
                    // SizedBox(
                    //   height: 3.0,
                    // ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
