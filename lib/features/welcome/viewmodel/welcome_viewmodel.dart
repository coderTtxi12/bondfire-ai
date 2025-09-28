import 'package:flutter/material.dart';
import '../models/welcome_model.dart';

class WelcomeViewModel extends ChangeNotifier {
  WelcomeModel _welcomeData = WelcomeModel.defaultData;
  bool _isLoading = false;

  // Getters
  WelcomeModel get welcomeData => _welcomeData;
  bool get isLoading => _isLoading;
  bool get canProceed => _welcomeData.isTermsAccepted;


  void toggleTermsAcceptance() {
    _welcomeData = _welcomeData.copyWith(
      isTermsAccepted: !_welcomeData.isTermsAccepted,
    );
    notifyListeners();
  }

  Future<void> onContinuePressed() async {
    if (!canProceed) return;
    
    _setLoading(true);
    
    // Simular navegación o lógica de continuación
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Aquí iría la navegación a la siguiente pantalla
    // context.go('/next-screen');
    
    _setLoading(false);
  }


  void onTermsPressed() {
    // Abrir términos y condiciones
    // Esto podría ser una navegación o un modal
  }

  void onPrivacyPressed() {
    // Abrir política de privacidad
    // Esto podría ser una navegación o un modal
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
