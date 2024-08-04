import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:finsnap/models/custom_chat_quiz_model.dart';
import 'package:finsnap/widgets/custom_chat_bubble.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatefulWidget {
  final ChatUser currentUser;
  final List<CustomChatMessage> customChatMessages;
  final Function(CustomChatMessage) onSend;
  final bool isLoading;

  ChatWidget({
    required this.currentUser,
    required this.customChatMessages,
    required this.onSend,
    this.isLoading = false,
  });

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            reverse: true,
            itemCount: widget.customChatMessages.length,
            itemBuilder: (context, index) {
              final message = widget.customChatMessages[index];
              return CustomChatBubble(
                message: message,
                onOptionSelected: (option) {
                  final userMessage = CustomChatMessage(
                    user: widget.currentUser,
                    message: option,
                    createdAt: DateTime.now(),
                  );
                  widget.onSend(userMessage);
                },
              );
            },
          ),
        ),
        if (widget.isLoading)
          CircularProgressIndicator()
        else
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Type your message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    final userMessage = CustomChatMessage(
                      user: widget.currentUser,
                      message: _controller.text,
                      createdAt: DateTime.now(),
                    );
                    widget.onSend(userMessage);
                    _controller.clear();
                  }
                },
              ),
            ],
          ),
      ],
    );
  }
}














// chat_widget.dart

// import 'package:flutter/material.dart';
// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:finsnap/models/custom_chat_quiz_model.dart';
// import 'package:finsnap/widgets/custom_chat_bubble.dart';

// class ChatWidget extends StatelessWidget {
//   final ChatUser currentUser;
//   final List<CustomChatMessage> customChatMessages;
//   // final List<String>? messageOptions;
//   final Function(CustomChatMessage) onSend;
//   final bool isLoading;

//   ChatWidget({
//     required this.currentUser,
//     required this.customChatMessages,
//     // this.messageOptions,
//     required this.onSend,
//     this.isLoading = false,
//   });

  

//   @override
//   Widget build(BuildContext context) {
//     return isLoading
//         ? const CircularProgressIndicator()

//         : SizedBox(
//            height: 500,
//             child: ListView.builder(
//               reverse: true,
//               itemCount: customChatMessages.length,
//               itemBuilder: (context, index) {
//                 final message = customChatMessages[index];
//                 return CustomChatBubble(
//                   message: message,
//                   onOptionSelected: (option) {
//                     final userMessage = CustomChatMessage(
//                       user: currentUser,
//                       message: option,
//                       createdAt: DateTime.now(),
//                     );
//                     onSend(userMessage);
//                   },
//                 );
//               },
//             ),
//           );
      

// ^ old 


        // : SizedBox(
        //     height: 500,
        //     child: DashChat(
        //       currentUser: currentUser,
        //       messages: chatMessages.reversed.toList(),
        //       messageOptions: const MessageOptions(
        //         currentUserContainerColor: Color.fromARGB(210, 5, 242, 155),
        //         currentUserTextColor: Colors.white,
        //         containerColor: Color(0xFF333333),
        //         textColor: Colors.white,
        //       ),
        //       onSend: (ChatMessage message) {
        //         onSend(message.text);
        //       },
        //       inputOptions: InputOptions(
        //         inputDecoration: InputDecoration(
        //           hintText: "Type your message here...",
        //           filled: true,
        //           fillColor: const Color(0xFF2C2C2C),
        //           border: OutlineInputBorder(
        //             borderRadius: BorderRadius.circular(10),
        //             borderSide: BorderSide.none,
        //           ),
        //           contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        //         ),
        //       ),
        //     ),
        //   );
//   }
// }
