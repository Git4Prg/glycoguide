// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:glycoguide/home_page.dart';
// import 'package:glycoguide/profile_details.dart';
// import 'package:glycoguide/login_page.dart';
// import 'package:glycoguide/reusable_widget.dart';
// import 'package:glycoguide/utils/color_utils.dart';

// class SignupPage extends StatelessWidget {
//   SignupPage({super.key});

//   TextEditingController _passwordTextController = TextEditingController();
//   TextEditingController _emailTextController = TextEditingController();
//   TextEditingController _userNameTextController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back),
//           color: Colors.white,
//         ),
//         title: const Text(
//           "Sign Up",
//           style: TextStyle(
//               fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//       ),
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               hexStringToColor("CB2B93"),
//               hexStringToColor("9546C4"),
//               hexStringToColor("5E61F4"),
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.fromLTRB(
//                 20, MediaQuery.of(context).size.height * 0.2, 20, 0),
//             child: Column(
//               children: <Widget>[
//                 // const SizedBox(
//                 //   height: 30,
//                 // ),
//                 reusableTextField(
//                     "Enter Username", false, _userNameTextController),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 reusableTextField(
//                     "Enter Email Id", false, _emailTextController),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 reusableTextField(
//                     "Enter Password", true, _passwordTextController),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 firebaseUIButton(
//                   context,
//                   false,
//                   () {
//                     FirebaseAuth.instance
//                         .createUserWithEmailAndPassword(
//                             email: _emailTextController.text,
//                             password: _passwordTextController.text)
//                         .then((value) {
//                       print("Created New Account");
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const HomePage()));
//                     }).onError((error, stackTrace) {
//                       print("Error ${error.toString()}");
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }













// // appBar: AppBar(
// //         title: const Text('Sign Up'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           crossAxisAlignment: CrossAxisAlignment.stretch,
// //           children: [
// //             const TextField(
// //               decoration: InputDecoration(
// //                 labelText: 'Email',
// //               ),
// //             ),
// //             const SizedBox(height: 16),
// //             const TextField(
// //               obscureText: true,
// //               decoration: InputDecoration(
// //                 labelText: 'Password',
// //               ),
// //             ),
// //             const SizedBox(height: 16),
// //             const TextField(
// //               obscureText: true,
// //               decoration: InputDecoration(
// //                 labelText: 'Confirm Password',
// //               ),
// //             ),
// //             const SizedBox(height: 32),
// //             ElevatedButton(
// //               onPressed: () {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(
// //                       builder: (context) => const ProfileDetails()),
// //                 );
// //               },
// //               child: const Text('Sign Up'),
// //             ),
// //             const SizedBox(height: 16),
// //             TextButton(
// //               onPressed: () {
// //                 Navigator.pop(context);
// //               },
// //               child: const Text('Already have an account? Login'),
// //             ),
// //           ],
// //         ),
// //       ),