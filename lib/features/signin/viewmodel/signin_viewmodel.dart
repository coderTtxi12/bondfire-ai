import 'package:flutter/material.dart';
import '../models/signin_model.dart';

class SignInViewModel extends ChangeNotifier {
  SignInModel _signInData = SignInModel.defaultData;

  // Getters
  SignInModel get signInData => _signInData;
  bool get isLoading => _signInData.isGoogleSignInLoading;


  // Google Sign In
  Future<void> signInWithGoogle() async {
    if (!_signInData.canSignInWithGoogle) return;

    _signInData = _signInData.copyWith(
      isGoogleSignInLoading: true,
      errorMessage: null,
    );
    notifyListeners();

    try {
      // Simular llamada a Google Sign In
      await Future.delayed(const Duration(seconds: 2));
      
      // Aquí iría la lógica real de Google Sign In
      // final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      
      _signInData = _signInData.copyWith(
        isGoogleSignInLoading: false,
      );
      notifyListeners();
      
      // Aquí iría la navegación después del login exitoso
      // context.go('/home');
      
    } catch (e) {
      _signInData = _signInData.copyWith(
        isGoogleSignInLoading: false,
        errorMessage: 'Error al iniciar sesión con Google: ${e.toString()}',
      );
      notifyListeners();
    }
  }


  // Clear error message
  void clearError() {
    _signInData = _signInData.copyWith(errorMessage: null);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
