class QuizModel {
  final int id;
  final String title;
  final String description;
  final List<QuestionModel> questions;
  final int duration;
  final double negativeMarks;
  final double correctAnswerMarks;

  QuizModel({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
    required this.duration,
    required this.negativeMarks,
    required this.correctAnswerMarks,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      questions: (json['questions'] as List? ?? [])
          .map((q) => QuestionModel.fromJson(q))
          .toList(),
      duration: json['duration'] ?? 0,
      negativeMarks: double.parse(json['negative_marks'] ?? '0'),
      correctAnswerMarks: double.parse(json['correct_answer_marks'] ?? '0'),
    );
  }
}

class QuestionModel {
  final int id;
  final String description;
  final List<OptionModel> options;
  final String detailedSolution;

  QuestionModel({
    required this.id,
    required this.description,
    required this.options,
    required this.detailedSolution,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] ?? 0,
      description: json['description'] ?? '',
      options: (json['options'] as List? ?? [])
          .map((o) => OptionModel.fromJson(o))
          .toList(),
      detailedSolution: json['detailed_solution'] ?? '',
    );
  }
}

class OptionModel {
  final int id;
  final String description;
  final bool isCorrect;

  OptionModel({
    required this.id,
    required this.description,
    required this.isCorrect,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json['id'] ?? 0,
      description: json['description'] ?? '',
      isCorrect: json['is_correct'] ?? false,
    );
  }
}