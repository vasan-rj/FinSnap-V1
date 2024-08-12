import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:finsnap/models/custom_chat_quiz_model.dart';
import 'package:finsnap/widgets/chatbot/chat_interface.dart';
import 'package:finsnap/widgets/chatbot/chatbot-sidebar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:get/get.dart';
import 'dart:convert';
// import 'chat_interface.dart';
// import 'chatbot-sidebar.dart';
import 'remainder.dart';
import 'package:finsnap/screens/index.dart';

signout() async {
  try {
    await FirebaseAuth.instance.signOut();
    print("Sign out successful");
    // Navigate to the login screen or update UI
  } catch (e) {
    print("Error signing out: $e");
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 1;
  List<CustomChatMessage> customChatMessages = [];
  final ScrollController _scrollController = ScrollController();
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Page',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    Text('AI Finance Assistant',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    Text('Custom Remainder',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
  ];

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('clicked:::::');
      // _scrollController.jumpTo(_scrollController.position.extentTotal);
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (_selectedIndex == 0) {
        Get.to(() => IndexPage());
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
        systemInstruction: Content.system("""
          You are a Personal Financial Assistant for the user, your goal is to gather relevant financial information from the user to provide personalized financial recommendations and help them achieve their financial goals. 
          Do not make assumptions, ask clarifying questions if not enough information is available, only ask important and relevant questions also do not many question to the user limit the number of question to the user. 
          If you are replying, then follow type 1 response Schema, and if you are asking a question, then follow type 2 response Schema.

          NOTE!: When a User asks about a Topic/Question/Concept give general information about the topic first, and then give 2 option "Give Specific Answer" and "Get General Answer" if user clicks on "Give Specific Answer" ask relevant and detailed questions to the user , follow type 2 response schema for this.
          while responding make sure quote are being correctly closed.

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

          NOTE:  keep the quiz options generated by the model short and crisp for the user.
          """),
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
    // setState(() {
    //   customChatMessages.add(userMessage);
    // });
    return customChatMessages
        .map((userMessage) =>
            "${userMessage.user.firstName}: ${userMessage.message}")
        .join('\n');
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
          options: responseType == 'question'
              ? List<String>.from(responseContent['options'])
              : null,
        );

        print("/n" * 10);
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
    if (user != null &&
        promptController.text.isNotEmpty &&
        customChatMessages.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('responses').add({
          'email': user!.email,
          'prompt': promptController.text,
          'response':
              customChatMessages.map((message) => message.message).join('\n'),
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
    if (customChatMessages.isEmpty) {
      try {
        initializeModel();
        final trigger_msg = CustomChatMessage(
          user: ChatUser(id: 'ai', firstName: 'AI'),
          message:
              'Hey There 👋🏽 This is Finsanp Ai Assistant. How can I help you?',
          createdAt: DateTime.now(),
        );
        setState(() {
          customChatMessages.add(trigger_msg);
          // isLoading = false;
        });
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
            child: Text('AI Finance Assistant',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(210, 5, 242, 155),
                )),
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
            const SizedBox(height: 10),
            // Text(
            //   "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year} ${DateTime.now().hour}:${DateTime.now().minute} ",
            //   style: TextStyle(color: Colors.white),
            // ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ChatWidget(
                      scrollController: _scrollController,
                      currentUser: ChatUser(id: user?.uid ?? ''),
                      customChatMessages: customChatMessages,
                      // onSend: (CustomChatMessage message) {
                      //   // if (message.options == null) {
                      //     get_text_gemini(message.message);
                      //   // }
                      //   // setState(() {
                      //   //   print(message);
                      //   //   customChatMessages.add(message);
                      //   // });
                      // },
                      onSend: (message) {
                        if (message.options == null) {
                          get_text_gemini(message.message);
                        }
                        _scrollToBottom();
                      },
                      isLoading: isLoading,
                    ),
                  ),
                  // const SizedBox(height:2),
                  ElevatedButton(
                    onPressed: () {
                      _scrollToBottom();
                    },
                    child: Icon(
                      Icons.arrow_downward_outlined,
                      color: Color.fromARGB(210, 5, 242, 155),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: promptController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(210, 5, 242, 155),
                                  width: 2.0,
                                ),
                              ),
                              hintText: 'Ask a question...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),

                                // borderSide: BorderSide.none,
                              ),
                              fillColor: const Color(0xFF2C2C2C),
                              filled: true,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          color: const Color.fromARGB(210, 5, 242, 155),
                          onPressed: () {
                            if (promptController.text.isNotEmpty) {
                              final userMessage = CustomChatMessage(
                                user: ChatUser(id: user?.uid ?? ''),
                                message: promptController.text,
                                createdAt: DateTime.now(),
                              );
                              get_text_gemini(promptController.text);
                              setState(() {
                                customChatMessages.add(userMessage);
                                print(customChatMessages);
                              });
                              promptController.clear();
                            }
                          },
                        ),
                      ],
                    ),
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
          BottomNavigationBarItem(
              icon: Icon(Icons.assistant), label: 'AI Assistant'),
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
