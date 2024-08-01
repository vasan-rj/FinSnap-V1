// // import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:async';
// import 'dart:convert';

// import 'package:finsnap/main.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:finsnap/screens/remainder.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:finsnap/screens/remainder.dart';
// Future<void>handlebackgroundmessage(RemoteMessage message)async 
// {
//   print("Title: ${message.notification?.title} ");

//   print("Body: ${message.notification?.body}");

//   print("Payload: ${message.data}");

// }

// class PushNotification{
//   final _firebaseMessaging = FirebaseMessaging.instance;

//   final _andriodChannel= const  AndroidNotificationChannel(
//     'high_importance_channel',
//     'High Importance Notifications',
//     importance: Importance.defaultImportance,
//   );

//   final _localNotifications=FlutterLocalNotificationsPlugin();

//   void handleMessage(RemoteMessage? message)
//   {
//     if(message != null)
//     {
//       return;
//     }
//     navigatorkey.currentState?.pushNamed(
//       RemainderPage.route,
//       arguments: message,
//     );
  
//   }

//   Future initLocalNotification()async
//   {
//     const andriod=AndroidInitializationSettings('@mipmap/launcher_icon');
//     const settings=InitializationSettings(android: andriod);

//     await _localNotifications.initialize(
//       settings,
//       onDidReceiveNotificationResponse: (payload){
//         final message=RemoteMessage.fromMap(jsonEncode(payload) as Map<String, dynamic>);
//         handleMessage(message);

//       }, 
//     );
//     final platform =_localNotifications.resolvePlatformSpecificImplementation<
//     AndroidFlutterLocalNotificationsPlugin>();

//     await platform?.createNotificationChannel(_andriodChannel);

//   }

//   Future initPushNotifications() async 
//   {
//     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//     FirebaseMessaging.onBackgroundMessage(handlebackgroundmessage);
//     FirebaseMessaging.onMessage.listen((message){
//     final notification=message.notification;

//         if(notification==null) return;

//         _localNotifications.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//               _andriodChannel.id,
//               _andriodChannel.name,
//               channelDescription: _andriodChannel.description,
//               icon: '@mipmap/launcher_icon',
//             ),
//           ),
//           payload: jsonEncode(message.toMap()),
//         );
//     });
//   }

//   Future<void> initNotification() async
//   {
//     // request permission from user 
//     await _firebaseMessaging.requestPermission(
//       alert: true,
//       announcement: true,
//       badge: true,
//       carPlay: false,
//       criticalAlert: true,
//       provisional: true,
//       sound: true,
//     );
  
//     // get token from firebase
//     // fetch FCM token for the device 
//     final FCMToken = await _firebaseMessaging.getToken();
  
//     print('Tokenxxxx $FCMToken');
//     initPushNotifications();
//     initLocalNotification();
//     FirebaseMessaging.onBackgroundMessage(handlebackgroundmessage);


//   }
// }


// // condition check for push notification



import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// This function is called whenever a background message is received.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void setupFirebaseMessagingx() {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

// This function is called whenever a background message is received.
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print("Handling a background message: ${message.messageId}");
// }

// void setupFirebaseMessaging() {
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
// }