# 🎯 Flutter Quiz App

A modern, gamified quiz application built with Flutter, featuring animations, progress tracking, and an engaging user interface.

## ✨ Features

### Core Features
- Dynamic quiz questions loaded from API
- Interactive multiple choice answers
- Real-time score tracking
- Performance-based rewards/animations

### Gamification Elements
- Points system (+4 for correct, -1 for incorrect)
- Celebration animations for high scores
- Lives system with 3 chances

## 🛠️ Tech Stack

- **Framework**: Flutter
- **Architecture**: MVVM
- **State Management**: Provider
- **API Integration**: HTTP package
- **Animations**: Lottie, Confetti

## 📁 Project Structure

```
lib/
├── main.dart
├── models/
│   ├── quiz_model.dart
|
├── viewmodels/
|   |──quiz_view_model.dart
|
├── screens/│   
|   ├──splash_screen.dart
│   ├──home_screen.dart
│   ├──quiz_screen.dart
│   └──result_screen.dart
|
├── services/
│   └── api_service.dart
|
assets/
└── animations/
    ├── splash.json
    ├── trophy.json
    └── try-again.json
```

## 🚀 Getting Started
1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/quiz_app.git
   cd quiz_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 💻 Usage

### API Integration

```dart
// Example API service implementation
class ApiService {
  static const String apiUrl = 'https://api.jsonserve.com';
  
  Future<QuizModel> fetchQuiz() async {
    final response = await http.get(Uri.parse('$baseUrl/Uw5CrX'));
    return QuizModel.fromJson(jsonDecode(response.body));
  }
}
```

### State Management

```dart
class QuizViewModel extends ChangeNotifier {
  int _score = 0;
  int _lives = 3;
  
  void answerQuestion(bool isCorrect) {
    if (isCorrect) {
      _score += 4;
    } else {
      _score -= 1;
      _lives--;
    }
    notifyListeners();
  }
}
```

## 🎮 Game Rules

- **Scoring System**
  - Correct Answer: +4 points
  - Incorrect Answer: -1 point
  - Initial Lives: 3

- **Victory Conditions**
  - Score ≥ 5: Success celebration
  - Score < 5: Encouragement animation

## 📱 Screenshots/ScreenRecording
- [Screen record of app](https://drive.google.com/file/d/1EEtnFuk_RJLwYPmJN8x-j8cMHXOAcIFD/view?usp=sharing)
- <img src='https://github.com/dk-a-dev/quiz-app-testline/blob/main/submission/splash.png'>
- <img src='https://github.com/dk-a-dev/quiz-app-testline/blob/main/submission/home.png'>
- <img src='https://github.com/dk-a-dev/quiz-app-testline/blob/main/submission/quiz.png'>
- <img src='https://github.com/dk-a-dev/quiz-app-testline/blob/main/submission/quiz2.png'>
- <img src='https://github.com/dk-a-dev/quiz-app-testline/blob/main/submission/final.png'>
