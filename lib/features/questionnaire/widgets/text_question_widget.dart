import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/questionnaire_model.dart';
import '../viewmodel/questionnaire_viewmodel.dart';

class TextQuestionWidget extends StatefulWidget {
  final Question question;
  final QuestionAnswer? answer;

  const TextQuestionWidget({
    super.key,
    required this.question,
    this.answer,
  });

  @override
  State<TextQuestionWidget> createState() => _TextQuestionWidgetState();
}

class _TextQuestionWidgetState extends State<TextQuestionWidget> {
  late TextEditingController _controller;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.answer?.value?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionnaireViewModel>(
      builder: (context, viewModel, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text input field
            TextField(
              controller: _controller,
              style: AppTextStyles.bodyLarge,
              maxLines: widget.question.id == 'goals' ? 5 : 1,
              decoration: InputDecoration(
                hintText: widget.question.placeholder ?? 'Enter your answer',
                hintStyle: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
                filled: true,
                fillColor: AppColors.buttonSecondary,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.buttonPrimary,
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _errorText = null;
                });
                
                // Validate and save answer
                final error = viewModel.validateTextAnswer(
                  value,
                  widget.question.validation,
                );
                
                if (error == null) {
                  viewModel.answerTextQuestion(value);
                } else {
                  setState(() {
                    _errorText = error;
                  });
                }
              },
            ),
            
            // Error text
            if (_errorText != null) ...[
              const SizedBox(height: 8),
              Text(
                _errorText!,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.red,
                ),
              ),
            ],
            
            // Character count for goals question
            if (widget.question.id == 'goals' && widget.question.validation != null) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${_controller.text.length}/${widget.question.validation!['maxLength']}',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
