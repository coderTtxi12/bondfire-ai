import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../widgets/welcome_content_widget.dart';
import '../widgets/curved_clipper.dart';
import '../../../core/theme/app_colors.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.backgroundDark,
        child: SafeArea(
          child: Column(
            children: [
              // Parte superior con la animación de fuego
              Expanded(
                flex: 4,
                child: ClipPath(
                  clipper: CurvedClipper(),
                  child: Container(
                    width: double.infinity,
                    color: AppColors.backgroundYellow,
                    child: Center(
                      child: Lottie.asset(
                        'assets/animations/fireblue.json',
                        width: 300,
                        height: 300,
                        fit: BoxFit.contain,
                        repeat: true,
                        animate: true,
                      ),
                    ),
                  ),
                ),
              ),
              
              // Parte inferior con el contenido de texto y botones
              Expanded(
                flex: 6,
                child: Container(
                  width: double.infinity,
                  color: AppColors.backgroundDark,
                  child: const WelcomeContentWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
