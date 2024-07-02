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

// import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final user = FirebaseAuth.instance.currentUser;

  final apiKey = 'AIzaSyDwnp3gloCT8FmIUXxRxMdNsc57Fw3mxI8';
  TextEditingController promptController = TextEditingController();
  String generatedText = '';
  bool isLoading = false;

  signout() async {
    await FirebaseAuth.instance.signOut();
  }

  get_text_gemini(String prompt) async {
    setState(() {
      isLoading = true;
    });

    try {
     

      final model = GenerativeModel(
        model: 'gemini-1.5-pro',
        apiKey: apiKey,
        generationConfig: GenerationConfig(
            temperature: 0.7,
            responseMimeType: "application/json",
            topP: 0.85,
            topK: 20,
            maxOutputTokens: 250),
        systemInstruction: Content.system(
            "You are a Personal Financial Assistant for the user, your goal is to gather relevant financial information from the user to provide personalized financial recommendationsand help them achieve their financial goals Do not make assumptions,Ask clarifying questions if not enough information is available , give answer in json"
      ));

      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      setState(() {
        generatedText = response.text.toString();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        generatedText = 'Error: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  saveResponse() async {
    if (user != null &&
        promptController.text.isNotEmpty &&
        generatedText.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('doc1').add({
          'email': user!.email,
          'prompt': promptController.text,
          'response': generatedText,
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
    super.initState();
    get_text_gemini('hi'); // Initial prompt
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homepage"),
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
                  style: TextStyle(fontSize: 16),
                ),
              SizedBox(height: 20),
              Text(
                'What you gonna Buy?',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              TextField(
                controller: promptController,
                decoration: InputDecoration(
                  hintText: "Examples: Cars,House,Stocks etc.. ",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(23, 255, 255, 255),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => get_text_gemini(promptController.text),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(210, 5, 242, 155),
                        Color.fromARGB(255, 4, 140, 126)
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints(minHeight: 50),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () => saveResponse(),
              //   style: ElevatedButton.styleFrom(
              //     padding: EdgeInsets.zero,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ),
              //   child: Ink(
              //     decoration: BoxDecoration(
              //       gradient: LinearGradient(
              //         colors: [
              //           Color.fromARGB(210, 5, 242, 155),
              //           Color.fromARGB(255, 4, 140, 126)
              //         ],
              //         begin: Alignment.centerLeft,
              //         end: Alignment.centerRight,
              //       ),
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: Container(
              //       alignment: Alignment.center,
              //       constraints: BoxConstraints(minHeight: 50),
              //       padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              //       child: Text(
              //         "Save Response",
              //         style: TextStyle(
              //           fontSize: 18,
              //           fontWeight: FontWeight.bold,
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              SizedBox(height: 20),
              if (isLoading)
                CircularProgressIndicator()
              else
                Text(
                  'Generated Content:\n$generatedText',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => signout(),
        child: Icon(Icons.logout),
      ),
    );
  }
}
