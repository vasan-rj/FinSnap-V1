import 'package:flutter/material.dart';

class UpdateFAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Updates & FAQ',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(210, 5, 242, 155),
          ),
        ),
        backgroundColor: Color.fromARGB(158, 51, 51, 51),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Updates Section
            Text(
              'Latest Updates',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Primary Color
              ),
            ),
            SizedBox(height: 8.0),
            _buildUpdateCard(
              title: 'Version 1.1 Released',
              date: 'August 11, 2024',
              description:
                  'We\'ve added a new Personalized Financial Health Score feature, improved the Finance Roadmap Generator, Learning Modules,and squashed several bugs to enhance your experience.',
            ),
            SizedBox(height: 8.0),
            _buildUpdateCard(
              title: 'Version 1.0 Released',
              date: 'July 20, 2024',
              description:
                  'Major UI overhaul, introduction of the Interactive Chat Interface, Custom Reminders through Push notifications,and integration of the Google Gemini AI model for personalized insights.',
            ),
            SizedBox(height: 24.0),

            // FAQ Section
            Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color:  Colors.white, // Primary Color
              ),
            ),
            SizedBox(height: 30.0),
            _buildFAQItem(
              question: 'How do I get a Google Gemini API key?',
              answer:
                  'You can obtain a Google Gemini API key by signing up for access to the Google Gemini API platform on the official Google Cloud website.',
            ),
            _buildFAQItem(
              question: 'Can I use FinSnap without the AI features?',
              answer:
                  'Yes, you can use FinSnap without AI features, but you will miss out on personalized insights and recommendations.',
            ),
            _buildFAQItem(
              question: 'How do I report a bug?',
              answer:
                  'You can report bugs by opening an issue on our GitHub repository or contacting our support team via email at contact.finsnap@gmail.com.',
            ),
            _buildFAQItem(
              question: 'What is the Financial Health Score?',
              answer:
                  'The Financial Health Score is a metric that evaluates your overall financial well-being based on factors such as spending, saving, investments, and debts. The score ranges from 0 to 100.',
            ),
          
          ],
        ),
      ),
    );
  }

  // Widget for Updates Card
  Widget _buildUpdateCard({
    required String title,
    required String date,
    required String description,
  }) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              date,
              style: TextStyle(
                fontSize: 14,
                color: const Color.fromARGB(113, 158, 158, 158),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromARGB(210, 5, 242, 155),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for FAQ Item
  Widget _buildFAQItem({
    required String question,
    required String answer,
  }) {
    return ExpansionTile(
      title: Text(
        question,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            answer,
            style: TextStyle(
              fontSize: 16,
              color: const Color.fromARGB(210, 5, 242, 155),
            ),
          ),
        ),
      ],
    );
  }
}
