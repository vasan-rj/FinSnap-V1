// import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';

// class Homepage extends StatefulWidget {
//   const Homepage({super.key});

//   @override
//   State<Homepage> createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
//   final user = FirebaseAuth.instance.currentUser;
//   final apiKey = 'AIzaSyDwnp3gloCT8FmIUXxRxMdNsc57Fw3mxI8';
//   TextEditingController promptController = TextEditingController();
//   String generatedText = '';
//   bool isLoading = false;

//   signout() async {
//     await FirebaseAuth.instance.signOut();
//   }

//   get_text_gemini(String prompt) async {
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       final model = GenerativeModel(
//         model: 'gemini-1.5-flash-latest',
//         apiKey: apiKey,
//       );

//       final content = [Content.text(prompt)];
//       final response = await model.generateContent(content);

//       setState(() {
//         generatedText = response.text.toString();
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         generatedText = 'Error: ${e.toString()}';
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     get_text_gemini(''); // Initial prompt
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Homepage"),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (user != null)
//                 Text(
//                   'User: ${user!.email}',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               SizedBox(height: 20),
//               TextField(
//                 controller: promptController,
//                 decoration: InputDecoration(
//                   hintText: "Enter your prompt",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   filled: true,
//                   fillColor: Color.fromARGB(74, 9, 60, 57),
//                   contentPadding: EdgeInsets.symmetric(horizontal: 20),
//                   hintStyle: TextStyle(color:Color.fromARGB(255, 51, 209, 172)),
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () => get_text_gemini(promptController.text),
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.zero,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: Ink(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Color.fromARGB(210, 5, 242, 155),
//                         Color.fromARGB(255, 4, 140, 126)
//                       ],
//                       begin: Alignment.centerLeft,
//                       end: Alignment.centerRight,
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Container(
//                     alignment: Alignment.center,
//                     constraints: BoxConstraints(minHeight: 50),
//                     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                     child: Text(
//                       "Submit",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               if (isLoading)
//                 CircularProgressIndicator()
//               else
//                 Text(
//                   'Generated Content:\n$generatedText',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 16),
//                 ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => signout(),
//         child: Icon(Icons.logout),
//       ),
//     );
//   }
// }

// import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// class Homepage extends StatefulWidget {
//   const Homepage({super.key});

//   @override
//   State<Homepage> createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
//   final user = FirebaseAuth.instance.currentUser;
//   final apiKey = 'AIzaSyDwnp3gloCT8FmIUXxRxMdNsc57Fw3mxI8';
//   TextEditingController promptController = TextEditingController();
//   String generatedText = '';
//   bool isLoading = false;

//   signout() async {
//     await FirebaseAuth.instance.signOut();
//   }

//   get_text_gemini(String prompt) async {
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       final model = GenerativeModel(
//         model: 'gemini-1.5-flash-latest',
//         apiKey: apiKey,
//       );

//       final content = [Content.text(prompt)];
//       final response = await model.generateContent(content);

//       setState(() {
//         generatedText = response.text.toString();
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         generatedText = 'Error: ${e.toString()}';
//         isLoading = false;
//       });
//     }
//   }

//   saveResponse() async {
//     if (user != null && promptController.text.isNotEmpty && generatedText.isNotEmpty) {
//       try {
//         await FirebaseFirestore.instance.collection('responses').add({
//           'email': user!.email,
//           'prompt': promptController.text,
//           'response': generatedText,
//           'timestamp': Timestamp.now(),
//         });
//         Get.snackbar("Success", "Response saved successfully.");
//       } catch (e) {
//         Get.snackbar("Error", e.toString());
//       }
//     } else {
//       Get.snackbar("Error", "Prompt or response is empty.");
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     get_text_gemini(''); // Initial prompt
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Homepage"),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (user != null)
//                 Text(
//                   'User: ${user!.email}',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               SizedBox(height: 20),
//               TextField(
//                 controller: promptController,
//                 decoration: InputDecoration(
//                   hintText: "Enter your prompt",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                   contentPadding: EdgeInsets.symmetric(horizontal: 20),
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () => get_text_gemini(promptController.text),
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.zero,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: Ink(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Color.fromARGB(210, 5, 242, 155),
//                         Color.fromARGB(255, 4, 140, 126)
//                       ],
//                       begin: Alignment.centerLeft,
//                       end: Alignment.centerRight,
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Container(
//                     alignment: Alignment.center,
//                     constraints: BoxConstraints(minHeight: 50),
//                     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                     child: Text(
//                       "Submit",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () => saveResponse(),
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.zero,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: Ink(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Color.fromARGB(210, 5, 242, 155),
//                         Color.fromARGB(255, 4, 140, 126)
//                       ],
//                       begin: Alignment.centerLeft,
//                       end: Alignment.centerRight,
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Container(
//                     alignment: Alignment.center,
//                     constraints: BoxConstraints(minHeight: 50),
//                     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                     child: Text(
//                       "Save Response",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               if (isLoading)
//                 CircularProgressIndicator()
//               else
//                 Text(
//                   'Generated Content:\n$generatedText',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 16),
//                 ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => signout(),
//         child: Icon(Icons.logout),
//       ),
//     );
//   }
// }

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:get/get.dart';

// class Homepage extends StatefulWidget {
//   const Homepage({super.key});

//   @override
//   State<Homepage> createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
//   final user = FirebaseAuth.instance.currentUser;
//   final apiKey = dotenv.env['API_KEY'] ?? '';
//   TextEditingController promptController = TextEditingController();
//   String generatedText = '';
//   bool isLoading = false;

//   signout() async {
//     await FirebaseAuth.instance.signOut();
//   }

//   get_text_gemini(String prompt) async {
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       final model = GenerativeModel(
//         model: 'gemini-1.5-flash-latest',
//         apiKey: apiKey,
//       );

//       final content = [Content.text(prompt)];
//       final response = await model.generateContent(content);

//       setState(() {
//         generatedText = response.text.toString();
//         isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         generatedText = 'Error: ${e.toString()}';
//         isLoading = false;
//       });
//     }
//   }

//   saveResponse() async {
//     if (user != null && promptController.text.isNotEmpty && generatedText.isNotEmpty) {
//       try {
//         await FirebaseFirestore.instance.collection('responses').add({
//           'email': user!.email,
//           'prompt': promptController.text,
//           'response': generatedText,
//           'timestamp': Timestamp.now(),
//         });
//         Get.snackbar("Success", "Response saved successfully.");
//       } catch (e) {
//         Get.snackbar("Error", e.toString());
//       }
//     } else {
//       Get.snackbar("Error", "Prompt or response is empty.");
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     get_text_gemini('Write a story about a magic backpack.'); // Initial prompt
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Homepage"),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (user != null)
//                 Text(
//                   'User: ${user!.email}',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               SizedBox(height: 20),
//               TextField(
//                 controller: promptController,
//                 decoration: InputDecoration(
//                   hintText: "Enter your prompt",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   filled: true,
//                   fillColor: Colors.white,
//                   contentPadding: EdgeInsets.symmetric(horizontal: 20),
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () => get_text_gemini(promptController.text),
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.zero,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: Ink(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Color.fromARGB(210, 5, 242, 155),
//                         Color.fromARGB(255, 4, 140, 126)
//                       ],
//                       begin: Alignment.centerLeft,
//                       end: Alignment.centerRight,
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Container(
//                     alignment: Alignment.center,
//                     constraints: BoxConstraints(minHeight: 50),
//                     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                     child: Text(
//                       "Submit",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () => saveResponse(),
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.zero,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: Ink(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Color.fromARGB(210, 5, 242, 155),
//                         Color.fromARGB(255, 4, 140, 126)
//                       ],
//                       begin: Alignment.centerLeft,
//                       end: Alignment.centerRight,
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Container(
//                     alignment: Alignment.center,
//                     constraints: BoxConstraints(minHeight: 50),
//                     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                     child: Text(
//                       "Save Response",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               if (isLoading)
//                 CircularProgressIndicator()
//               else
//                 Text(
//                   'Generated Content:\n$generatedText',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 16),
//                 ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => signout(),
//         child: Icon(Icons.logout),
//       ),
//     );
//   }
// }

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';

// class Homepage extends StatefulWidget {
//   const Homepage({super.key});

//   @override
//   State<Homepage> createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
//   final user = FirebaseAuth.instance.currentUser;
//   final apiKey = 'AIzaSyDwnp3gloCT8FmIUXxRxMdNsc57Fw3mxI8';
//   TextEditingController promptController = TextEditingController();
//   String generatedText = '';
//   bool isLoading = false;
//   String promptHistory = '';

//   signout() async {
//     await FirebaseAuth.instance.signOut();
//   }

//   initializeModel() async {
//     try {
//       final model = GenerativeModel(
//         model: 'gemini-1.5-pro',
//         apiKey: apiKey,
//         generationConfig: GenerationConfig(
//           temperature: 0.7,
//           responseMimeType: "application/json",
//           topP: 0.85,
//           topK: 20,
//           maxOutputTokens: 250,
//         ),
//         systemInstruction: Content.system(
//           """
//           You are a Personal Financial Assistant for the user, your goal is to gather relevant financial information from the user to provide personalized financial recommendations and help them achieve their financial goals. 
//           Do not make assumptions, ask clarifying questions if not enough information is available. 
//           Give the answer in JSON, and if you are asking questions, put them in the 'questions' key of JSON.

//           Example:
//           {
//             "Questions": ["Question1", "Question2", "Question3"],
//             "Advice": "Your response"
//           }
//           """
//         ),
//       );

//       return model;
//     } catch (e) {
//       // Get.snackbar(e);
//       print(e);
//     }
//   }

//   structuredPrompt(String userPrompt) {
//     promptHistory += "\nUser: $userPrompt";
//     return promptHistory;
//   }

//   get_text_gemini(String prompt) async {
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       final model = await initializeModel();

//       if (model != null) {
//         final content = [Content.text(structuredPrompt(prompt))];
//         final response = await model.generateContent(content);

//         setState(() {
//           generatedText = response.text.toString();
//           promptHistory += "\nAI: $generatedText";
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           generatedText = 'Error: Could not initialize model';
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         generatedText = 'Error: ${e.toString()}';
//         isLoading = false;
//       });
//     }
//   }

//   saveResponse() async {
//     if (user != null && promptController.text.isNotEmpty && generatedText.isNotEmpty) {
//       try {
//         await FirebaseFirestore.instance.collection('responses').add({
//           'email': user!.email,
//           'prompt': promptController.text,
//           'response': generatedText,
//           'timestamp': Timestamp.now(),
//         });
//         Get.snackbar("Success", "Response saved successfully.");
//       } catch (e) {
//         Get.snackbar("Error", e.toString());
//       }
//     } else {
//       Get.snackbar("Error", "Prompt or response is empty.");
//     }
//   }

//   @override
//   void initState() {
//     if(promptController.text!='')
//    {
//     try{
//       super.initState();
//     initializeModel();
//     final initialPrompt =promptController.text;
//     get_text_gemini("i wanna buy $initialPrompt give a personalized financial advise so that i can decide weather i can buy it or not");
//     }
//     catch(e)
//     {
//       print(e);
//     }

//    }
    
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Homepage"),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (user != null)
//                 Text(
//                   'User: ${user!.email}',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               SizedBox(height: 20),
//               Text(
//                 'What you gonna Buy?',
//                 style: TextStyle(fontSize: 16),
//               ),
//               SizedBox(height: 20),
//               TextField(
//                 controller: promptController,
//                 decoration: InputDecoration(
//                   hintText: "Examples: Cars, House, Stocks etc..",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   filled: true,
//                   fillColor: Color.fromARGB(23, 255, 255, 255),
//                   contentPadding: EdgeInsets.symmetric(horizontal: 20),
//                 ),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () => get_text_gemini(promptController.text),
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.zero,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: Ink(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Color.fromARGB(210, 5, 242, 155),
//                         Color.fromARGB(255, 4, 140, 126)
//                       ],
//                       begin: Alignment.centerLeft,
//                       end: Alignment.centerRight,
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Container(
//                     alignment: Alignment.center,
//                     constraints: BoxConstraints(minHeight: 50),
//                     padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                     child: Text(
//                       "Submit",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               // ElevatedButton(
//               //   onPressed: () => saveResponse(),
//               //   style: ElevatedButton.styleFrom(
//               //     padding: EdgeInsets.zero,
//               //     shape: RoundedRectangleBorder(
//               //       borderRadius: BorderRadius.circular(10),
//               //     ),
//               //   ),
//               //   child: Ink(
//               //     decoration: BoxDecoration(
//               //       gradient: LinearGradient(
//               //         colors: [
//               //           Color.fromARGB(210, 5, 242, 155),
//               //           Color.fromARGB(255, 4, 140, 126)
//               //         ],
//               //         begin: Alignment.centerLeft,
//               //         end: Alignment.centerRight,
//               //       ),
//               //       borderRadius: BorderRadius.circular(10),
//               //     ),
//               //     child: Container(
//               //       alignment: Alignment.center,
//               //       constraints: BoxConstraints(minHeight: 50),
//               //       padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//               //       child: Text(
//               //         "Save Response",
//               //         style: TextStyle(
//               //           fontSize: 18,
//               //           fontWeight: FontWeight.bold,
//               //           color: Colors.white,
//               //         ),
//               //       ),
//               //     ),
//               //   ),
//               // ),
//               SizedBox(height: 20),
//               if (isLoading)
//                 CircularProgressIndicator()
//               else
//                 Text(
//                   'Generated Content:\n$generatedText \n\n\n $promptHistory',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 16),
//                 ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => signout(),
//         child: Icon(Icons.logout),
//       ),
//     );
//   }
// }
// // , how to i render the ui from the response on ai and the user prompt in the screen

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

import 'package:finsnap/screens/remainder.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // bottom app navigation bar
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    Text('AI Finance Assistant', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    Text('Custom Remainder', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (_selectedIndex == 0) {
        Get.to(() => Homepage());
      } else if (_selectedIndex == 1) {
        Get.to(() => Homepage());
      } else if (_selectedIndex == 2) {
        Get.to(() => remainderPage());
      }
      

    });
  } 
  

  // 
  final user = FirebaseAuth.instance.currentUser;
  // AIzaSyDdKgK8wpfxgAeHnOgpjSV_5VC5nBCP_rU
  final apiKey = 'AIzaSyDdKgK8wpfxgAeHnOgpjSV_5VC5nBCP_rU';
  TextEditingController promptController = TextEditingController();
  bool isLoading = false;
  List<ChatMessage> chatMessages = [];

  signout() async {
    await FirebaseAuth.instance.signOut();
  }

  initializeModel() async {
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-pro',
        apiKey: apiKey,
        generationConfig: GenerationConfig(
          temperature: 0.7,
          topP: 0.85,
          topK: 20,
          maxOutputTokens: 250,
        ),
        systemInstruction: Content.system(
          """
          You are a Personal Financial Assistant for the user, your goal is to gather relevant financial information from the user to provide personalized financial recommendations and help them achieve their financial goals. 
          Do not make assumptions, ask clarifying questions if not enough information is available. 
          Ask only one question at a time to the user.
          """
        ),
      );

      return model;
    } 
    catch (e) {
      SnackBar(content:Text("Model Error"));
    }
  }

  structuredPrompt(String userPrompt) {
    final userMessage = ChatMessage(
      user: ChatUser(id: user?.uid ?? '', firstName: user?.email ?? 'User'),
      text: userPrompt,
      createdAt: DateTime.now(),
    );
    setState(() {
      chatMessages.add(userMessage);
    });
    return chatMessages.map((message) => "${message.user.firstName}: ${message.text}").join('\n');
  }

  get_text_gemini(String prompt) async {
    setState(() {
      isLoading = true;
    });

    try {
      final model = await initializeModel();

      if (model != null) {
        final content = [Content.text(structuredPrompt(prompt))];
        final response = await model.generateContent(content);

        final aiMessage = ChatMessage(
          user: ChatUser(id: 'ai', firstName: 'AI'),
          text: response.text.toString(),
          createdAt: DateTime.now(),
        );

        setState(() {
          chatMessages.add(aiMessage);
          isLoading = false;
        });
      } else {
        final errorMessage = ChatMessage(
          user: ChatUser(id: 'ai', firstName: 'AI'),
          text: "Error: Could not initialize model",
          createdAt: DateTime.now(),
        );

        setState(() {
          chatMessages.add(errorMessage);
          isLoading = false;
        });
      }
    } catch (e) {
      final errorMessage = ChatMessage(
        user: ChatUser(id: 'ai', firstName: 'AI'),
        text: 'Error: ${e.toString()}',
        createdAt: DateTime.now(),
      );

      setState(() {
        chatMessages.add(errorMessage);
        isLoading = false;
      });
    }
  }

  saveResponse() async {
    if (user != null && promptController.text.isNotEmpty && chatMessages.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('responses').add({
          'email': user!.email,
          'prompt': promptController.text,
          'response': chatMessages.map((message) => message.text).join('\n'),
          'timestamp': Timestamp.now(),
        });
        Get.snackbar("Success", "Response saved successfully.");
      } catch (e) {
        Get.snackbar("Error", e.toString());
      }
    } else {
      Get.snackbar("Error", "Prompt or response is empty.");
    }
  }

  @override
  void initState() {
    if (chatMessages.length == 1) {
      try {
        super.initState();
        initializeModel();
        final initialPrompt = chatMessages[0].text;
        final finalPrompt = "I wanna buy $initialPrompt. Give a personalized financial advice so that I can decide whether I can buy it or not.";
        get_text_gemini(finalPrompt);
        print("\n*10");
        print(finalPrompt);
      } catch (e) {
        Get.snackbar("Error", e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
                child: SizedBox(
                  child:_widgetOptions.elementAt(_selectedIndex),
                ),
              ),
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (user != null)
                Text(
                  'User: ${user!.email}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              SizedBox(height: 20),
              // Text(
              //   'What you gonna Buy?',
              //   style: TextStyle(fontSize: 16, color: Colors.white),
              // ),
              // SizedBox(height: 20),
              SizedBox(height: 20),
              if (isLoading)
                CircularProgressIndicator()
              else
                SizedBox(
                  height: 200,
                  child: DashChat(
                    currentUser: ChatUser(id: user?.uid ?? ''),
                    messages: chatMessages.reversed.toList(),
                    messageOptions: MessageOptions(
                      currentUserContainerColor:Color.fromARGB(210, 5, 242, 155),
                      currentUserTextColor: Colors.white,
                      containerColor: Color(0xFF333333),
                      textColor: Colors.white,
                    ),
                    onSend: (ChatMessage message) {
                      get_text_gemini(message.text);
                    },
                    inputOptions: InputOptions(
                      inputDecoration: InputDecoration(
                        hintText: "Type your message here...",
                        filled: true,
                        fillColor: Color(0xFF2C2C2C),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),

     bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_4),
            label: 'AI Assistant',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_alert_sharp),
            label: 'Remainder',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(210, 5, 242, 155),
        onTap: _onItemTapped,
     ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => signout(),
        child: Icon(Icons.logout),
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Color(0xFF1C1C1C),
    );
  }
}
