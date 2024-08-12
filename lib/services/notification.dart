import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

//
import 'dart:async';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    final _firebaseMessaging = FirebaseMessaging.instance;
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('launcher_icon');

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});

    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    tz.initializeTimeZones();
     const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // This should match the ID in AndroidNotificationDetails
    'high_importance_channel',
    description: 'Your channel description',
    importance: Importance.max,
  );

  await notificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel',
          'channelName',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  Future scheduleNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payLoad,
      required DateTime scheduledNotificationDateTime}) async {
    print("Scheduling notification for: $scheduledNotificationDateTime");
    // return notificationsPlugin.zonedSchedule(
    //     id,
    //     title,
    //     body,
    //     tz.TZDateTime.from(
    //       scheduledNotificationDateTime,
    //       tz.local,
    //     ),
    //     await notificationDetails(),

    //     androidScheduleMode:AndroidScheduleMode.exactAllowWhileIdle,

    //     uiLocalNotificationDateInterpretation:
    //         UILocalNotificationDateInterpretation.absoluteTime);
    try {
      await notificationsPlugin.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(scheduledNotificationDateTime, tz.local),
          await notificationDetails(),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime).whenComplete(() => print("Notification scheduled successfully ohh priya.."));
      
    } catch (e) {
      print("Error scheduling notification: $e");
    }
  }
}
