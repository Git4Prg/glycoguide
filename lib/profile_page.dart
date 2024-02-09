import 'package:flutter/material.dart';
import 'package:glycoguide/home_page.dart';
import 'package:glycoguide/settings.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        title: const Text('Profile'),
        toolbarHeight: 80.0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
            icon: const Icon(Icons.settings),
            iconSize: 30.0,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout_outlined),
            iconSize: 30.0,
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: '),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text('Age: '),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text('Gender: '),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text('Height: '),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text('Weight: '),
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Blood Glucose Level'),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text('Fasting: '),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text('Pre-meal: '),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text('Post-meal: '),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text('Bedtime: '),
                    SizedBox(
                      height: 3.0,
                    ),
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
