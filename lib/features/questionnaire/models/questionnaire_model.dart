import 'dart:io';
import 'package:flutter/material.dart';

enum QuestionType {
  text,
  number,
  date,
  photo,
  multipleChoice,
  singleChoice,
}

class Question {
  final String id;
  final String title;
  final String? subtitle;
  final QuestionType type;
  final List<String>? options;
  final bool isRequired;
  final String? placeholder;
  final Map<String, dynamic>? validation;

  const Question({
    required this.id,
    required this.title,
    this.subtitle,
    required this.type,
    this.options,
    this.isRequired = true,
    this.placeholder,
    this.validation,
  });
}

class QuestionAnswer {
  final String questionId;
  final dynamic value;
  final File? photoFile;
  final DateTime answeredAt;

  const QuestionAnswer({
    required this.questionId,
    required this.value,
    this.photoFile,
    required this.answeredAt,
  });
}

class QuestionnaireData {
  final List<Question> questions;
  final List<QuestionAnswer> answers;
  final int currentQuestionIndex;
  final bool isLoading;
  final bool isCompleted;

  const QuestionnaireData({
    required this.questions,
    required this.answers,
    required this.currentQuestionIndex,
    required this.isLoading,
    required this.isCompleted,
  });

  Question get currentQuestion => questions[currentQuestionIndex];
  int get totalQuestions => questions.length;
  double get progress => (currentQuestionIndex + 1) / totalQuestions;
  bool get isLastQuestion => currentQuestionIndex == totalQuestions - 1;
  bool get canGoNext => _isCurrentQuestionAnswered();
  bool get canGoPrevious => currentQuestionIndex > 0;

  int get answeredCount {
    int count = 0;
    for (final question in questions) {
      final answer = answers.firstWhere(
        (a) => a.questionId == question.id,
        orElse: () => QuestionAnswer(
          questionId: question.id,
          value: null,
          answeredAt: DateTime.now(),
        ),
      );
      if (isQuestionAnswered(question, answer)) {
        count += 1;
      }
    }
    return count;
  }

  double get answeredProgress => totalQuestions == 0 ? 0.0 : answeredCount / totalQuestions;

  // AI Accuracy levels based on answered questions
  String get aiAccuracy {
    if (answeredCount == 0) return 'Low';
    if (answeredCount <= totalQuestions * 0.4) return 'Low';
    if (answeredCount <= totalQuestions * 0.7) return 'Medium';
    return 'Good';
  }

  Color get aiAccuracyColor {
    switch (aiAccuracy) {
      case 'Low':
        return const Color(0xFFFF6B35); // Red/Orange
      case 'Medium':
        return const Color(0xFFFFA726); // Yellow/Orange
      case 'Good':
        return const Color(0xFF4CAF50); // Green
      default:
        return const Color(0xFFFF6B35);
    }
  }

  bool _isCurrentQuestionAnswered() {
    if (currentQuestionIndex >= questions.length) return false;
    final current = questions[currentQuestionIndex];
    final answer = answers.firstWhere(
      (a) => a.questionId == current.id,
      orElse: () => QuestionAnswer(
        questionId: current.id,
        value: null,
        answeredAt: DateTime.now(),
      ),
    );
    return isQuestionAnswered(current, answer);
  }

  bool isQuestionAnswered(Question question, QuestionAnswer answer) {
    switch (question.type) {
      case QuestionType.photo:
        return answer.photoFile != null && (answer.photoFile!.path).isNotEmpty;
      case QuestionType.text:
        return answer.value is String && (answer.value as String).trim().isNotEmpty;
      case QuestionType.number:
        return answer.value != null;
      case QuestionType.date:
        if (answer.value is String) {
          final dt = DateTime.tryParse(answer.value as String);
          if (dt == null) return false;
          // enforce 18+
          final now = DateTime.now();
          int years = now.year - dt.year;
          if (now.month < dt.month || (now.month == dt.month && now.day < dt.day)) {
            years -= 1;
          }
          return years >= 18;
        }
        return false;
      case QuestionType.multipleChoice:
        return answer.value is List && (answer.value as List).isNotEmpty;
      case QuestionType.singleChoice:
        return answer.value != null && answer.value.toString().isNotEmpty;
    }
  }

  QuestionnaireData copyWith({
    List<Question>? questions,
    List<QuestionAnswer>? answers,
    int? currentQuestionIndex,
    bool? isLoading,
    bool? isCompleted,
  }) {
    return QuestionnaireData(
      questions: questions ?? this.questions,
      answers: answers ?? this.answers,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      isLoading: isLoading ?? this.isLoading,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  static QuestionnaireData get defaultData => QuestionnaireData(
    questions: _getDefaultQuestions(),
    answers: [],
    currentQuestionIndex: 0,
    isLoading: false,
    isCompleted: false,
  );

  static List<Question> _getDefaultQuestions() {
    return [
      Question(
        id: 'name',
        title: 'What is your name?',
        subtitle: 'This will be displayed on your profile',
        type: QuestionType.text,
        placeholder: 'Enter your full name',
        validation: {
          'minLength': 2,
          'maxLength': 50,
        },
      ),
      Question(
        id: 'birthdate',
        title: 'What is your birthdate?',
        subtitle: 'We use this to tailor your experience',
        type: QuestionType.date,
        placeholder: 'Select your birthdate',
      ),
      Question(
        id: 'profile_photo',
        title: 'Upload your profile photo',
        type: QuestionType.photo,
      ),
      Question(
        id: 'interests',
        title: 'What are your main interests?',
        subtitle: 'Select all that apply to help us personalize your experience',
        type: QuestionType.multipleChoice,
        options: [
          'Technology',
          'Sports',
          'Music',
          'Art & Design',
          'Travel',
          'Food & Cooking',
          'Fitness',
          'Reading',
          'Gaming',
          'Photography',
        ],
      ),
      Question(
        id: 'experience_level',
        title: 'How would you describe your experience level?',
        subtitle: 'This helps us tailor content to your skill level',
        type: QuestionType.singleChoice,
        options: [
          'Beginner',
          'Intermediate',
          'Advanced',
          'Expert',
        ],
      ),
      Question(
        id: 'goals',
        title: 'What are your main goals?',
        subtitle: 'Tell us what you want to achieve',
        type: QuestionType.text,
        placeholder: 'Describe your goals and aspirations',
        validation: {
          'minLength': 10,
          'maxLength': 500,
        },
      ),
      Question(
        id: 'availability',
        title: 'How much time can you dedicate?',
        subtitle: 'This helps us recommend the right activities',
        type: QuestionType.singleChoice,
        options: [
          'Less than 1 hour per week',
          '1-3 hours per week',
          '3-5 hours per week',
          '5-10 hours per week',
          'More than 10 hours per week',
        ],
      ),
      Question(
        id: 'communication_preference',
        title: 'How do you prefer to communicate?',
        subtitle: 'Choose your preferred communication style',
        type: QuestionType.singleChoice,
        options: [
          'Text messages',
          'Video calls',
          'Voice calls',
          'In-person meetings',
          'Email',
        ],
      ),
    ];
  }
}
