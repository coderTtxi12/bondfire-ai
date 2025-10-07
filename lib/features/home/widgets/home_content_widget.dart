import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../viewmodel/home_viewmodel.dart';
import '../models/home_model.dart';
import 'groups_tab_widget.dart';
import 'compatibility_tab_widget.dart';
import 'question_game_tab_widget.dart';
import 'about_you_tab_widget.dart';

class HomeContentWidget extends StatelessWidget {
  const HomeContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        final currentTab = viewModel.currentTab;

        return Column(
          children: [
            // Main content area
            Expanded(
              child: _buildTabContent(currentTab),
            ),
            
            // Bottom navigation bar
            Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundDark,
              ),
              child: SafeArea(
                top: false,
                child: Container(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: HomeTabData.tabs.map((tabInfo) {
                      final isSelected = currentTab == tabInfo.tab;
                      return Expanded(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => viewModel.switchTab(tabInfo.tab),
                            borderRadius: BorderRadius.circular(12),
                            splashColor: Colors.white.withOpacity(0.1),
                            highlightColor: Colors.white.withOpacity(0.05),
                            child: Container(
                              height: 60,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Icon(
                                  isSelected ? tabInfo.activeIcon : tabInfo.icon,
                                  color: isSelected 
                                      ? Colors.white 
                                      : AppColors.textSecondary,
                                  size: isSelected ? 32 : 28,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTabContent(HomeTab tab) {
    switch (tab) {
      case HomeTab.groups:
        return const GroupsTabWidget();
      case HomeTab.compatibility:
        return const CompatibilityTabWidget();
      case HomeTab.questionGame:
        return const QuestionGameTabWidget();
      case HomeTab.aboutYou:
        return const AboutYouTabWidget();
    }
  }
}
