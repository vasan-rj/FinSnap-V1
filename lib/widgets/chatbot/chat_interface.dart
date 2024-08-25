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

  



  
  // }

  return isLoading
        ? Center(child: CircularProgressIndicator(
          color: const Color.fromARGB(210, 5, 242, 155),
        ))
        : SingleChildScrollView(
          child: Column(
            children: [
           
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










