import 'package:flutter/material.dart';
import 'package:glycoguide/profile_page.dart';
import 'package:glycoguide/settings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Navigator.pushNamedAndRemoveUntil(context, ## your routename here ##, (_) => false);
      appBar: AppBar(
        title: const Text('GlycoGuide'),
        centerTitle: true,
        backgroundColor: Colors.green[100],
        toolbarHeight: 80.0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Ink(
              decoration: ShapeDecoration(
                color: Colors.green[200],
                shape: const CircleBorder(),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()),
                  );
                },
                icon: const Icon(Icons.person),
                iconSize: 30.0,
              ),
            ),
          ),
          Ink(
            decoration: ShapeDecoration(
              color: Colors.green[200],
              shape: const CircleBorder(),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
              icon: const Icon(Icons.settings),
              iconSize: 30.0,
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 60,
                      child: TextField(
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: 'Type your question here',
                          labelStyle: TextStyle(
                            fontSize: 20.0,
                            color: Colors.blueGrey[700],
                          ),
                          fillColor: Colors.green[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Ink(
                    decoration: ShapeDecoration(
                      color: Colors.green[200],
                      shape: const CircleBorder(),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send_rounded),
                      iconSize: 35.0,
                      color: Colors.white,
                      onPressed: () {},
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Ink(
                    decoration: ShapeDecoration(
                      color: Colors.green[200],
                      shape: const CircleBorder(),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.photo_camera),
                      iconSize: 35.0,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
