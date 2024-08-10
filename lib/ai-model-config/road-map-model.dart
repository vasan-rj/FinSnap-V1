import 'dart:convert';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:finsnap/models/custom_chat_quiz_model.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

const apiKey = 'AIzaSyDdKgK8wpfxgAeHnOgpjSV_5VC5nBCP_rU';

initializeModel() async {
  try {
    final model = GenerativeModel(
        model: 'gemini-1.5-pro',
        apiKey: apiKey,
        generationConfig: GenerationConfig(
          temperature: 0.7,
          topP: 0.85,
          topK: 20,
          maxOutputTokens: 2000,
          responseMimeType: 'application/json',
        ),
       systemInstruction: Content.system("""
  You are a Personalized Financial Roadmap Generator. Analyze the user's information to provide a structured, clear, and concise personalized financial roadmap. Include related free study materials, such as articles, blog posts, and e-books.

  Follow this response schema to generate the roadmap:

  {
    "type": "Roadmap",
    "goal": "<Roadmap Goal>",
    "totalduration": "<Total Duration>",
    "phases": [
      {
        "phasename": "<Phase Name>",
        "duration": "<Phase Duration>",
        "topics": 
        [
          {
            "topicname": "<Topic Name>",
            "concepts": 
              [
                "<Concept 1>",
                "<Concept 2>",
                "<Concept 3>"
              ]
            
          }
        ]
      }
         {
        "phasename": "<Phase Name>",
        "duration": "<Phase Duration>",
        "topics": [
          .....
        ]        
      },
      {
        "phasename": "<Phase Name>",
        "duration": "<Phase Duration>",
        "topics": [
          .....
        ]
      }
    ],
      "Additional_Resource": 
      [
              "<Resource Name 1>",
              "<Resource Name 2>",
      ],
    "Tip": "<Additional Tips or Advice>",
    "tasks": [
              "<Task 1>",
              "<Task 2>",
            ]
  }

  Guidelines:
  1. Generate a complete roadmap, covering all necessary phases.
  2. Ensure the JSON response is well-formed and complete.
  3. Topics and concepts should be relevant to the roadmap goal.
  4. If the roadmap is too long, summarize some sections but maintain all phases.
""")
    );

    return model;
  } catch (e) {
    // const SnackBar(content: Text("Model Error"));
  }
}


  // ******

   