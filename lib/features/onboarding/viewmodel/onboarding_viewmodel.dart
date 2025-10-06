import 'package:flutter/material.dart';
import '../models/onboarding_model.dart';

class OnboardingViewModel extends ChangeNotifier {
  OnboardingModel _onboardingData = OnboardingModel.defaultData;

  // Getters
  OnboardingModel get onboardingData => _onboardingData;
  OnboardingPage get currentPage => _onboardingData.currentPage;
  int get currentPageIndex => _onboardingData.currentPageIndex;
  int get totalPages => _onboardingData.totalPages;
  bool get isLastPage => _onboardingData.isLastPage;
  bool get isLoading => _onboardingData.isLoading;
  bool get canGoNext => _onboardingData.canGoNext;
  bool get canGoPrevious => _onboardingData.canGoPrevious;

  // Navigation methods
  void nextPage() {
    if (!canGoNext) return;

    _onboardingData = _onboardingData.copyWith(
      currentPageIndex: currentPageIndex + 1,
      isLastPage: (currentPageIndex + 1) == totalPages - 1,
    );
    notifyListeners();
  }

  void previousPage() {
    if (!canGoPrevious) return;

    _onboardingData = _onboardingData.copyWith(
      currentPageIndex: currentPageIndex - 1,
      isLastPage: (currentPageIndex - 1) == totalPages - 1,
    );
    notifyListeners();
  }

  void goToPage(int pageIndex) {
    if (pageIndex < 0 || pageIndex >= totalPages) return;

    _onboardingData = _onboardingData.copyWith(
      currentPageIndex: pageIndex,
      isLastPage: pageIndex == totalPages - 1,
    );
    notifyListeners();
  }

  // Continue button action
  Future<void> onContinuePressed() async {
    if (isLastPage) {
      // Navigate to sign-in
      _setLoading(true);
      await Future.delayed(const Duration(milliseconds: 500));
      _setLoading(false);
      // Navigation will be handled by the view
    } else {
      // Go to next page
      nextPage();
    }
  }

  // Skip onboarding
  Future<void> skipOnboarding() async {
    _setLoading(true);
    await Future.delayed(const Duration(milliseconds: 500));
    _setLoading(false);
    // Navigation will be handled by the view
  }

  void _setLoading(bool loading) {
    _onboardingData = _onboardingData.copyWith(isLoading: loading);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
