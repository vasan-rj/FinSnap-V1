import 'dart:convert';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:finsnap/models/custom_chat_quiz_model.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

final apiKey = 'AIzaSyDdKgK8wpfxgAeHnOgpjSV_5VC5nBCP_rU';

initializeModel() async {
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-pro',
        apiKey: apiKey,
        generationConfig: GenerationConfig(
          temperature: 0.7,
          topP: 0.85,
          topK: 20,
          maxOutputTokens: 500,
          responseMimeType: 'application/json',
        ),
        systemInstruction: Content.system("""
          You are a Personalized Financial Health Score Predictor, your goal is to analyze the gathered relevant financial information from the user to provide personalized financial health score and recommendations for user based on the user info. 
          Do not make assumptions, Assign Finance Health Score from 0-100, question from the category has following percentage weights is given below,

          "category-with-weight%" : { 
                User Personal info: 5%
                Income and Employment: 20%
                Savings and Investments: 20%
                Expenses and Budgeting: 15%
                Debt and Liabilities: 15%
                Financial Goals: 10%
                Risk Management and Insurance: 5%
                Financial Knowledge and Behavior: 10%
     
             }
            each category will have it's own set of questions.

          follow type 1 response Schema for reply,
-
          type 1 response schema:

              {
                type: "reply",
                content: {
                  "finance-score": <your overall Finance Score (0-100)>,
                  "category-marks":{
                    "<category 1>" :<mark 1>,
                    "<category 2>" :<mark 2>,
                    "<category 3>" :<mark 3>,
                    .
                    .
                    .
                    "<category n>" :<mark n>,

                  },
                  "recommendation":<your recommendation for user to increase his/her Finance health Score> 
                  
              }
          """),
      );

      return model;
    } catch (e) {
      // const SnackBar(content: Text("Model Error"));
    }
  }


  // ******

   