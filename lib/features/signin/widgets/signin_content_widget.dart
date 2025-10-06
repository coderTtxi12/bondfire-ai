import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../viewmodel/signin_viewmodel.dart';
import 'google_signin_button.dart';

class SignInContentWidget extends StatefulWidget {
  const SignInContentWidget({super.key});

  @override
  State<SignInContentWidget> createState() => _SignInContentWidgetState();
}

class _SignInContentWidgetState extends State<SignInContentWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SignInViewModel>(
      builder: (context, viewModel, child) {
        final signInData = viewModel.signInData;
        
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              
              // Título
              const Text(
                "Sign In",
                style: AppTextStyles.headlineLarge,
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 8),
              
              // Subtítulo
              Text(
                "Welcome! Please sign in to continue",
                style: AppTextStyles.subtitleLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 40),
              
              // Google Sign In Button
              GoogleSignInButton(
                onPressed: signInData.canSignInWithGoogle
                    ? () => viewModel.signInWithGoogle()
                    : null,
                isLoading: signInData.isGoogleSignInLoading,
              ),
              
              const SizedBox(height: 16),
              
              // Error Message
              if (signInData.errorMessage != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.red.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    signInData.errorMessage!,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.red,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
