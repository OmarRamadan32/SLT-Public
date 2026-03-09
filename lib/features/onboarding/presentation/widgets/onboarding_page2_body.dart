import 'package:flutter/material.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/features/onboarding/presentation/widgets/onboarding_body_widget.dart';

class OnboardingPage2Body extends StatelessWidget {
  const OnboardingPage2Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OnboardingBodyWidget(
          textAlign: TextAlign.right,
          body:
              'خاصية المواعيد في التطبيق معموله عشان تعرض كل الإجتماعات ومواعيد الأنشطة او اي مواعيد تخص الفريق بشكل منظم ويكون فيه واجهة للشخص المسؤول عن الاجتماع يقدر يعرف منها مين هيحضر ومين هيعتذر, ويبقا له تحكم كامل في الموافقه او رفض الاعتذارات دي بشكل بسيط و واضح ويتبعت إشعار بكل تحديثات الاجتماع ده',
        ),
        Spaces.space10,
        const OnboardingBodyWidget(
          textAlign: TextAlign.right,
          body: """
كل عضو فريق هيقدر يضيف إجتماع او موعد حسب صلاحيته. مثال مسؤول اللجنة: عنده صلاحية إنه يضيف إجتماع لجنة. والإجتماع ده هيظهر لأعضاء اللجنة عشان يقدروا يسجلوا فيه, علي عكس المواعيد العامة اللي معمولة عشان تظهر لكل اعضاء الفريق.
""",
        ),
        Spaces.inSectionSpace20,
      ],
    );
  }
}
