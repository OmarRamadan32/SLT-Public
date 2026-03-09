import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_slt/core/constants/assets.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/features/onboarding/presentation/widgets/angle_down_widget.dart';
import 'package:new_slt/features/onboarding/presentation/widgets/onboarding_body_widget.dart';

class OnboardingPage6Body extends StatelessWidget {
  const OnboardingPage6Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OnboardingBodyWidget(
          body: 'تقدر تضيف بوست (عادي او بخاصية التسجيل) من خلال إدارة التطبيق',
        ),
        const AngleDownWidget(),
        SvgPicture.asset(Assets.settingsCard, height: 50.h),
        const AngleDownWidget(),
        SvgPicture.asset(Assets.dashboardSecCard, height: 100.h),
        Spaces.inSectionSpace20,
        const OnboardingBodyWidget(
          body: 'هتظهرلك صفحة هتملي بيانات البوست وبس كده.',
        ),
      ],
    );
  }
}
