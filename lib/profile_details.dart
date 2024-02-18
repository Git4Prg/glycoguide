// import 'package:flutter/material.dart';
// import 'package:glycoguide/home_page.dart';

// class ProfileDetails extends StatelessWidget {
//   const ProfileDetails({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sign Up Page'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const TextField(
//                 decoration: InputDecoration(
//                   labelText: 'Name',
//                 ),
//               ),
//               const TextField(
//                 decoration: InputDecoration(
//                   labelText: 'Age',
//                 ),
//               ),
//               const TextField(
//                 decoration: InputDecoration(
//                   labelText: 'Gender',
//                 ),
//               ),
//               const TextField(
//                 decoration: InputDecoration(
//                   labelText: 'Height',
//                 ),
//               ),
//               const TextField(
//                 decoration: InputDecoration(
//                   labelText: 'Weight',
//                 ),
//               ),
//               const SizedBox(height: 32),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const MedicalHistory()),
//                   );
//                 },
//                 child: const Text('Next'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MedicalHistory extends StatelessWidget {
//   const MedicalHistory({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Medical History'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const TextField(
//                 decoration: InputDecoration(
//                   labelText: 'When were you diagnosed with diabetes?',
//                 ),
//               ),
//               const TextField(
//                 decoration: InputDecoration(
//                   labelText: 'Do you have a heart disease?',
//                 ),
//               ),
//               const TextField(
//                 decoration: InputDecoration(
//                   labelText: 'Do you use an insulin pump?',
//                 ),
//               ),
//               const TextField(
//                 decoration: InputDecoration(
//                   labelText: 'Do you test your blood sugar?',
//                 ),
//               ),
//               const TextField(
//                 decoration: InputDecoration(
//                   labelText: 'Please specify any other complications(if any)',
//                 ),
//               ),
//               const TextField(
//                 decoration: InputDecoration(
//                   labelText: 'How often do you exercise?',
//                 ),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const HomePage()),
//                   );
//                 },
//                 child: const Text('Next'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
