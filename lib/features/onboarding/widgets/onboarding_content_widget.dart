import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../viewmodel/onboarding_viewmodel.dart';
import 'page_indicators.dart';
import 'onboarding_page_content.dart';

class OnboardingContentWidget extends StatefulWidget {
  const OnboardingContentWidget({super.key});

  @override
  State<OnboardingContentWidget> createState() => _OnboardingContentWidgetState();
}

class _OnboardingContentWidgetState extends State<OnboardingContentWidget> {
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
    return Consumer<OnboardingViewModel>(
      builder: (context, viewModel, child) {
        final onboardingData = viewModel.onboardingData;
        
        // Sync page controller with view model
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_pageController.hasClients) {
            _pageController.animateToPage(
              onboardingData.currentPageIndex,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        });

        return Column(
          children: [
            // Page indicators
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: PageIndicators(
                currentPage: onboardingData.currentPageIndex,
                totalPages: onboardingData.totalPages,
              ),
            ),
            
            // Page content with PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  viewModel.goToPage(index);
                },
                itemCount: onboardingData.totalPages,
                itemBuilder: (context, index) {
                  return OnboardingPageContent(
                    page: onboardingData.pages[index],
                  );
                },
              ),
            ),
            
            // Bottom section with buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              child: Column(
                children: [
                  // Continue button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: onboardingData.isLoading
                          ? null
                          : () => viewModel.onContinuePressed(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonPrimary,
                        foregroundColor: AppColors.textPrimary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: onboardingData.isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: AppColors.textPrimary,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              onboardingData.isLastPage ? "Get Started" : "Continue",
                              style: AppTextStyles.buttonLarge,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
