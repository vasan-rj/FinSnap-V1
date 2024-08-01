// uid = User mail address

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:finsnap/services/notification_db_service.dart';
import 'package:finsnap/services/firebase_messaging_setup.dart';
import 'package:finsnap/services/notification.dart';
// import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

// 


  void setupFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        // Handle your notification display logic here
        // For example, you might show a dialog or update the UI
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked! ${message.messageId}');
      // Handle what happens when the user clicks the notification
    });
  }


class RemainderPage extends StatefulWidget {
  const RemainderPage({super.key});
  static const route='/remainder';

  @override
  State<RemainderPage> createState() => _RemainderPageState();
}

class _RemainderPageState extends State<RemainderPage> {
   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String dropdownValue = 'Option 1';
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final user = FirebaseAuth.instance.currentUser;

// 
  late final db = FirebaseFirestore.instance
      .collection("Users")
      .doc(user!.email.toString())
      .collection("Custom_Notification");
  // final query=db.where(field);

  Future<void> createDialogboxNotification() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return notificationDialogbox();
      },
    );
  }

  Future<void> updateNotification(DocumentSnapshot snapshot) async {
    _titleController.text = snapshot['title'];
    _descriptionController.text = snapshot['description'];
    _typeController.text = snapshot['notificationType'];
    _selectedDate = snapshot['date'].toDate();
    _selectedTime = TimeOfDay.fromDateTime(snapshot['date'].toDate());

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return updateNotificationDialogbox(snapshot);
      },
    );
  }

  Future<void> deleteNotification(String productId) async {
    await db.doc(productId).delete();
    Get.snackbar("Item Deleted", "Successfully removed element..");
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<bool> validateAndSaveNotification(
      BuildContext context, Function saveNotificationCallback) async {
    // if (_selectedDate != null && _selectedTime != null && user != null)
    // {
    final currentDateTime = DateTime.now();
    final selectedDateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    if (selectedDateTime
            .isBefore(currentDateTime.add(const Duration(minutes:1))) ||
        _selectedDate!.isBefore(DateTime(currentDateTime.year,
            currentDateTime.month, currentDateTime.day))) {
      // Get.snackbar("Error",
      //     'The selected date should be today or later, and the time should be at least 30 minutes from now.');
      return false;
    } else {
      // Get.snackbar("Error", 'Please select a date and fill in all fields');
      return true;
    }
  }

  Dialog notificationDialogbox() => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Color.fromARGB(11, 158, 158, 158),
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    const Text(
                      "Create Notification",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: "Title",
                    filled: true,
                    fillColor: Colors.black26,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: "Description",
                    filled: true,
                    fillColor: Colors.black26,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _typeController,
                  decoration: InputDecoration(
                    labelText: "Type",
                    filled: true,
                    fillColor: Colors.black26,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _selectDate(context),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor:
                              const Color.fromARGB(210, 5, 242, 155),
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: const Text("Date"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _selectTime(context),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor:
                              const Color.fromARGB(210, 5, 242, 155),
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: const Text("Time"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    // validateAndSaveNotification(context, saveNotification);
                    if (_selectedDate != null &&
                        _selectedTime != null &&
                        user != null) {
                      final selectedDateTime = DateTime(
                        _selectedDate!.year,
                        _selectedDate!.month,
                        _selectedDate!.day,
                        _selectedTime!.hour,
                        _selectedTime!.minute,
                      );
                      if (await validateAndSaveNotification(context, saveNotification)) 
                      {
                         await saveNotification(
                          user!.email.toString(),
                          _titleController.text,
                          _descriptionController.text,
                          selectedDateTime,
                          _typeController.text,
                        );

                        NotificationService().showNotification(
                          title: _titleController.text,
                          body: _descriptionController.text,
                        );

                         NotificationService().scheduleNotification(
                          title: _titleController.text,
                          body: _descriptionController.text,
                          scheduledNotificationDateTime: selectedDateTime,
                        );

                       
  // Scheduling Notifications from Services/remainder.dart ;


                        _titleController.clear();
                        _descriptionController.clear();
                        _typeController.clear();
                        _selectedDate = null;
                        _selectedTime = null;

                        Get.snackbar('Notification Scheduled',
                            'Notification scheduled for $selectedDateTime');
                        Navigator.pop(context);
                      } else {
                        Get.snackbar("Error",
                            'The selected date should be today or later, and the time should be at least 30 minutes from now.');
                        Navigator.pop(context);
                      }
                    } else {
                      Get.snackbar("Error",
                          'Please select a date and fill in all fields');
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: const Color.fromARGB(210, 5, 242, 155),
                    foregroundColor: Colors.black,
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: Ink(
                   
                    // ),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "Set Notification",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      );

  Dialog updateNotificationDialogbox(DocumentSnapshot snapshot) => Dialog(
        // backgroundColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    const Text(
                      "Alter Notification",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: "Title",
                    filled: true,
                    fillColor: Colors.black26,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: "Description",
                    filled: true,
                    fillColor: Colors.black26,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _typeController,
                  decoration: InputDecoration(
                    labelText: "Type",
                    filled: true,
                    fillColor: Colors.black26,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _selectDate(context),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor:
                              const Color.fromARGB(210, 5, 242, 155),
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: const Text("Date"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _selectTime(context),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor:
                              const Color.fromARGB(210, 5, 242, 155),
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: const Text("Time"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_selectedDate != null &&
                        _selectedTime != null &&
                        user != null) {
                      final selectedDateTime = DateTime(
                        _selectedDate!.year,
                        _selectedDate!.month,
                        _selectedDate!.day,
                        _selectedTime!.hour,
                        _selectedTime!.minute,
                      );
                      if (await validateAndSaveNotification(
                          context, saveNotification)) {
                        // Update the notification
                        await db.doc(snapshot.id).update({
                          'title': _titleController.text,
                          'description': _descriptionController.text,
                          'date': selectedDateTime,
                          'type': _typeController.text,
                        });

                        _titleController.clear();
                        _descriptionController.clear();
                        _typeController.clear();
                        _selectedDate = null;
                        _selectedTime = null;

                        Navigator.pop(context);

                        Get.snackbar('Notification Updated',
                            'Notification updated for $selectedDateTime');
                      } else {
                        Navigator.pop(context);
                        Get.snackbar("Error",
                            'The selected date should be today or later, and the time should be at least 30 minutes from now.');
                        //  Navigator.pop(context);
                      }
                    } else {
                      Get.snackbar("Error",
                          'Please select a date and fill in all fields');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: const Color.fromARGB(210, 5, 242, 155),
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: const Text("Update Notification"),
                ),
              ],
            ),
          ),
        ),
        );

  @override
  void initState(){
    super.initState();
    setupFirebaseMessaging();
    tz.initializeTimeZones();
    
  }
  // Push Notification Initialization and FCM Genaeration
  //  void initState() {
  //   super.initState();
  //   FirebaseMessaging.instance.subscribeToTopic('notifications');
  //   PushNotification();

  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     RemoteNotification? notification = message.notification;
  //     AndroidNotification? android = message.notification?.android;

  //     if (notification != null && android != null) {
  //       showDialog(
  //         context: context,
  //         builder: (_) {
  //           return AlertDialog(
  //             title: Text(notification.title!),
  //             content: SingleChildScrollView(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [Text(notification.body!)],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     }
  //   });

  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     print('A new onMessageOpenedApp event was published!');
  //     RemoteNotification? notification = message.notification;
  //     AndroidNotification? android = message.notification?.android;
  //     if (notification != null && android != null) {
  //       showDialog(
  //         context: context,
  //         builder: (_) {
  //           return AlertDialog(
  //             title: Text(notification.title!),
  //             content: SingleChildScrollView(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [Text(notification.body!)],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     }
  //   });
  // }
  // end........
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Custom Remainder",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        backgroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Column(
        children: [
           SizedBox(height: 15,),
          Center(
            child: Text(
              "Upcoming Remainders",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(210, 5, 242, 155),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: db
                  .where('date',
                      isGreaterThan: Timestamp.fromDate(DateTime.now()))
                  .orderBy('date')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Color.fromARGB(210, 5, 242, 155),
                      color: Color.fromARGB(210, 5, 242, 155),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No data found'));
                }

                return ListView.builder(
                  // final q=snapshot.data!.docs.
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot document =
                        snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Color.fromARGB(68, 158, 158, 158),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          title: Text(
                            document['title'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            document['description'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () => updateNotification(document),
                                  icon: const Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      deleteNotification(document.id),
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const Divider(),
          const SizedBox(height: 15),
          const Center(
            child: Text(
              "Past Remainders",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(179, 5, 242, 155),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 10),
          // ***
           Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: db
                .where('date', isLessThan: Timestamp.fromDate(DateTime.now()))
                .orderBy('date', descending: true)  // Descending order for past notifications
                .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Color.fromARGB(210, 5, 242, 155),
                      color: Color.fromARGB(210, 5, 242, 155),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No data found'));
                }

                return ListView.builder(
                  // final q=snapshot.data!.docs.
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot document =
                        snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Color.fromARGB(31, 158, 158, 158),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          title: Text(
                            document['title'],
                            style: const TextStyle(
                              color: Color.fromARGB(114, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              
                              // shadows:sha
                            ),
                          ),
                          subtitle: Text(
                            document['description'],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                // IconButton(
                                //   onPressed: () => updateNotification(document),
                                //   icon: const Icon(Icons.edit),
                                // ),
                                 const Spacer(),
                                IconButton(
                                  onPressed: () =>
                                      deleteNotification(document.id),
                                  icon: const Icon(Icons.delete),
                                  alignment:Alignment.bottomLeft,
                                  color: Color.fromARGB(63, 255, 255, 255),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createDialogboxNotification,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(210, 5, 242, 155),
      ),
      backgroundColor: const Color(0xFF1C1C1C),
    );
  }
}
