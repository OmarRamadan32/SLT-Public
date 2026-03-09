import 'package:flutter/material.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class OnboardingTitleWidget extends StatelessWidget {
  const OnboardingTitleWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return ArabicTextWidget(text: title,
  style: Theme.of(context).textTheme.titleLarge,

    );
  }
}