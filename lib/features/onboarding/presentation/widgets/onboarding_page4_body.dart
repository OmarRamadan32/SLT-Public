import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_slt/core/constants/assets.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/features/onboarding/presentation/widgets/onboarding_body_widget.dart';

class OnboardingPage4Body extends StatelessWidget {
  const OnboardingPage4Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OnboardingBodyWidget(
          body: "كل إجتماع او موعد هيكون موجود في مكان حسب نوعه",
        ),
        Spaces.space5,
        const OnboardingBodyWidget(
          body: '- المواعيد العامة بتظهر في الصفحة الرئيسية -',
        ),
        Spaces.inSectionSpace20,
        SvgPicture.asset(Assets.scheduleCard, height: 120.h),
        Spaces.inSectionSpace20,
        const OnboardingBodyWidget(
          textAlign: TextAlign.right,
          body:
              "ده هيدخلك علي صفحة فيها كل تفاصيل الاجتماع وزرار لتسجيل الحضور وواحد تاني للاعتذار",
        ),
        Spaces.space10,
        const OnboardingBodyWidget(
          textAlign: TextAlign.right,
          body:
              'ولو ضغطت علي زرار الإعتذار هتلاقي حقل إتفتح, تقدر تكتب فيه سبب إعتذارك وهيتبعت لمسؤول الإجتماع, وهتلاقي نفسك إتضفت لقايمة الإعتذرات (الشخص الوحيد اللي هيقدر يشوف ويوافق علي الإعتذارات هو اللي عامل الإجتماع فقط)',
        ),
        Spaces.inSectionSpace20,
        SvgPicture.asset(Assets.addAbsTextField, height: 100.h),
        Spaces.inSectionSpace20,
        SizedBox(
          width: 350.w,
          child: Divider(color: Theme.of(context).primaryColor, thickness: 1.3),
        ),
        Spaces.inSectionSpace20,
        const ArabicTextWidget(text: "الاعتذارات"),
        SvgPicture.asset(Assets.membersList, height: 100.h),
        Spaces.inSectionSpace20,
        const OnboardingBodyWidget(
          body:
              'بالنسبة لمسؤول الإجتماع, عشان تشوف الإعتذارات هتضغط علي صورة الشخص, وهتظهرك دي',
        ),
        Spaces.inSectionSpace20,
        SvgPicture.asset(Assets.absCard, height: 130.h),
        Spaces.inSectionSpace20,
        const ArabicTextWidget(
          text: 'في حالة الرفض او الموافقة علي إعتذارك هيتبعتلك إشعار.',
        ),
      ],
    );
  }
}
