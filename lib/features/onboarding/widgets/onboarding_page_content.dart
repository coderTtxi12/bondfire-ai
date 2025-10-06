import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/onboarding_model.dart';

class OnboardingPageContent extends StatelessWidget {
  final OnboardingPage page;

  const OnboardingPageContent({
    super.key,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            const SizedBox(height: 40),
            
            // Page Image/Illustration
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: AppColors.backgroundDark,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.buttonSecondary,
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: _buildPageIllustration(),
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Page Title
            Text(
              page.title,
              style: AppTextStyles.headlineLarge,
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 16),
            
            // Page Description
            Text(
              page.description,
              style: AppTextStyles.subtitleLarge.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            
            if (page.additionalText != null) ...[
              const SizedBox(height: 16),
              Text(
                page.additionalText!,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIllustration() {
    // For now, we'll create placeholder illustrations
    // In a real app, you would use actual images
    switch (page.title) {
      case "Everything your mind needs":
        return _buildFirstPageIllustration();
      case "Personalized Support":
        return _buildSecondPageIllustration();
      case "Track Your Progress":
        return _buildThirdPageIllustration();
      default:
        return _buildDefaultIllustration();
    }
  }

  Widget _buildFirstPageIllustration() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryOrange,
            AppColors.primaryYellow,
            AppColors.buttonPrimary,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Background shapes
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 30,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Central content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.psychology,
                  size: 80,
                  color: Colors.white,
                ),
                const SizedBox(height: 16),
                Text(
                  "Mind Wellness",
                  style: AppTextStyles.headlineSmall.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecondPageIllustration() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.buttonPrimary,
            AppColors.primaryBlue,
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.support_agent,
              size: 80,
              color: Colors.white,
            ),
            const SizedBox(height: 16),
            Text(
              "Personal Support",
              style: AppTextStyles.headlineSmall.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThirdPageIllustration() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryOrange,
            AppColors.primaryYellow,
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.trending_up,
              size: 80,
              color: Colors.white,
            ),
            const SizedBox(height: 16),
            Text(
              "Track Progress",
              style: AppTextStyles.headlineSmall.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultIllustration() {
    return Container(
      color: AppColors.buttonSecondary,
      child: Center(
        child: Icon(
          Icons.image,
          size: 80,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
