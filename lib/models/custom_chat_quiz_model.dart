// // chat_quiz_model.dart

// import 'package:dash_chat_2/dash_chat_2.dart';


// class ChatMessage extends dash_chat.ChatMessage {
//   final List<String>? quizOptions;

//   ChatMessage({
//     required ChatUser user,
//     required String text,
//     DateTime? createdAt,
//     this.quizOptions,
//   }) : super(user: user, text: text, createdAt: createdAt ?? DateTime.now());
// }

import 'package:dash_chat_2/dash_chat_2.dart';

class CustomChatMessage {
   final ChatUser user;
  final String message;
  final DateTime createdAt;
  final List<String>? options; 

  CustomChatMessage({
     required this.user,
    required this.message,
    required this.createdAt,
    this.options,
  });
}


