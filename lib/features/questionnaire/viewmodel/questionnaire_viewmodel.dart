import 'dart:io';
import 'package:flutter/material.dart';
import '../models/questionnaire_model.dart';

class QuestionnaireViewModel extends ChangeNotifier {
  QuestionnaireData _questionnaireData = QuestionnaireData.defaultData;

  // Getters
  QuestionnaireData get questionnaireData => _questionnaireData;
  Question get currentQuestion => _questionnaireData.currentQuestion;
  int get currentQuestionIndex => _questionnaireData.currentQuestionIndex;
  int get totalQuestions => _questionnaireData.totalQuestions;
  double get progress => _questionnaireData.progress;
  bool get isLastQuestion => _questionnaireData.isLastQuestion;
  bool get isLoading => _questionnaireData.isLoading;
  bool get isCompleted => _questionnaireData.isCompleted;
  bool get canGoNext => _questionnaireData.canGoNext;
  bool get canGoPrevious => _questionnaireData.canGoPrevious;

  // Navigation methods
  void nextQuestion() {
    if (!canGoNext) return;

    if (isLastQuestion) {
      _completeQuestionnaire();
    } else {
      _questionnaireData = _questionnaireData.copyWith(
        currentQuestionIndex: currentQuestionIndex + 1,
      );
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (!canGoPrevious) return;

    _questionnaireData = _questionnaireData.copyWith(
      currentQuestionIndex: currentQuestionIndex - 1,
    );
    notifyListeners();
  }

  void goToQuestion(int questionIndex) {
    if (questionIndex < 0 || questionIndex >= totalQuestions) return;

    _questionnaireData = _questionnaireData.copyWith(
      currentQuestionIndex: questionIndex,
    );
    notifyListeners();
  }

  // Answer methods
  void answerTextQuestion(String value) {
    _updateAnswer(currentQuestion.id, value);
  }

  void answerNumberQuestion(int value) {
    _updateAnswer(currentQuestion.id, value);
  }

  void answerDateQuestion(DateTime value) {
    _updateAnswer(currentQuestion.id, value.toIso8601String());
  }

  void answerPhotoQuestion(File photoFile) {
    _updateAnswer(currentQuestion.id, null, photoFile: photoFile);
  }

  void answerMultipleChoiceQuestion(List<String> selectedOptions) {
    _updateAnswer(currentQuestion.id, selectedOptions);
  }

  void answerSingleChoiceQuestion(String selectedOption) {
    _updateAnswer(currentQuestion.id, selectedOption);
  }

  void _updateAnswer(String questionId, dynamic value, {File? photoFile}) {
    final existingAnswerIndex = _questionnaireData.answers.indexWhere(
      (answer) => answer.questionId == questionId,
    );

    final newAnswer = QuestionAnswer(
      questionId: questionId,
      value: value,
      photoFile: photoFile,
      answeredAt: DateTime.now(),
    );

    List<QuestionAnswer> updatedAnswers = List.from(_questionnaireData.answers);
    
    if (existingAnswerIndex >= 0) {
      updatedAnswers[existingAnswerIndex] = newAnswer;
    } else {
      updatedAnswers.add(newAnswer);
    }

    _questionnaireData = _questionnaireData.copyWith(answers: updatedAnswers);
    notifyListeners();
  }

  // Get answer for current question
  QuestionAnswer? getCurrentAnswer() {
    try {
      return _questionnaireData.answers.firstWhere(
        (answer) => answer.questionId == currentQuestion.id,
      );
    } catch (e) {
      return null;
    }
  }

  // Get answer for specific question
  QuestionAnswer? getAnswerForQuestion(String questionId) {
    try {
      return _questionnaireData.answers.firstWhere(
        (answer) => answer.questionId == questionId,
      );
    } catch (e) {
      return null;
    }
  }

  // Complete questionnaire
  Future<void> _completeQuestionnaire() async {
    _setLoading(true);
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    _questionnaireData = _questionnaireData.copyWith(
      isCompleted: true,
      isLoading: false,
    );
    
    notifyListeners();
  }

  // Reset questionnaire
  void resetQuestionnaire() {
    _questionnaireData = QuestionnaireData.defaultData;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _questionnaireData = _questionnaireData.copyWith(isLoading: loading);
    notifyListeners();
  }

  // Validation methods
  String? validateTextAnswer(String value, Map<String, dynamic>? validation) {
    if (value.isEmpty) return 'This field is required';
    
    if (validation != null) {
      final minLength = validation['minLength'] as int?;
      final maxLength = validation['maxLength'] as int?;
      
      if (minLength != null && value.length < minLength) {
        return 'Minimum ${minLength} characters required';
      }
      
      if (maxLength != null && value.length > maxLength) {
        return 'Maximum ${maxLength} characters allowed';
      }
    }
    
    return null;
  }

  String? validateNumberAnswer(int value, Map<String, dynamic>? validation) {
    if (validation != null) {
      final min = validation['min'] as int?;
      final max = validation['max'] as int?;
      
      if (min != null && value < min) {
        return 'Minimum value is $min';
      }
      
      if (max != null && value > max) {
        return 'Maximum value is $max';
      }
    }
    
    return null;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
