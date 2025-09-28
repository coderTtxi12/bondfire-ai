class WelcomeModel {
  final String title;
  final String subtitle;
  final String primaryButtonText;
  final String termsText;
  final String privacyText;
  final bool isTermsAccepted;

  const WelcomeModel({
    required this.title,
    required this.subtitle,
    required this.primaryButtonText,
    required this.termsText,
    required this.privacyText,
    this.isTermsAccepted = false,
  });

  WelcomeModel copyWith({
    String? title,
    String? subtitle,
    String? primaryButtonText,
    String? termsText,
    String? privacyText,
    bool? isTermsAccepted,
  }) {
    return WelcomeModel(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      primaryButtonText: primaryButtonText ?? this.primaryButtonText,
      termsText: termsText ?? this.termsText,
      privacyText: privacyText ?? this.privacyText,
      isTermsAccepted: isTermsAccepted ?? this.isTermsAccepted,
    );
  }

  static WelcomeModel get defaultData => const WelcomeModel(
    title: "Welcome to\nBondfire",
    subtitle: "Support for all of life's\nmoments",
    primaryButtonText: "Continue",
    termsText: "Terms And Conditions",
    privacyText: "Privacy Policy",
  );
}
