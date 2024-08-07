import 'package:finsnap/data/health_score_quiz_question.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HealthScorePage extends StatefulWidget {
  const HealthScorePage({super.key});

  @override
  State<HealthScorePage> createState() => _HealthScorePageState();
}

class _HealthScorePageState extends State<HealthScorePage> {

  int currentQuestionIndex = 0;
  Map<String, String> userResponses = {};

  void _onOptionSelected(String option, String questions) {
    setState(() {
     
      userResponses[questions] = option;
      print(userResponses);
      if (currentQuestionIndex < quizQuestions.length - 1) {
        currentQuestionIndex++;
      } else {
        // All questions answered
        _calculateFinancialHealthScore();
      }
    });
  }

  void _showResults(String score, String recommendations) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Financial Health Score"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Score: $score"),
            SizedBox(height: 8.0),
            Text("Recommendations: $recommendations"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

// 
// API_KEY="YOUR_API_KEY"
// curl -H 'Content-Type: application/json' \
//      -d '{"contents":[
//             {"role": "user",
//               "parts":[{"text": "Give me five subcategories of jazz?"}]}]}' \
//      "https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent?key=${API_KEY}"

// 
  Future<void> _calculateFinancialHealthScore() async {
    final String apiUrl = 'AIzaSyDjVaxhs3Ct5uf0flzyM2jfU2xlaBlCu1o';
    final Map<String, dynamic> requestData = {
      "responses": userResponses,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer YOUR_GEMINI_API_KEY',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      final String financialHealthScore = responseBody["score"];
      final String recommendations = responseBody["recommendations"];
      _showResults(financialHealthScore, recommendations);
    } 
    else 
    {
      // Handle error
    }

  }
  @override
  Widget build(BuildContext context) {
     final currentQuestion = quizQuestions[currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: SizedBox(
            child: Text('AI Finance Assistant',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: const Color.fromARGB(210, 5, 242, 155),)),
          ),
        ),
        backgroundColor: Colors.black87,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentQuestion["question"],
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            ...currentQuestion["options"].map<Widget>((option) {
              return ListTile(
                title: Text(option),
                onTap: () => _onOptionSelected(option, currentQuestion["question"]),
              );
            }).toList(),
          ],
        ),
      ),
    );

 
  }
}

// final List<Map<String, dynamic>> quizQuestions = [
//   {
//     "question": "How much do you spend on non-essential items each month?",
//     "options": ["< 100", "100 - 500", "500 - 1000", "> 1000"]
//   },
//   {
//     "question": "What percentage of your income do you save?",
//     "options": ["< 10%", "10% - 20%", "20% - 30%", "> 30%"]
//   },
  // Add more questions as needed

