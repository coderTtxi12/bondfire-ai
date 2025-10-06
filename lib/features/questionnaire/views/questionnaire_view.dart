import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../viewmodel/questionnaire_viewmodel.dart';
import '../widgets/questionnaire_content_widget.dart';

class QuestionnaireView extends StatefulWidget {
  const QuestionnaireView({super.key});

  @override
  State<QuestionnaireView> createState() => _QuestionnaireViewState();
}

class _QuestionnaireViewState extends State<QuestionnaireView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuestionnaireViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundDark,
        body: SafeArea(
          child: const QuestionnaireContentWidget(),
        ),
      ),
    );
  }
}
