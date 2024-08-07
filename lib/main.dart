// import 'package:finsnap/wrapper.dart';
import 'package:finsnap/screens/ai-features/health_score.dart';
import 'package:finsnap/screens/testing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:finsnap/screens/fingerprint.dart';
import 'package:finsnap/utils/theme/themedata.dart';
import 'package:finsnap/services/firebase_messaging_setup.dart';
import 'package:finsnap/services/notification.dart';
import 'package:finsnap/screens/remainder.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:finsnap/permission/notification_permission.dart';


import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:finsnap/services/firebase_messaging_setup.dart';


// import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:timezone/data/latest.dart' as tz;

// import 'package:pushnotitutefinal/firebase_options.dart';
// import 'package:firebase_auth/firebase_auth.dart';

final navigatorkey=GlobalKey<NavigatorState>();

void main() async {

  // Initialize Firebase
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    tz.initializeTimeZones();
    
    await NotificationService().initNotification();
    await requestScheduleExactAlarmPermission();
     
     setupFirebaseMessagingx();

   
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    // Run the app

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      title: 'Flutter Demo',
      color: const Color.fromARGB(210, 5, 242, 155),
      themeMode: ThemeMode.dark,
      theme: TAppTheme.darkTheme,
      home:fingerprintPage(),
      getPages: [
      GetPage(name: '/healthscore', page: () => HealthScorePage()),
      // GetPage(name: '/toAccount', page: () => ToAccountPage()),
      // GetPage(name: '/bankToBank', page: () => BankToBankPage()),
    ],
      // routes: {
      //   RemainderPage.route : (context) =>const RemainderPage(),
      // },
    );
  }
}

