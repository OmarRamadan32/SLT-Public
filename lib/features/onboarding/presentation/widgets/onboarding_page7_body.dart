import 'package:flutter/material.dart';
import 'package:new_slt/features/onboarding/presentation/widgets/onboarding_body_widget.dart';

class OnboardingPage7Body extends StatelessWidget {
  const OnboardingPage7Body({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        OnboardingBodyWidget(
          body:
              'بعد التسجيل في البوست دوس علي “عرض المزيد” عشان تتأكد من وجودك في قايمة التسجيل',
        ),
      ],
    );
  }
}
