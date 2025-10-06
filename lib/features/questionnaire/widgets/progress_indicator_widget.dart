import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final double progress;
  final int currentQuestion;
  final int totalQuestions;
  final double? answeredProgress;
  final String? aiAccuracy;
  final Color? aiAccuracyColor;

  const ProgressIndicatorWidget({
    super.key,
    required this.progress,
    required this.currentQuestion,
    required this.totalQuestions,
    this.answeredProgress,
    this.aiAccuracy,
    this.aiAccuracyColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Progress text and AI Accuracy
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Question $currentQuestion of $totalQuestions',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            Row(
              children: [
                // AI Accuracy indicator
                if (aiAccuracy != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: aiAccuracyColor?.withOpacity(0.2) ?? AppColors.buttonSecondary,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: aiAccuracyColor ?? AppColors.textSecondary,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.psychology,
                          size: 14,
                          color: aiAccuracyColor ?? AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'AI Accuracy: $aiAccuracy',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: aiAccuracyColor ?? AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                // Progress percentage
                Text(
                  '${(((answeredProgress ?? progress) * 100).clamp(0, 100)).round()}%',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Progress bar
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: AppColors.buttonSecondary,
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: (answeredProgress ?? progress).clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: AppColors.buttonGradient,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
