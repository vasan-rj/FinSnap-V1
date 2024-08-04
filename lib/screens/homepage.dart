
// // , how to i render the ui from the response on ai and the user prompt in the screen

import 'dart:convert';

import 'package:finsnap/models/custom_chat_quiz_model.dart';
import 'package:finsnap/widgets/chat_interface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:finsnap/screens/remainder.dart';
import 'package:finsnap/widgets/chatbot-sidebar.dart';
import 'package:finsnap/models/custom_chat_quiz_model.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // bottom app navigation bar
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
          responseMimeType: 'application/json'
        
          // responseSchema:
        

        ),
        systemInstruction: Content.system(
          """
          You are a Personal Financial Assistant for the user, your goal is to gather relevant financial information from the user to provide personalized financial recommendations and help them achieve their financial goals. 
          Do not make assumptions, ask clarifying questions if not enough information is available , only ask important and relavent and important questions. 
          if you are replying then follow type 1 response Schema , and if you are asking question then follow type 2 response Schema.
          
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

        // '''
        // you are a personal cooking assistant who knows to cook international cuisine , you need to assist the user with cooking skills
        // '''
        ),
      );

      return model;
    } 
    catch (e) {
      const SnackBar(content:Text("Model Error"));
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

        // Parsed response from AI
       final parsedResponse = jsonDecode(response.text.toString());
        final responseType = parsedResponse['type'];
        final responseContent = parsedResponse['content'];

        final aiMessage = CustomChatMessage(
          user: ChatUser(id: 'ai', firstName: 'AI'),
          message: responseContent['message'],
          createdAt: DateTime.now(),
          options: responseType == 'question' ? List<String>.from(responseContent['options']) : null,
        );

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
    if (customChatMessages.length == 1) {
      try {
        super.initState();
        initializeModel();
        final initialPrompt = customChatMessages[0].message;
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

      // SideBar
      drawer: AppDrawer(),
      // SideBar

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (user != null)
                Text(
                  'User: ${user!.email}',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              const SizedBox(height: 20),
              
              // Text(
              //   'What you gonna Buy?',
              //   style: TextStyle(fontSize: 16, color: Colors.white),
              // ),
              Expanded(
                child: ChatWidget(
                   currentUser: ChatUser(id: user?.uid ?? ''),
                  customChatMessages: customChatMessages,
                  onSend: (message) {
                    if (message.options == null) {
                      get_text_gemini(message.message);
                    }
                    setState(() {
                      customChatMessages.add(message);
                    });
                  },
                  isLoading: isLoading,
                  
                ),
              )

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

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => signout(),
      //   child: Icon(Icons.logout),
      //   backgroundColor: Colors.black87,
      // ),

      backgroundColor: const Color(0xFF1C1C1C),
    );
  }
}


