import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class QuestionnaireNavigationWidget extends StatelessWidget {
  final bool canGoNext;
  final bool canGoPrevious;
  final bool isLastQuestion;
  final bool isLoading;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const QuestionnaireNavigationWidget({
    super.key,
    required this.canGoNext,
    required this.canGoPrevious,
    required this.isLastQuestion,
    required this.isLoading,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Previous button
        if (canGoPrevious) ...[
          Expanded(
            child: OutlinedButton(
              onPressed: isLoading ? null : onPrevious,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textPrimary,
                side: const BorderSide(color: AppColors.textSecondary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.arrow_back, size: 20),
                  SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      'Previous',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
        
        // Next/Complete button
        Expanded(
          flex: canGoPrevious ? 1 : 1,
          child: SizedBox(
            height: 56,
            child: ElevatedButton(
              onPressed: canGoNext && !isLoading ? onNext : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: canGoNext 
                    ? AppColors.buttonPrimary 
                    : AppColors.buttonDisabled,
                foregroundColor: AppColors.textPrimary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: AppColors.textPrimary,
                        strokeWidth: 2,
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            isLastQuestion ? 'Complete' : 'Next',
                            style: AppTextStyles.buttonLarge,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          isLastQuestion ? Icons.check : Icons.arrow_forward,
                          size: 20,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
