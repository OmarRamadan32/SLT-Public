import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_slt/core/constants/assets.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/features/onboarding/presentation/widgets/angle_down_widget.dart';
import 'package:new_slt/features/onboarding/presentation/widgets/onboarding_body_widget.dart';

class OnboardingPage9Body extends StatelessWidget {
  const OnboardingPage9Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OnboardingBodyWidget(
          body:
              'دي هتكون الطريقة الأساسية اللي أعضاء الفريق هيوصلهم بيها القرارات او يتبعتلهم اي رسالة من المسؤولين عن طريقها',
        ),
        const AngleDownWidget(),
        SvgPicture.asset(Assets.notifiCard, height: 50.h),
        const AngleDownWidget(),
        SvgPicture.asset(Assets.messagesCard, height: 200.h),
        Spaces.inSectionSpace20,
        const OnboardingBodyWidget(
          fontSize: 12,
          textAlign: TextAlign.right,
          body:
              'صفحة الإشعارات مش هيكون فيها رسايل الفريق بس, هيكون فيها كمان كل القرارات الخاصة بيك, او القرارات العامة, وكمان البوستات المُعلقة (للناس اللي معاها الصلاحية دي) والمقصود بالقرارات العامة: هي إعلان مين مجلس إدارة او أمين صندوق وهكذا, واللي لازم تظهر لكل أعضاء الفريق, علي عكس القرارات الخاصة اللي هتظهر للشخص المعني بالقرار فقط ',
        ),
      ],
    );
  }
}
