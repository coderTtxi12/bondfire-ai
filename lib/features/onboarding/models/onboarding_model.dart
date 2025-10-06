class OnboardingPage {
  final String title;
  final String description;
  final String imagePath;
  final String? additionalText;

  const OnboardingPage({
    required this.title,
    required this.description,
    required this.imagePath,
    this.additionalText,
  });
}

class OnboardingModel {
  final List<OnboardingPage> pages;
  final int currentPageIndex;
  final bool isLastPage;
  final bool isLoading;

  const OnboardingModel({
    required this.pages,
    this.currentPageIndex = 0,
    this.isLastPage = false,
    this.isLoading = false,
  });

  OnboardingModel copyWith({
    List<OnboardingPage>? pages,
    int? currentPageIndex,
    bool? isLastPage,
    bool? isLoading,
  }) {
    return OnboardingModel(
      pages: pages ?? this.pages,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      isLastPage: isLastPage ?? this.isLastPage,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  OnboardingPage get currentPage => pages[currentPageIndex];
  int get totalPages => pages.length;
  bool get canGoNext => currentPageIndex < totalPages - 1;
  bool get canGoPrevious => currentPageIndex > 0;

  static OnboardingModel get defaultData => OnboardingModel(
    pages: [
      OnboardingPage(
        title: "Everything your mind needs",
        description: "Stress less, sleep soundly, and get one-on-one support to feel your best. Explore hundreds of exercises, courses, and guided programs designed for your mind.",
        imagePath: "assets/images/onboarding1.png",
      ),
      OnboardingPage(
        title: "Personalized Support",
        description: "Get tailored recommendations and one-on-one support from licensed professionals. Your mental wellness journey is unique, and we're here to guide you every step of the way.",
        imagePath: "assets/images/onboarding2.png",
      ),
      OnboardingPage(
        title: "Track Your Progress",
        description: "Monitor your mental health journey with detailed insights and progress tracking. Celebrate your achievements and stay motivated with personalized milestones.",
        imagePath: "assets/images/onboarding3.png",
      ),
    ],
  );
}
