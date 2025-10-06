import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/questionnaire_model.dart';
import '../viewmodel/questionnaire_viewmodel.dart';

class MultipleChoiceQuestionWidget extends StatefulWidget {
  final Question question;
  final QuestionAnswer? answer;

  const MultipleChoiceQuestionWidget({
    super.key,
    required this.question,
    this.answer,
  });

  @override
  State<MultipleChoiceQuestionWidget> createState() => _MultipleChoiceQuestionWidgetState();
}

class _MultipleChoiceQuestionWidgetState extends State<MultipleChoiceQuestionWidget> {
  List<String> _selectedOptions = [];

  @override
  void initState() {
    super.initState();
    _selectedOptions = List<String>.from(widget.answer?.value ?? []);
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
              final isSelected = _selectedOptions.contains(option);
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GestureDetector(
                  onTap: () => _toggleOption(option),
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
                        // Checkbox
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? AppColors.buttonPrimary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
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
            
            // Selection count
            if (_selectedOptions.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.buttonPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_selectedOptions.length} selected',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.buttonPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  void _toggleOption(String option) {
    setState(() {
      if (_selectedOptions.contains(option)) {
        _selectedOptions.remove(option);
      } else {
        _selectedOptions.add(option);
      }
    });
    
    // Save to view model
    final viewModel = Provider.of<QuestionnaireViewModel>(context, listen: false);
    viewModel.answerMultipleChoiceQuestion(_selectedOptions);
  }
}
