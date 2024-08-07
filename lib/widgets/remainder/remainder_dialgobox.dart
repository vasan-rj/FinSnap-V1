// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:finsnap/services/notification_db_service.dart';

// class remainderDialogboxclass extends StatefulWidget {
//   const remainderDialogboxclass({super.key});

//   @override
//   State<remainderDialogboxclass> createState() => _remainderDialogboxclassState();
// }

// class _remainderDialogboxclassState extends State<remainderDialogboxclass> {

//     String dropdownValue = 'Option 1';
//     final TextEditingController _titleController = TextEditingController();
//     final TextEditingController _descriptionController = TextEditingController();
//     final TextEditingController _typeController = TextEditingController();
//     DateTime? _selectedDate;
//     TimeOfDay? _selectedTime;
//   final user = FirebaseAuth.instance.currentUser;
//     Dialog notificationDialogbox() => Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           decoration: BoxDecoration(
//             color: Color.fromARGB(11, 158, 158, 158),
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(),
//                     const Text(
//                       "Create Notification",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 22,
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: const Icon(
//                         Icons.close,
//                         color: Colors.red,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 TextField(
//                   controller: _titleController,
//                   decoration: InputDecoration(
//                     labelText: "Title",
//                     filled: true,
//                     fillColor: Colors.black26,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextField(
//                   controller: _descriptionController,
//                   decoration: InputDecoration(
//                     labelText: "Description",
//                     filled: true,
//                     fillColor: Colors.black26,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextField(
//                   controller: _typeController,
//                   decoration: InputDecoration(
//                     labelText: "Type",
//                     filled: true,
//                     fillColor: Colors.black26,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () => _selectDate(context),
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           backgroundColor:
//                               const Color.fromARGB(210, 5, 242, 155),
//                           foregroundColor: Colors.white,
//                           textStyle: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         child: const Text("Date"),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () => _selectTime(context),
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           backgroundColor:
//                               const Color.fromARGB(210, 5, 242, 155),
//                           foregroundColor: Colors.white,
//                           textStyle: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         child: const Text("Time"),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () async {
//                     // validateAndSaveNotification(context, saveNotification);
//                     if (_selectedDate != null &&
//                         _selectedTime != null &&
//                         user != null) {
//                       final selectedDateTime = DateTime(
//                         _selectedDate!.year,
//                         _selectedDate!.month,
//                         _selectedDate!.day,
//                         _selectedTime!.hour,
//                         _selectedTime!.minute,
//                       );
//                       if (await validateAndSaveNotification(
//                           context, saveNotification)) {
//                         await saveNotification(
//                           user!.email.toString(),
//                           _titleController.text,
//                           _descriptionController.text,
//                           selectedDateTime,
//                           _typeController.text,
//                         );

//                         _titleController.clear();
//                         _descriptionController.clear();
//                         _typeController.clear();
//                         _selectedDate = null;
//                         _selectedTime = null;

//                         Get.snackbar('Notification Scheduled',
//                             'Notification scheduled for $selectedDateTime');
//                         Navigator.pop(context);
//                       } else {
//                         Get.snackbar("Error",
//                             'The selected date should be today or later, and the time should be at least 30 minutes from now.');
//                         Navigator.pop(context);
//                       }
//                     } else {
//                       Get.snackbar("Error",
//                           'Please select a date and fill in all fields');
//                       Navigator.pop(context);
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     backgroundColor: const Color.fromARGB(210, 5, 242, 155),
//                     foregroundColor: Colors.black,
//                     textStyle: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   child: Ink(
//                     // decoration: BoxDecoration(
//                     //   gradient: const LinearGradient(
//                     //     colors: [  Color.fromARGB(210, 5, 242, 155), Colors.teal],
//                     //     begin: Alignment.centerLeft,
//                     //     end: Alignment.centerRight,
//                     //   ),
//                     //   borderRadius: BorderRadius.circular(10),
//                     // ),
//                     child: Container(
//                       alignment: Alignment.center,
//                       // constraints: const BoxConstraints(minHeight: 50), // Set a minimum height for the button
//                       // padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                       child: const Text(
//                         "Set Notification",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 15),
//               ],
//             ),
//           ),
//         ),
//       );

//   Dialog updateNotificationDialogbox(DocumentSnapshot snapshot) => Dialog(
//         // backgroundColor: Colors.grey,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           decoration: BoxDecoration(
//             color: Theme.of(context).dialogBackgroundColor,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(),
//                     const Text(
//                       "Alter Notification",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 22,
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: const Icon(
//                         Icons.close,
//                         color: Colors.red,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 TextField(
//                   controller: _titleController,
//                   decoration: InputDecoration(
//                     labelText: "Title",
//                     filled: true,
//                     fillColor: Colors.black26,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextField(
//                   controller: _descriptionController,
//                   decoration: InputDecoration(
//                     labelText: "Description",
//                     filled: true,
//                     fillColor: Colors.black26,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextField(
//                   controller: _typeController,
//                   decoration: InputDecoration(
//                     labelText: "Type",
//                     filled: true,
//                     fillColor: Colors.black26,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () => _selectDate(context),
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           backgroundColor:
//                               const Color.fromARGB(210, 5, 242, 155),
//                           foregroundColor: Colors.white,
//                           textStyle: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         child: const Text("Date"),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: () => _selectTime(context),
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           backgroundColor:
//                               const Color.fromARGB(210, 5, 242, 155),
//                           foregroundColor: Colors.white,
//                           textStyle: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         child: const Text("Time"),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () async {
//                     if (_selectedDate != null &&
//                         _selectedTime != null &&
//                         user != null) {
//                       final selectedDateTime = DateTime(
//                         _selectedDate!.year,
//                         _selectedDate!.month,
//                         _selectedDate!.day,
//                         _selectedTime!.hour,
//                         _selectedTime!.minute,
//                       );
//                       if (await validateAndSaveNotification(
//                           context, saveNotification)) {
//                         // Update the notification
//                         await db.doc(snapshot.id).update({
//                           'title': _titleController.text,
//                           'description': _descriptionController.text,
//                           'date': selectedDateTime,
//                           'type': _typeController.text,
//                         });

//                         _titleController.clear();
//                         _descriptionController.clear();
//                         _typeController.clear();
//                         _selectedDate = null;
//                         _selectedTime = null;

//                         Navigator.pop(context);

//                         Get.snackbar('Notification Updated',
//                             'Notification updated for $selectedDateTime');
//                       } else {
//                         Navigator.pop(context);
//                         Get.snackbar("Error",
//                             'The selected date should be today or later, and the time should be at least 30 minutes from now.');
//                         //  Navigator.pop(context);
//                       }
//                     } else {
//                       Get.snackbar("Error",
//                           'Please select a date and fill in all fields');
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     backgroundColor: const Color.fromARGB(210, 5, 242, 155),
//                     foregroundColor: Colors.white,
//                     textStyle: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   child: const Text("Update Notification"),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
  
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }