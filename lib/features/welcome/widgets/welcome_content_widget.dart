import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../onboarding/views/onboarding_view.dart';

class WelcomeContentWidget extends StatefulWidget {
  const WelcomeContentWidget({super.key});

  @override
  State<WelcomeContentWidget> createState() => _WelcomeContentWidgetState();
}

class _WelcomeContentWidgetState extends State<WelcomeContentWidget> {
  bool _isTermsAccepted = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        // Título
        const Text(
          "Welcome to\nBondfire",
          style: AppTextStyles.headlineLarge,
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 16),
        
        // Subtítulo
        Text(
          "Support for all of life's\nmoments",
          style: AppTextStyles.subtitleLarge.copyWith(
            color: AppColors.textSecondary,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 40),
        
        // Términos y condiciones
        _buildTermsSection(),
        
        const SizedBox(height: 60),
        
        // Botones
        _buildButtonsSection(),
        ],
      ),
    );
  }

  Widget _buildTermsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Checkbox
          GestureDetector(
            onTap: () {
              setState(() {
                _isTermsAccepted = !_isTermsAccepted;
              });
            },
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.textSecondary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
                color: _isTermsAccepted
                    ? AppColors.buttonPrimary
                    : Colors.transparent,
              ),
              child: _isTermsAccepted
                  ? const Icon(
                      Icons.check,
                      size: 16,
                      color: AppColors.textPrimary,
                    )
                  : null,
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Texto de términos
          Expanded(
            child: RichText(
              text: TextSpan(
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
                children: [
                  const TextSpan(text: "I agree to Bondfire's "),
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () {
                        // Abrir términos y condiciones
                      },
                      child: Text(
                        "Terms And Conditions",
                        style: AppTextStyles.linkMedium.copyWith(
                          color: AppColors.textPrimary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  const TextSpan(text: " and\nacknowledge the "),
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () {
                        // Abrir política de privacidad
                      },
                      child: Text(
                        "Privacy Policy",
                        style: AppTextStyles.linkMedium.copyWith(
                          color: AppColors.textPrimary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  const TextSpan(text: "."),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          // Botón principal - Continue
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _isTermsAccepted && !_isLoading
                  ? _onContinuePressed
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isTermsAccepted
                    ? AppColors.buttonPrimary
                    : AppColors.buttonDisabled,
                foregroundColor: AppColors.textPrimary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: AppColors.textPrimary,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      "Continue",
                      style: AppTextStyles.buttonLarge,
                    ),
            ),
          ),
          
        ],
      ),
    );
  }

  Future<void> _onContinuePressed() async {
    if (!_isTermsAccepted) return;
    
    setState(() {
      _isLoading = true;
    });
    
    // Simular navegación o lógica de continuación
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Navegar a la pantalla de onboarding
    if (mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const OnboardingView(),
        ),
      );
    }
    
    setState(() {
      _isLoading = false;
    });
  }
}
