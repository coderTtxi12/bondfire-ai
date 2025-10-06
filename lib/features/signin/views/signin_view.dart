import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import '../../../core/theme/app_colors.dart';
import '../viewmodel/signin_viewmodel.dart';
import '../widgets/signin_content_widget.dart';
import '../../welcome/widgets/curved_clipper.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignInViewModel(),
      child: Scaffold(
        body: Container(
          color: AppColors.backgroundDark,
          child: SafeArea(
            child: Column(
              children: [
                // Parte superior con la animación de fuego
                Expanded(
                  flex: 2,
                  child: ClipPath(
                    clipper: CurvedClipper(),
                    child: Container(
                      width: double.infinity,
                      color: AppColors.backgroundYellow,
                      child: Center(
                        child: Lottie.asset(
                          'assets/animations/fireblue.json',
                          width: 200,
                          height: 200,
                          fit: BoxFit.contain,
                          repeat: true,
                          animate: true,
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Parte inferior con el contenido de sign in
                Expanded(
                  flex: 8,
                  child: Container(
                    width: double.infinity,
                    color: AppColors.backgroundDark,
                    child: const SignInContentWidget(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
