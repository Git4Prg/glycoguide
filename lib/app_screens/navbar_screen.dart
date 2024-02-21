import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  TextEditingController bloodSugarController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade800,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            // arrowColor: Colors.white,
            accountName: const Text(
              'Parigyan',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: const Text(
              'parigyan.sroy@gmail.com',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset('assets/images/profile.jpg'),
              ),
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background4.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16, bottom: 16),
                child: Text(
                  'Predecided Prompts',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  '1. Create a personalized meal plan considering my dietary preferences',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                onTap: () => print('Button was tapped'),
              ),
              ListTile(
                title: const Text(
                  '2. Recommend snacks that won\'t spike my blood sugar levels',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                onTap: () => print('Button was tapped'),
              ),
              ListTile(
                title: const Text(
                  '3. Please suggest a diabetic-friendly dinner for tonight',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                onTap: () => print('Button was tapped'),
              ),
              ListTile(
                title: const Text(
                  '4. I\'m looking for healthy dessert options suitable for diabetes',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                onTap: () => print('Button was tapped'),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 16, right: 16),
              //   child: TextField(
              //     controller: bloodSugarController,
              //     cursorColor: Theme.of(context).primaryColor,
              //     decoration: InputDecoration(
              //         border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(50),
              //         ),
              //         hintText: "Enter Fasting Blood Sugar here",
              //         hintStyle: TextStyle(color: Colors.white),
              //         filled: true,
              //         focusedBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(100),
              //         )),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
