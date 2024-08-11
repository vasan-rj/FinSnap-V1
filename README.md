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

## 🛠️ Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) installed on your local machine.
- A valid Google Gemini API key.

### Installation

1. **Clone the repository:**

    ```bash
    git clone https://github.com/yourusername/finsnap.git
    cd finsnap
    ```

2. **Install dependencies:**

    ```bash
    flutter pub get
    ```

3. **Configure the API Key:**

    Replace the placeholder in the `initializeModel()` function with your actual Google Gemini API key.

    ```dart
    final apiKey = 'YOUR_GOOGLE_GEMINI_API_KEY';
    ```

4. **Run the app:**

    ```bash
    flutter run
    ```

## 📱 App Screenshots

| Home Screen | Quiz Screen | Result Screen |
|-------------|-------------|---------------|
| ![Home Screen](link-to-home-screenshot) | ![Quiz Screen](link-to-quiz-screenshot) | ![Result Screen](link-to-result-screenshot) | <!-- Replace with actual screenshots -->

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

## 👥 Contributors

- **Your Name** - [@yourusername](https://github.com/yourusername)

## 📧 Contact

For any inquiries or support, please reach out via [email@domain.com](mailto:email@domain.com).

---

<p align="center">
  Made with ❤️ using <strong>Flutter</strong>
</p>
