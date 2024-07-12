// import 'package:finsnap/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:finsnap/screens/fingerprint.dart';
import 'package:finsnap/utils/theme/themedata.dart';
// import 'package:firebase_auth/firebase_auth.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  try {
    await Firebase.initializeApp();
  } 
  catch (e) {
    print('Error initializing Firebase vasan: $e');
    // Handle Firebase initialization error as needed
  }

  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      color: Color.fromARGB(210, 5, 242, 155),
      themeMode: ThemeMode.dark,
      theme: TAppTheme.darkTheme,
      home: const fingerprintPage(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text('Vasan is You have pushed the button this many times:'),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// WidgetsFlutterBinding.ensureInitialized();
//   // We're using the manual installation on non-web platforms since Google sign in plugin doesn't yet support Dart initialization.
//   // See related issue: https://github.com/flutter/flutter/issues/96391

//   // We store the app and auth to make testing with a named instance easier.
//   app = await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
