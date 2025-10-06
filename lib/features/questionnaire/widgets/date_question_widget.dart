import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/questionnaire_model.dart';
import '../viewmodel/questionnaire_viewmodel.dart';

class DateQuestionWidget extends StatefulWidget {
  final Question question;
  final QuestionAnswer? answer;

  const DateQuestionWidget({
    super.key,
    required this.question,
    this.answer,
  });

  @override
  State<DateQuestionWidget> createState() => _DateQuestionWidgetState();
}

class _DateQuestionWidgetState extends State<DateQuestionWidget> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.answer?.value is String) {
      try {
        _selectedDate = DateTime.tryParse(widget.answer!.value as String);
      } catch (_) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionnaireViewModel>(
      builder: (context, viewModel, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.buttonSecondary,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.buttonPrimary.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.cake_outlined,
                      color: AppColors.buttonPrimary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? (widget.question.placeholder ?? 'Select your birthdate')
                            : _formatDate(_selectedDate!),
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: _selectedDate == null
                              ? AppColors.textSecondary
                              : AppColors.textPrimary,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.calendar_today,
                      color: AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'You must be at least 18 years old.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickDate() async {
    final DateTime now = DateTime.now();
    final DateTime minDate = DateTime(now.year - 120, now.month, now.day);
    final DateTime maxDate = DateTime(now.year - 18, now.month, now.day);
    DateTime tempSelected = _selectedDate ?? DateTime(now.year - 20, now.month, now.day);

    await showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.primaryDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Text(
                      'Select birthdate',
                      style: AppTextStyles.headlineSmall,
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        // Validate 18+
                        if (!_isAtLeast18(tempSelected)) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(this.context).showSnackBar(
                            const SnackBar(
                              content: Text('You must be at least 18 years old.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }
                        setState(() {
                          _selectedDate = tempSelected;
                        });
                        final viewModel = Provider.of<QuestionnaireViewModel>(this.context, listen: false);
                        viewModel.answerDateQuestion(tempSelected);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Done'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 220,
                child: CupertinoTheme(
                  data: const CupertinoThemeData(
                    brightness: Brightness.dark,
                    primaryColor: AppColors.buttonPrimary,
                  ),
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: tempSelected.isAfter(maxDate) ? maxDate : tempSelected,
                    minimumDate: minDate,
                    maximumDate: maxDate,
                    onDateTimeChanged: (date) {
                      tempSelected = date;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  bool _isAtLeast18(DateTime date) {
    final now = DateTime.now();
    int years = now.year - date.year;
    if (now.month < date.month || (now.month == date.month && now.day < date.day)) {
      years -= 1;
    }
    return years >= 18;
  }
}
