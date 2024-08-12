// import 'package:flutter/material.dart';

// class FinanceLessonModuleWidget extends StatelessWidget {
//   final String assetImagePath;
//   final int lessonCount;
//   final String moduleName;
//   final VoidCallback onGetStarted;

//   FinanceLessonModuleWidget({
//     required this.assetImagePath,
//     required this.lessonCount,
//     required this.moduleName,
//     required this.onGetStarted,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4.0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           children: [
//             // Asset Image
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8.0),
//               child: Image.asset(
//                 assetImagePath,
//                 width: 60,
//                 height: 60,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             SizedBox(width: 16.0),

//             // Lesson Info and Module Name
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Number of Lessons
//                   Text(
//                     '$lessonCount Lessons',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   SizedBox(height: 8.0),

//                   // Module Name
//                   Text(
//                     moduleName,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: const Color.fromARGB(210, 5, 242, 155),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(width: 16.0),

//             // Get Started Button
//             ElevatedButton(
//               onPressed: onGetStarted,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color.fromARGB(210, 5, 242, 155), // Button color
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//               child: Text(
//                 'Get Started',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.black, // Button text color
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
