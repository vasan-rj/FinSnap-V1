import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dash_chat_2/dash_chat_2.dart';


class chatBot extends StatefulWidget {
  const chatBot({super.key});

  @override
  State<chatBot> createState() => _chatBotState();
}

class _chatBotState extends State<chatBot> {
  final user = FirebaseAuth.instance.currentUser;
  final me=ChatUser(id: '1',firstName:'Me');
  final bot=ChatUser(id: '2',firstName: 'FinSnap');
  final apiKey = 'AIzaSyDwnp3gloCT8FmIUXxRxMdNsc57Fw3mxI8';
  List<ChatMessage> allMessages = [];
  TextEditingController promptController = TextEditingController();
  bool isLoading = false;
  List<Map<String, String>> chatMessages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DashChat(
        currentUser:me, 
        onSend: (ChatMessage m){

      },
       messages: allMessages),
    );
  }
}