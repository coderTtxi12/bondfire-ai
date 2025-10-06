import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/questionnaire_model.dart';
import '../viewmodel/questionnaire_viewmodel.dart';

class SingleChoiceQuestionWidget extends StatefulWidget {
  final Question question;
  final QuestionAnswer? answer;

  const SingleChoiceQuestionWidget({
    super.key,
    required this.question,
    this.answer,
  });

  @override
  State<SingleChoiceQuestionWidget> createState() => _SingleChoiceQuestionWidgetState();
}

class _SingleChoiceQuestionWidgetState extends State<SingleChoiceQuestionWidget> {
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.answer?.value?.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionnaireViewModel>(
      builder: (context, viewModel, child) {
        return Column(
          children: [
            // Options list
            ...widget.question.options!.asMap().entries.map((entry) {
              final index = entry.key;
              final option = entry.value;
              final isSelected = _selectedOption == option;
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GestureDetector(
                  onTap: () => _selectOption(option),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? AppColors.buttonPrimary.withOpacity(0.1)
                          : AppColors.buttonSecondary,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected 
                            ? AppColors.buttonPrimary
                            : AppColors.buttonSecondary,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Radio button
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? AppColors.buttonPrimary
                                : Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected 
                                  ? AppColors.buttonPrimary
                                  : AppColors.textSecondary,
                              width: 2,
                            ),
                          ),
                          child: isSelected
                              ? const Icon(
                                  Icons.check,
                                  color: AppColors.textPrimary,
                                  size: 16,
                                )
                              : null,
                        ),
                        const SizedBox(width: 16),
                        
                        // Option text
                        Expanded(
                          child: Text(
                            option,
                            style: AppTextStyles.bodyLarge.copyWith(
                              color: isSelected 
                                  ? AppColors.textPrimary
                                  : AppColors.textSecondary,
                              fontWeight: isSelected 
                                  ? FontWeight.w500
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
            
            // Selection indicator
            if (_selectedOption != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.buttonPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: AppColors.buttonPrimary,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Selected: $_selectedOption',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.buttonPrimary,
                        fontWeight: FontWeight.w600,
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

  void _selectOption(String option) {
    setState(() {
      _selectedOption = option;
    });
    
    // Save to view model
    final viewModel = Provider.of<QuestionnaireViewModel>(context, listen: false);
    viewModel.answerSingleChoiceQuestion(option);
  }
}
