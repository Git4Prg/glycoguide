// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:glycoguide/home_page.dart';
// //import 'package:glycoguide/home_page.dart';
// import 'package:glycoguide/profile_details.dart';
// import 'package:glycoguide/signup_page.dart';
// import 'package:glycoguide/reusable_widget.dart';
// import 'package:glycoguide/utils/color_utils.dart';
// //import 'package:shared_preferences/shared_preferences.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   TextEditingController _passwordTextController = TextEditingController();
//   TextEditingController _emailTextController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
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
//                 logoWidget("assets/images/glycoguide.jpg"),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 reusableTextField(
//                     "Enter Username", false, _emailTextController),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 reusableTextField(
//                     "Enter Password", true, _passwordTextController),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 firebaseUIButton(context, true, () {
//                   FirebaseAuth.instance
//                       .signInWithEmailAndPassword(
//                           email: _emailTextController.text,
//                           password: _passwordTextController.text)
//                       .then((value) {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const HomePage()));
//                   }).onError((error, stackTrace) {
//                     print("Error ${error.toString()}");
//                   });
//                 }),
//                 signUpOption(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Row signUpOption() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Text(
//           "Don't have an account?",
//           style: TextStyle(color: Colors.white70),
//         ),
//         GestureDetector(
//           onTap: () {
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => SignupPage()));
//           },
//           child: const Text(
//             "Sign Up",
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ],
//     );
//   }
// }












// // 


// // body: SingleChildScrollView(
// //         child: Container(
// //           padding: const EdgeInsets.all(16.0),
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             crossAxisAlignment: CrossAxisAlignment.stretch,
// //             children: [
// //               Container(
// //                 height: 200,
// //                 width: 200,
// //                 padding: const EdgeInsets.only(bottom: 16.0),
// //                 child: const Image(
// //                   image: AssetImage('assets/images/glycoguide.jpg'),
// //                 ),
// //               ),
// //               const TextField(
// //                 //controller: emailcontroller,
// //                 decoration: InputDecoration(
// //                   labelText: 'Email',
// //                 ),
// //               ),
// //               const SizedBox(height: 16),
// //               const TextField(
// //                 obscureText: true,
// //                 decoration: InputDecoration(
// //                   labelText: 'Password',
// //                 ),
// //               ),
// //               const SizedBox(height: 32),
// //               ElevatedButton(
// //                 onPressed: () async {
// //                   //final SharedPreferences sharedPreferences =
// //                   //await SharedPreferences.getInstance();
// //                   //sharedPreferences.setString('email', emailcontroller.text);
// //                   //Get.to(HomePage());
// //                 },
// //                 child: const Text('Login'),
// //               ),
// //               const SizedBox(height: 16),
// //               TextButton(
// //                 onPressed: () {
// //                   Navigator.push(
// //                     context,
// //                     MaterialPageRoute(builder: (context) => const SignupPage()),
// //                   );
// //                 },
// //                 child: const Text('Don\'t have an account? Sign up'),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),