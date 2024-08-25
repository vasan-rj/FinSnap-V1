import 'package:flutter/material.dart';
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
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          decoration: BoxDecoration(
            color: message.user.id == 'ai' ? const Color.fromARGB(239, 66, 66, 66) : const Color.fromARGB(210, 5, 242, 155) ,
            // borderRadius: BorderRadius.circular(10),
             borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: message.user.id == 'ai' ? Radius.circular(0) : Radius.circular(12),
              bottomRight: message.user.id == 'ai' ? Radius.circular(12) : Radius.circular(0),
            ),

          ),
          child: Text(
            message.message,
            style: TextStyle(color: Colors.white,fontSize: 15),
            // textAlign: TextAlign.left,
          ),
        ),
        if (message.options != null)
        Wrap(
          spacing: 8.0,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: message.options!.map((option) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 2,vertical: 3.5),
                child: ElevatedButton(
                  onPressed: () => onOptionSelected(option),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(110, 66, 66, 66),
                    foregroundColor: Color.fromARGB(210, 5, 242, 155),
                    textStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(option),
                ),
              );
            }).toList(),
          ),
          
      ],
    );
  }
}
