import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_slt/core/constants/assets.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/features/onboarding/presentation/widgets/angle_down_widget.dart';
import 'package:new_slt/features/onboarding/presentation/widgets/onboarding_body_widget.dart';

class OnboardingPage3Body extends StatelessWidget {
  const OnboardingPage3Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OnboardingBodyWidget(
          body:
              "تقدر تضيف موعد لو عندك الصلاحية المطلوبة عن طريق إدارة التطبيق",
        ),
        const AngleDownWidget(),
        SvgPicture.asset(
          Assets.settingsCard,
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Spaces.inSectionSpace20,
        const FaIcon(FontAwesomeIcons.angleDown),
        Spaces.inSectionSpace20,
        const OnboardingBodyWidget(
          textAlign: TextAlign.right,
          body: '''
هتلاقي إضافة إجتماع او موعد موجود في كذا مكان حسب نوع الموعد نفسه. مثال
عشان تعمل إجتماع لجنة: اللجان > اسم اللجنة > إضافة إجتماع لجنة
''',
        ),
        Spaces.inSectionSpace20,
        ArabicTextWidget(
          text: "واتاكد انك تحذف الاجتماع بعد ما وقته يخلص",
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}
