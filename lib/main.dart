// import 'package:finsnap/wrapper.dart';
import 'package:finsnap/screens/ai-features/ai_credit_bot.dart';
import 'package:finsnap/screens/ai-features/ai_loan_bot.dart';
import 'package:finsnap/screens/ai-features/ai_tax_bot.dart';
import 'package:finsnap/screens/ai-features/health_score.dart';
import 'package:finsnap/screens/ai-features/roadmap-generator.dart';
import 'package:finsnap/screens/appdrawer/contact-us.dart';
import 'package:finsnap/screens/appdrawer/updates_faq.dart';
import 'package:finsnap/screens/learning-module/module1.dart';
import 'package:finsnap/screens/testing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:finsnap/screens/fingerprint.dart';
import 'package:finsnap/utils/theme/themedata.dart';
import 'package:finsnap/services/firebase_messaging_setup.dart';
import 'package:finsnap/services/notification.dart';
import 'package:finsnap/screens/remainder.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:finsnap/permission/notification_permission.dart';


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
    // await dotenv.load(fileName: ".env");

   
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
      GetPage(name: '/roadmap', page: () => RoadmapGeneratorClass()),
      GetPage(name: '//updates-faq', page: () => UpdateFAQScreen()),
      GetPage(name: '//contact-us', page: () => ContactUsScreen()),
      GetPage(name: '//module-one', page: () => module_one()),
      GetPage(name: '//taxbot', page: () => taxBot()),
      GetPage(name: '//loanbot', page: () => loanBot()),
      GetPage(name: '//creditbot', page: () => creditBot()),

      // module_one
      // '/updates-faq': (context) => UpdateFAQScreen(),
      // GetPage(name: '/toAccount', page: () => ToAccountPage()),
      // GetPage(name: '/bankToBank', page: () => BankToBankPage()),
    ],
      // routes: {
      //   RemainderPage.route : (context) =>const RemainderPage(),
      // },
    );
  }
}

