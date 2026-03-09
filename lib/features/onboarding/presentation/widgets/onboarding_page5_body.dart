import 'package:flutter/material.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/features/onboarding/presentation/widgets/onboarding_body_widget.dart';

class OnboardingPage5Body extends StatelessWidget {
  const OnboardingPage5Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OnboardingBodyWidget(
          body: 'في نوعين من البوستات حاليا (بوست عادي, بوست بخاصية التسجيل)',
        ),
        Spaces.sectionsSpace40,
        const OnboardingBodyWidget(
          body: 'بوست عادي :',
          isPrimaryColor: true,
          textAlign: TextAlign.right,
        ),
        const OnboardingBodyWidget(
          body:
              'هو زي أي بوست عادي جدا وممكن يتكتب فيه اي حاجه عادي والناس تعلق عليه(ممكن لأي عضو فريق إنه يكتب بوست وهيظهر في الصفحة الرئيسية بعد مراجعته) ',
          textAlign: TextAlign.right,
          fontSize: 12,
        ),
        Spaces.inSectionSpace20,
        const OnboardingBodyWidget(
          body: 'بوست بخاصية التسجيل :',
          isPrimaryColor: true,
          textAlign: TextAlign.right,
        ),
        const OnboardingBodyWidget(
          body:
              'الفرق بينه وبين البوست العادي هي خاصية التسجيل اللي بتظهر قائمة بالناس اللي سجلت في البوست (ممكن يستخدم لو حابين نجمع داتا عن مين جي إيفينت او رحلة او مين حابب يدخل لجنة معينة)',
          textAlign: TextAlign.right,
        ),
      ],
    );
  }
}
