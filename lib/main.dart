import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'features/welcome/viewmodel/welcome_viewmodel.dart';
import 'features/welcome/views/welcome_view.dart';

void main() {
  runApp(const HeadspaceApp());
}

class HeadspaceApp extends StatelessWidget {
  const HeadspaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WelcomeViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Headspace',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        home: const WelcomeView(),
      ),
    );
  }
}
