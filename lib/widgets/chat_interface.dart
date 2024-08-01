// chat_widget.dart

import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class ChatWidget extends StatelessWidget {
  final ChatUser currentUser;
  final List<ChatMessage> chatMessages;
  // final List<String>? messageOptions;
  final Function(String) onSend;
  final bool isLoading;

  ChatWidget({
    required this.currentUser,
    required this.chatMessages,
    // this.messageOptions,
    required this.onSend,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : SizedBox(
            height: 500,
            child: DashChat(
              currentUser: currentUser,
              messages: chatMessages.reversed.toList(),
              messageOptions: const MessageOptions(
                currentUserContainerColor: Color.fromARGB(210, 5, 242, 155),
                currentUserTextColor: Colors.white,
                containerColor: Color(0xFF333333),
                textColor: Colors.white,
              ),
              onSend: (ChatMessage message) {
                onSend(message.text);
              },
              inputOptions: InputOptions(
                inputDecoration: InputDecoration(
                  hintText: "Type your message here...",
                  filled: true,
                  fillColor: const Color(0xFF2C2C2C),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                ),
              ),
            ),
          );
  }
}
