import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:finsnap/models/custom_chat_quiz_model.dart';

// import '../models/custom_chat_model.dart';


class CustomChatBubble extends StatelessWidget {
  final CustomChatMessage message;
  final Function(String) onOptionSelected;

  const CustomChatBubble({
    Key? key,
    required this.message,
    required this.onOptionSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: message.user.id == 'ai' ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: message.user.id == 'ai' ? Colors.grey[800] : Colors.green[600],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            message.message,
            style: TextStyle(color: Colors.white),
          ),
        ),
        if (message.options != null)
          Wrap(
            spacing: 8.0,
            children: message.options!.map((option) {
              return ElevatedButton(
                onPressed: () => onOptionSelected(option),
                child: Text(option),
              );
            }).toList(),
          ),
      ],
    );
  }
}
