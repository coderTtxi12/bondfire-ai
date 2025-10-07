import 'package:flutter/material.dart';

enum HomeTab {
  groups,
  compatibility,
  questionGame,
  aboutYou,
}

class HomeData {
  final HomeTab currentTab;
  final bool isLoading;

  const HomeData({
    required this.currentTab,
    required this.isLoading,
  });

  HomeData copyWith({
    HomeTab? currentTab,
    bool? isLoading,
  }) {
    return HomeData(
      currentTab: currentTab ?? this.currentTab,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  static HomeData get defaultData => const HomeData(
    currentTab: HomeTab.groups,
    isLoading: false,
  );
}

class TabInfo {
  final HomeTab tab;
  final String title;
  final IconData icon;
  final IconData activeIcon;

  const TabInfo({
    required this.tab,
    required this.title,
    required this.icon,
    required this.activeIcon,
  });
}

class HomeTabData {
  static const List<TabInfo> tabs = [
    TabInfo(
      tab: HomeTab.groups,
      title: 'Groups',
      icon: Icons.group_outlined,
      activeIcon: Icons.group,
    ),
    TabInfo(
      tab: HomeTab.compatibility,
      title: 'Compatibility',
      icon: Icons.favorite_outline,
      activeIcon: Icons.favorite,
    ),
    TabInfo(
      tab: HomeTab.questionGame,
      title: 'Question Game',
      icon: Icons.casino_outlined,
      activeIcon: Icons.casino,
    ),
    TabInfo(
      tab: HomeTab.aboutYou,
      title: 'About You',
      icon: Icons.person_outline,
      activeIcon: Icons.person,
    ),
  ];
}
