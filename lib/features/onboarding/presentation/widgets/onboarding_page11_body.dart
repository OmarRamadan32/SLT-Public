import 'package:flutter/material.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/features/onboarding/presentation/widgets/onboarding_body_widget.dart';

class OnboardingPage11Body extends StatelessWidget {
  const OnboardingPage11Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OnboardingBodyWidget(
          textAlign: TextAlign.right,
          body:
              "الأداء بيبقى أقوى وأسرع لما كل حاجة تكون متنظمة ومتجمّعة في مكان واحد، وكمان شكلها يكون مريح للعين",
        ),
        Spaces.space10,
        const OnboardingBodyWidget(
          textAlign: TextAlign.right,
          body:
              "ده بالظبط الهدف من البرنامج: نلمّ كل حاجة في مكان واحد عشان منتوهش! بدل ما الاجتماعات والقرارات ومواعيد الأنشطة متوزعة، هتبقى كلها قدام عينيك ومرتبة، وهتوصل لكل الفريق بسهولة. كده هنقدر نخلص الشغل اللي كان بياخد وقت ومجهود كبير، بفاعلية أكتر وبخطوات قليلة خالص.",
        ),
        Spaces.inSectionSpace20,
        const OnboardingBodyWidget(
          textAlign: TextAlign.right,

          body:
              "احنا لسه مخلصناش 40% حتي من البرنامج، بس كل خطوة بنعملها بتقرّبه من إنه يبقى المنصة المتكاملة والأساسية اللي بتدير كل كبيرة وصغيرة تخص فريقنا.",
        ),
      ],
    );
  }
}
