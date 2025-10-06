import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../viewmodel/questionnaire_viewmodel.dart';
import 'progress_indicator_widget.dart';
import 'question_widget.dart';
import 'questionnaire_navigation_widget.dart';

class QuestionnaireContentWidget extends StatefulWidget {
  const QuestionnaireContentWidget({super.key});

  @override
  State<QuestionnaireContentWidget> createState() => _QuestionnaireContentWidgetState();
}

class _QuestionnaireContentWidgetState extends State<QuestionnaireContentWidget> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionnaireViewModel>(
      builder: (context, viewModel, child) {
        final questionnaireData = viewModel.questionnaireData;
        
        // Sync page controller with view model
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_pageController.hasClients) {
            _pageController.animateToPage(
              questionnaireData.currentQuestionIndex,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        });

        // Show completion screen
        if (questionnaireData.isCompleted) {
          return _buildCompletionScreen();
        }

        return Column(
          children: [
            // Progress indicator
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 32, right: 32),
              child: ProgressIndicatorWidget(
                progress: questionnaireData.progress,
                currentQuestion: questionnaireData.currentQuestionIndex + 1,
                totalQuestions: questionnaireData.totalQuestions,
                answeredProgress: questionnaireData.answeredProgress,
                aiAccuracy: questionnaireData.aiAccuracy,
                aiAccuracyColor: questionnaireData.aiAccuracyColor,
              ),
            ),
            
            // Question content with PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  viewModel.goToQuestion(index);
                },
                itemCount: questionnaireData.totalQuestions,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 120),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height * 0.6,
                        ),
                        child: QuestionWidget(
                          question: questionnaireData.questions[index],
                          answer: viewModel.getAnswerForQuestion(questionnaireData.questions[index].id),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Navigation buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              child: QuestionnaireNavigationWidget(
                canGoNext: questionnaireData.canGoNext,
                canGoPrevious: questionnaireData.canGoPrevious,
                isLastQuestion: questionnaireData.isLastQuestion,
                isLoading: questionnaireData.isLoading,
                onNext: () => viewModel.nextQuestion(),
                onPrevious: () => viewModel.previousQuestion(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCompletionScreen() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 160,
              height: 160,
              child: Lottie.asset(
                'assets/animations/analytic_loader.json',
                repeat: true,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'All Done!',
              style: AppTextStyles.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Thank you for completing the questionnaire. Our AI model has analyzed your answers. Tap “See Results” to continue.',
              style: AppTextStyles.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to main app or next screen
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonPrimary,
                  foregroundColor: AppColors.textPrimary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: Text(
                  'See Results',
                  style: AppTextStyles.buttonLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
