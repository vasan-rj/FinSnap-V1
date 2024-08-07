import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:finsnap/models/custom_chat_quiz_model.dart';
import 'package:finsnap/widgets/chatbot/custom_chat_bubble.dart';
import 'package:flutter/material.dart';



class ChatWidget extends StatelessWidget {
  final ChatUser currentUser;
  final List<CustomChatMessage> customChatMessages;
  final Function(CustomChatMessage) onSend;
  final bool isLoading;
  final ScrollController scrollController;
  // final List<String> options_x;


  ChatWidget({
    required this.currentUser,
    required this.customChatMessages,
    required this.onSend,
    this.isLoading = false, 
    required this.scrollController,
    // required this.options_x,
    
  });

//   @override
//   _ChatWidgetState createState() => _ChatWidgetState();
// }

// class _ChatWidgetState extends State<ChatWidget> {
//   final TextEditingController _controller = TextEditingController();



  @override
 
 Widget build(BuildContext context) {
  
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.physics.maxFlingVelocity,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  



  //   return Column(
  //     children: [
  //       Expanded(
  //         child: DashChat(
  //           currentUser: currentUser,
  //           messages: customChatMessages.map((m) => ChatMessage(
  //             user: m.user,
  //             text: m.message,
  //             createdAt: m.createdAt,
              
  //           )).toList().reversed.toList(),
  //           onSend: (ChatMessage message) {
  //             onSend(
  //               CustomChatMessage(
  //                 user: message.user,
  //                 message: message.text ?? '',
  //                 createdAt: message.createdAt,
                  
  //                 // options: message.options,
                  
  //               ),
  //             );
  //           },
  //         ),
  //       ),
  //       if (isLoading)
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: CircularProgressIndicator(),
  //         ),
  //     ],
  //   );
  // }

  return isLoading
        ? Center(child: CircularProgressIndicator(
          color: const Color.fromARGB(210, 5, 242, 155),
        ))
        : SingleChildScrollView(
          child: Column(
            children: [
              // ElevatedButton(
              //     child:Text("priya"),
              //     onPressed:(){_scrollToBottom();},
              //   ),
              SizedBox(
                  height: 450,
                  child: ListView.builder(
                    
                     controller: scrollController,
                    reverse: false,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    itemCount: customChatMessages.length,
                    itemBuilder: (context, index) {
                      final message = customChatMessages[index];
                      return CustomChatBubble(
                        message: message,
                        onOptionSelected: (option) {
                         
                          final userMessage = CustomChatMessage(
                            user: currentUser,
                            message: option,
                            createdAt: DateTime.now(),
                          );
                          // onSend(userMessage);
                          customChatMessages.add(userMessage);
              
                          onSend(userMessage);
                        },
                      );
                    },
                    
                  ),
              
                ),
                
            ],
          ),
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
