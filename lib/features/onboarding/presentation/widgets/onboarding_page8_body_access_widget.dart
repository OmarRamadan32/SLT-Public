import 'package:flutter/material.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/core/widgets/verified_icon.dart';

class OnboardingPage8BodyAccessWidget extends StatelessWidget {
  const OnboardingPage8BodyAccessWidget({super.key, required this.accessLevel});
  final int accessLevel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VerifiedIcon(accessLevel: accessLevel, size: 25),
        Spaces.space5,
        ArabicTextWidget(
          text: '$accessLevel',
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}
