<<<<<<< HEAD
# FinSnap: Your AI-Driven Financial Companion

<img src="readme-assets/logo.jpeg" alt="FinSnap Logo" width="100" height="100">


FinSnap is an AI-powered financial app designed to help users understand and optimize their personal finance and investments.

## 🚀 Features

- **Personalized Financial Health Score Predictor and Reccomendation**: Calculate your financial health score based on your spending, savings, investments, and debts also gives Personalized Reccomendation to improve your Finance Health Score.
- **Personalized AI Roadmap generator**: Get personalized AI financial Roadmap based on User's Info and download your Roadmap to PDF 📃.
- **AI-Driven Recommendations**: Receive customized recommendations to improve your financial habits and overall financial health 🧑🏽‍⚕️.
- **Learning Modules**: Learn Financial and investment topics with Finsanp's up-to date Learing Module 👨🏽‍🏫.
- **Custom Notifications**: Stay Alert with your Scheduled Remainder and alerts tailored to your financial interests and goals 🔔.
- **Personalized Chatbots**: Interact with FinSnap's various Custom chatbots like Loan bot ,Tax bot , Credit Bot 🤖.

=======
# FinSnap: Personalized Financial Health App

![FinSnap Logo](link-to-logo-image) <!-- Replace with the actual image link -->

FinSnap is an AI-powered financial health app designed to help users understand and improve their financial well-being. By analyzing spending habits, saving patterns, investments, and debt levels, FinSnap provides a personalized financial health score along with actionable recommendations.

## 🚀 Features

- **Personalized Financial Health Score**: Calculate your financial health score based on your spending, savings, investments, and debts.
- **AI-Driven Recommendations**: Receive customized recommendations to improve your financial habits and overall financial health.
- **Interactive Quiz**: Engage with a series of questions designed to assess various aspects of your financial life.
- **Real-time Analysis**: Get instant feedback after completing the quiz with a detailed breakdown of your financial health score.
- **Secure & Private**: Your financial data is securely processed using the latest encryption standards.

## 🎨 App Theme & Styling

FinSnap features a sleek and modern UI with a dark theme that emphasizes clarity and ease of use. The app uses a consistent color palette for a cohesive look and feel:

- **Primary Color**: #1A1A1A (Dark Gray)
- **Accent Color**: #00FF7F (Green)
- **Text Color**: #FFFFFF (White)
- **Button Color**: #2A9D8F (Teal)
>>>>>>> master

## 🛠️ Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) installed on your local machine.
<<<<<<< HEAD
- Dart SDK
- A valid [Google Gemini API key](https://cloud.google.com/ai/gemini)
=======
- A valid Google Gemini API key.
>>>>>>> master

### Installation

1. **Clone the repository:**

    ```bash
<<<<<<< HEAD
    git clone https://github.com/vasan-rj/FinSnap-V1/tree/master
=======
    git clone https://github.com/yourusername/finsnap.git
>>>>>>> master
    cd finsnap
    ```

2. **Install dependencies:**

<<<<<<< HEAD
    Connect device through android emulator or physical device USB debugging.
    ```bash
    
=======
    ```bash
>>>>>>> master
    flutter pub get
    ```

3. **Configure the API Key:**

<<<<<<< HEAD
    Replace the placeholder in `lib/keys.dart` with your actual Google Gemini API key.
=======
    Replace the placeholder in the `initializeModel()` function with your actual Google Gemini API key.
>>>>>>> master

    ```dart
    final apiKey = 'YOUR_GOOGLE_GEMINI_API_KEY';
    ```

4. **Run the app:**

    ```bash
    flutter run
    ```

## 📱 App Screenshots

<<<<<<< HEAD
<div style="display: flex; flex-direction: row; flex-wrap: wrap; gap: 10px;">
  <div >
    <h3>Home Screen</h3>
    <img src="readme-assets/home_page.jpeg" alt="Home Screen" width="300">
  </div>
  <div >
  </div>
  <div >
    <h3>Finane Health Score</h3>
    <img src="readme-assets/ai_health_score.jpeg" alt="Result Screen" width="300">
  </div>
  <div >
    <h3>Personalized Finance Roadmap</h3>
    <img src="readme-assets/roadmap.jpeg" alt="Finance Health Score Recommendation" width="300">
  </div>
  <div >
    <h3>AI Assistant Screen</h3>
    <img src="readme-assets/chat_bot.jpeg" alt="AI Assistant Screen" width="300">
  </div>
  <div >
    <h3>Custom Reminder Screen</h3>
    <img src="readme-assets/remainder.jpeg" alt="Custom Reminder Screen" width="300">
  </div>
</div>
=======
| Home Screen | Quiz Screen | Result Screen |
|-------------|-------------|---------------|
| ![Home Screen](link-to-home-screenshot) | ![Quiz Screen](link-to-quiz-screenshot) | ![Result Screen](link-to-result-screenshot) | <!-- Replace with actual screenshots -->
>>>>>>> master

## 📖 How It Works

1. **User Interaction**: The user engages with a series of questions in a quiz format.
2. **Data Collection**: The app collects the user's responses and processes them.
3. **API Call**: The collected data is sent to the Google Gemini API.
4. **AI Analysis**: The API analyzes the data and calculates the financial health score.
5. **Results**: The app displays the score and provides actionable recommendations.

## 📚 Documentation

- [Flutter](https://flutter.dev/docs) - Learn more about the framework used.
- [Google Gemini API](https://cloud.google.com/ai/gemini) - Explore the AI capabilities powering FinSnap.

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

<<<<<<< HEAD

## 📧 Contact

For any inquiries or support, please reach out via [contact.finsnap@gmail.com](mailto:contact.finsnap@gmail.com).

## 📁 Project Structure

```
FinSnap/
│
lib
├── ai-model-config
│   ├── health-score-model.dart
│   └── road-map-model.dart
├── data
│   ├── health_score_quiz_question.dart
│   ├── module-one.dart
│   └── roadmap_question.dart
├── functions
│   └── roadmap-pdf.dart
├── models
│   ├── custom_chat_quiz_model.dart
│   └── custom_notification.dart
├── permission
├── screens
├── ai-features
│   ├── ai_credit_bot.dart
│   ├── ai_loan_bot.dart
│   ├── ai_tax_bot.dart
│   ├── health_score.dart
│   └── roadmap-generator.dart
├── appdrawer
│   ├── contact-us.dart
│   └── updates_faq.dart
├── learning-module
│   ├── module1.dart
|----
│   ├── chatbot.dart
│   ├── email-verify.dart
│   ├── fingerprint.dart
│   ├── forgetpassword.dart
│   ├── index.dart
│   ├── login.dart
│   ├── otp-phone-page.dart
│   ├── phone-verify.dart
│   ├── remainder.dart
│   ├── signup.dart
│   ├── testing.dart
│   └── wrapper.dart
├── services
├── utils
└── widgets
|    |__chatbot
|        |__chat_interface.dart
|        |__chatbot-sidebar.dart
|        |__custom_chat_bubble.dart  
|____
│   │
│   ├── main.dart
│   └── app_theme.dart
│
└── README.md
```

## 💡 Gemini Model Configuration

The Gemini model is configured to process financial data and return a personalized financial health score along with recommendations. Here's how it's set up:

```dart
final model = GenerativeModel(
  model: 'gemini-1.5-pro',
  apiKey: apiKey,
  generationConfig: GenerationConfig(
    temperature: 0.7,
    topP: 0.85,
    topK: 20,
    maxOutputTokens: 300,
    responseMimeType: 'application/json',
  ),
  systemInstruction: Content.system("""
    You are a Personalized Financial Health Score Predictor. Your goal is to analyze the user's financial information to provide a personalized financial health score and recommendations.
    ...
  """),
);
```

Here's the updated "Contributing" section with instructions for contributing via a new branch:

---

## 🤝 Contributing

We welcome contributions from the community! To get started, follow these steps:

1. **Clone the repository:**

    ```bash
    git clone https://github.com/vasan-rj/FinSnap-V1.git
    cd FinSnap-V1
    ```

2. **Create a new branch for your changes:**

    ```bash
    git checkout -b your-feature-branch
    ```

3. **Make your changes and commit them:**

    ```bash
    git add .
    git commit -m "Describe your changes here"
    ```

4. **Push your changes to GitHub:**

    ```bash
    git push origin your-feature-branch
    ```

5. **Open a Pull Request:**

    Go to the [GitHub repository](https://github.com/vasan-rj/FinSnap-V1) and open a new Pull Request from your feature branch to the main branch. Provide a description of your changes and why they should be merged.

Thank you for your contributions!

---

Feel free to adjust the instructions based on your preferred workflow or any additional guidelines you might have.


## 🗨️ Acknowledgements

Special thanks to the Google Gemini team for their powerful AI models and to the Flutter community for their support and contributions.


Made with ❤️ using <strong>Flutter, Firebase  & Google Gemini.</strong>
=======
## 👥 Contributors

- **Your Name** - [@yourusername](https://github.com/yourusername)

## 📧 Contact

For any inquiries or support, please reach out via [email@domain.com](mailto:email@domain.com).

---

<p align="center">
  Made with ❤️ using <strong>Flutter</strong>
</p>
>>>>>>> master
