import 'package:flutter/material.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/features/onboarding/presentation/widgets/onboarding_body_widget.dart';

class OnboardingPage1Body extends StatelessWidget {
  const OnboardingPage1Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OnboardingBodyWidget(
          body: "تعالي أقولك إزاي تستخدم التطبيق بعد التحديث الأخير",
        ),
        Spaces.space5,
        const OnboardingBodyWidget(body: '(1.0.5)', isPrimaryColor: false),
        Spaces.inSectionSpace20,
        const OnboardingBodyWidget(body: 'واللي بيتضمن', isPrimaryColor: true),
        Spaces.space10,
        const OnboardingBodyWidget(
          body: 'المواعيد - اليوستات - الصلاحيات',
          fontSize: 11,
        ),
        const OnboardingBodyWidget(body: 'رسائل الفريق', fontSize: 11),
      ],
    );
  }
}
