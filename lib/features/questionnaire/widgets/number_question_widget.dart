import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/questionnaire_model.dart';
import '../viewmodel/questionnaire_viewmodel.dart';

class NumberQuestionWidget extends StatefulWidget {
  final Question question;
  final QuestionAnswer? answer;

  const NumberQuestionWidget({
    super.key,
    required this.question,
    this.answer,
  });

  @override
  State<NumberQuestionWidget> createState() => _NumberQuestionWidgetState();
}

class _NumberQuestionWidgetState extends State<NumberQuestionWidget> {
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
            // Number input field
            TextField(
              controller: _controller,
              style: AppTextStyles.bodyLarge,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: widget.question.placeholder ?? 'Enter your age',
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
                suffixIcon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.textSecondary,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _errorText = null;
                });
                
                // Parse number and validate
                final number = int.tryParse(value);
                if (number != null) {
                  final error = viewModel.validateNumberAnswer(
                    number,
                    widget.question.validation,
                  );
                  
                  if (error == null) {
                    viewModel.answerNumberQuestion(number);
                  } else {
                    setState(() {
                      _errorText = error;
                    });
                  }
                } else if (value.isNotEmpty) {
                  setState(() {
                    _errorText = 'Please enter a valid number';
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
            
            // Age range info
            if (widget.question.validation != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.buttonSecondary.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.buttonPrimary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Age range: ${widget.question.validation!['min']} - ${widget.question.validation!['max']} years',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
