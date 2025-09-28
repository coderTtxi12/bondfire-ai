import 'package:flutter/material.dart';

class AppColors {
  // Colores principales de la app basados en la imagen
  static const Color primaryOrange = Color(0xFFFF6B35);
  static const Color primaryYellow = Color(0xFFFFA726);
  static const Color primaryBlue = Color(0xFF2196F3);
  static const Color primaryNavy = Color(0xFF1A1B2E);
  static const Color primaryDark = Color(0xFF0F1419);
  
  // Colores de fondo
  static const Color backgroundYellow = Color(0xFFFFC107);
  static const Color backgroundDark = Color(0xFF0A0E27);
  static const Color backgroundLight = Color(0xFFFFFFFF);
  
  // Colores de texto
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0BEC5);
  static const Color textDark = Color(0xFF263238);
  
  // Colores de botones
  static const Color buttonPrimary = Color(0xFF2196F3);
  static const Color buttonSecondary = Color(0xFF37474F);
  static const Color buttonDisabled = Color(0xFF9E9E9E);
  
  // Colores de decoración (para los iconos flotantes)
  static const Color decorationBlue = Color(0xFF42A5F5);
  static const Color decorationPurple = Color(0xFF9C27B0);
  static const Color decorationPink = Color(0xFFE91E63);
  static const Color decorationGreen = Color(0xFF4CAF50);
  static const Color decorationWhite = Color(0xFFFFFFFF);
  
  // Gradientes
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      backgroundYellow,
      backgroundDark,
    ],
    stops: [0.4, 1.0],
  );
  
  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      buttonPrimary,
      Color(0xFF1976D2),
    ],
  );
}
