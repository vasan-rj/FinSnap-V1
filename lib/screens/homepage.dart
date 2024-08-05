import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:finsnap/models/custom_chat_quiz_model.dart';
import 'package:finsnap/widgets/chat_interface.dart';
import 'package:finsnap/widgets/chatbot-sidebar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:get/get.dart';
import 'dart:convert';
// import 'chat_interface.dart';
// import 'chatbot-sidebar.dart';
import 'remainder.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;
  List<CustomChatMessage> customChatMessages = [];
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    Text('AI Finance Assistant', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    Text('Custom Remainder', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (_selectedIndex == 0) {
        Get.to(() => const Homepage());
      } else if (_selectedIndex == 1) {
        Get.to(() => const Homepage());
      } else if (_selectedIndex == 2) {
        Get.to(() => const RemainderPage());
      }
    });
  }

  final user = FirebaseAuth.instance.currentUser;
  final apiKey = 'AIzaSyDdKgK8wpfxgAeHnOgpjSV_5VC5nBCP_rU';
  TextEditingController promptController = TextEditingController();
  bool isLoading = false;

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
          responseMimeType: 'application/json',
        ),
        systemInstruction: Content.system(
          """
          You are a Personal Financial Assistant for the user, your goal is to gather relevant financial information from the user to provide personalized financial recommendations and help them achieve their financial goals. 
          Do not make assumptions, ask clarifying questions if not enough information is available, only ask important and relevant questions. 
          If you are replying, then follow type 1 response Schema, and if you are asking a question, then follow type 2 response Schema.

          type 1 response schema:

              {
                type: "reply",
                content: {
                  "message": <your reply here>
              }

          type 2 response schema:

              {
                type: "question",
                content: {
                  "message": <your question here>,
                  "options": [
                    <option 1>,
                    <option 2>,
                    <option 3>,
                    etc...
                  ]
                }
              }
          """
        ),
      );

      return model;
    } catch (e) {
      const SnackBar(content: Text("Model Error"));
    }
  }

  structuredPrompt(String userPrompt) {
    final userMessage = CustomChatMessage(
      user: ChatUser(id: user?.uid ?? '', firstName: user?.email ?? 'User'),
      message: userPrompt,
      createdAt: DateTime.now(),
    );
    setState(() {
      customChatMessages.add(userMessage);
    });
    return customChatMessages.map((userMessage) => "${userMessage.user.firstName}: ${userMessage.message}").join('\n');
  }

  Future<void> get_text_gemini(String prompt) async {
    setState(() {
      isLoading = true;
    });

    try {
      final model = await initializeModel();

      if (model != null) {
        final content = [Content.text(structuredPrompt(prompt))];
        final response = await model.generateContent(content);

        final parsedResponse = jsonDecode(response.text.toString());
        final responseType = parsedResponse['type'];
        final responseContent = parsedResponse['content'];

        final aiMessage = CustomChatMessage(
          user: ChatUser(id: 'ai', firstName: 'AI'),
          message: responseContent['message'],
          createdAt: DateTime.now(),
          options: responseType == 'question' ? List<String>.from(responseContent['options']) : null,
          
        );

        print("/n"*10);
        print(parsedResponse);
        print(aiMessage.message);
        print(aiMessage.options);
        setState(() {
          customChatMessages.add(aiMessage);
          isLoading = false;
        });
      } else {
        final errorMessage = CustomChatMessage(
          user: ChatUser(id: 'ai', firstName: 'AI'),
          message: "Error: Could not initialize model",
          createdAt: DateTime.now(),
        );

        setState(() {
          customChatMessages.add(errorMessage);
          isLoading = false;
        });
      }
    } catch (e) {
      final errorMessage = CustomChatMessage(
        user: ChatUser(id: 'ai', firstName: 'AI'),
        message: 'Error: ${e.toString()}',
        createdAt: DateTime.now(),
      );

      setState(() {
        customChatMessages.add(errorMessage);
        isLoading = false;
      });
    }
  }

  saveResponse() async {
    if (user != null && promptController.text.isNotEmpty && customChatMessages.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('responses').add({
          'email': user!.email,
          'prompt': promptController.text,
          'response': customChatMessages.map((message) => message.message).join('\n'),
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

  // @override
  // void initState() {
  //   super.initState();
  //   if (customChatMessages.isNotEmpty) {
  //     try {
  //       initializeModel();
  //       final initialPrompt = customChatMessages[0].message;
  //       final finalPrompt = "I wanna buy $initialPrompt. Give personalized financial advice so that I can decide whether I can buy it or not.";
  //       get_text_gemini(finalPrompt);
  //     } catch (e) {
  //       Get.snackbar("Error", e.toString());
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: SizedBox(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ),
        backgroundColor: Colors.black87,
      ),
      drawer: AppDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            if (user != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'User: ${user!.email}',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ChatWidget(
                      currentUser: ChatUser(id: user?.uid ?? ''),
                      customChatMessages: customChatMessages,
                      onSend: (CustomChatMessage message) {
                        // if (message.options == null) {
                          get_text_gemini(message.message);
                        // }
                        // setState(() {
                        //   print(message);
                        //   customChatMessages.add(message);
                        // });
                      },
                      isLoading: isLoading,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    // child: Row(
                    //   children: [
                    //     Expanded(
                    //       child: TextField(
                    //         controller: promptController,
                    //         decoration: InputDecoration(
                    //           hintText: 'Ask a question...',
                    //           border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(10.0),
                    //           ),
                    //           fillColor: Colors.white,
                    //           filled: true,
                    //         ),
                    //       ),
                    //     ),
                    //     IconButton(
                    //       icon: const Icon(Icons.send),
                    //       onPressed: () {
                    //         if (promptController.text.isNotEmpty) {
                    //           final userMessage = CustomChatMessage(
                    //             user: ChatUser(id: user?.uid ?? ''),
                    //             message: promptController.text,
                    //             createdAt: DateTime.now(),
                    //           );
                    //           get_text_gemini(promptController.text);
                    //           setState(() {
                    //             customChatMessages.add(userMessage);
                    //           });
                    //           promptController.clear();
                    //         }
                    //       },
                    //     ),
                    //   ],
                    // ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.assistant), label: 'AI Assistant'),
          BottomNavigationBarItem(icon: Icon(Icons.alarm), label: 'Remainder'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.black87,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
