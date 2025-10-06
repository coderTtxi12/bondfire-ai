class SignInModel {
  final bool isGoogleSignInLoading;
  final String? errorMessage;

  const SignInModel({
    this.isGoogleSignInLoading = false,
    this.errorMessage,
  });

  SignInModel copyWith({
    bool? isGoogleSignInLoading,
    String? errorMessage,
  }) {
    return SignInModel(
      isGoogleSignInLoading: isGoogleSignInLoading ?? this.isGoogleSignInLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get canSignInWithGoogle => !isGoogleSignInLoading;

  static SignInModel get defaultData => const SignInModel();
}
