import 'package:flutter/material.dart';
import '../models/home_model.dart';

class HomeViewModel extends ChangeNotifier {
  HomeData _homeData = HomeData.defaultData;

  // Getters
  HomeData get homeData => _homeData;
  HomeTab get currentTab => _homeData.currentTab;
  bool get isLoading => _homeData.isLoading;

  // Tab navigation
  void switchTab(HomeTab tab) {
    if (_homeData.currentTab == tab) return;

    _homeData = _homeData.copyWith(currentTab: tab);
    notifyListeners();
  }

  // Set loading state
  void setLoading(bool loading) {
    _homeData = _homeData.copyWith(isLoading: loading);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
