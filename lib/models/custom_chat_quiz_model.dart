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


