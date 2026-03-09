import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_slt/core/constants/assets.dart';
import 'package:new_slt/features/onboarding/presentation/widgets/angle_down_widget.dart';

class OnboardingPage10Body extends StatelessWidget {
  const OnboardingPage10Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AngleDownWidget(),
        SvgPicture.asset(Assets.settingsCard, height: 50.h),
        const AngleDownWidget(),
        SvgPicture.asset(Assets.sendMessageGuide, height: 300.h),
      ],
    );
  }
}
