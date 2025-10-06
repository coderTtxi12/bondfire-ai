import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/questionnaire_model.dart';
import '../viewmodel/questionnaire_viewmodel.dart';
import 'text_question_widget.dart';
import 'number_question_widget.dart';
import 'photo_question_widget.dart';
import 'multiple_choice_question_widget.dart';
import 'single_choice_question_widget.dart';
import 'date_question_widget.dart';

class QuestionWidget extends StatelessWidget {
  final Question question;
  final QuestionAnswer? answer;

  const QuestionWidget({
    super.key,
    required this.question,
    this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question title
          Text(
            question.title,
            style: AppTextStyles.headlineSmall,
          ),
          const SizedBox(height: 12),
          
          // Question subtitle
          if (question.subtitle != null) ...[
            Text(
              question.subtitle!,
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 32),
          ],
          
          // Question input based on type
          _buildQuestionInput(context),
        ],
      ),
    );
  }

  Widget _buildQuestionInput(BuildContext context) {
    switch (question.type) {
      case QuestionType.text:
        return TextQuestionWidget(
          question: question,
          answer: answer,
        );
      case QuestionType.number:
        return NumberQuestionWidget(
          question: question,
          answer: answer,
        );
      case QuestionType.date:
        return DateQuestionWidget(
          question: question,
          answer: answer,
        );
      case QuestionType.photo:
        return PhotoQuestionWidget(
          question: question,
          answer: answer,
        );
      case QuestionType.multipleChoice:
        return MultipleChoiceQuestionWidget(
          question: question,
          answer: answer,
        );
      case QuestionType.singleChoice:
        return SingleChoiceQuestionWidget(
          question: question,
          answer: answer,
        );
    }
  }
}
