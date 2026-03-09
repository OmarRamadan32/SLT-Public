import 'package:flutter/material.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/features/onboarding/presentation/widgets/onboarding_body_widget.dart';
import 'package:new_slt/features/onboarding/presentation/widgets/onboarding_page8_body_access_widget.dart';

class OnboardingPage8Body extends StatelessWidget {
  const OnboardingPage8Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const OnboardingBodyWidget(
          body: 'الصلاحيات هي اللي هتحدد مين مسموحله يعمل ايه في التطبيق',
        ),
        Spaces.sectionsSpace40,
        const OnboardingBodyWidget(
          body: 'صلاحية من الدرجة الاولي :',
          isPrimaryColor: true,
          textAlign: TextAlign.right,
        ),
        const OnboardingBodyWidget(
          textAlign: TextAlign.right,
          body:
              'دي بتكون مع مسؤولين اللجان والأنشطة في وقت الحملة وبتسمحلهم يضيفوا بوستات بخاصية التسجيل لو احتاجوها',
        ),
        Spaces.inSectionSpace20,
        const OnboardingBodyWidget(
          body: 'صلاحية من الدرجة الثانية :',
          isPrimaryColor: true,
          textAlign: TextAlign.right,
        ),
        const OnboardingBodyWidget(
          textAlign: TextAlign.right,
          body:
              'بتكون مع مجلس الإدارة الأساسي وبتسمحلهم يراجعوا ويقبلوا أي بوست بيتضاف او يرفضوه.',
        ),
        Spaces.inSectionSpace20,
        const OnboardingBodyWidget(
          body: 'صلاحية من الدرجة التالتة :',
          isPrimaryColor: true,
          textAlign: TextAlign.right,
        ),
        const OnboardingBodyWidget(
          textAlign: TextAlign.right,
          body:
              'بتكون مع نائب ومساعد قائد الفريق وقائد المجلس ومسؤول الحملة وبتسمحلهم يستخدموا خاصية (رسائل الفريق) اللي هنشرحها كمان شوية.',
        ),
        Spaces.inSectionSpace20,
        const OnboardingBodyWidget(
          body: 'صلاحية من الدرجة الخامسة :',
          isPrimaryColor: true,
          textAlign: TextAlign.right,
        ),
        const OnboardingBodyWidget(
          textAlign: TextAlign.right,
          body:
              'دي هتكون مع قائد الفريق وناس معينين هيكونوا هم المسؤولين عن إدارة التطبيق بالكامل ودول معاهم كل الصلاحيات',
        ),
        Spaces.sectionsSpace40,
        const OnboardingBodyWidget(
          body: 'وده هيكون شكل الصلاحيات في التطبيق',
          isPrimaryColor: true,
          textAlign: TextAlign.center,
        ),
        Spaces.inSectionSpace20,
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OnboardingPage8BodyAccessWidget(accessLevel: 1),
            SizedBox(width: 10),
            OnboardingPage8BodyAccessWidget(accessLevel: 2),
            SizedBox(width: 10),
            OnboardingPage8BodyAccessWidget(accessLevel: 3),
            SizedBox(width: 50),
            OnboardingPage8BodyAccessWidget(accessLevel: 5),
          ],
        ),
        Spaces.sectionsSpace40,
        const OnboardingBodyWidget(
          body: 'وبعيدا عن درجات الصلاحية في صلاحيات مختلفة',
          isPrimaryColor: true,
          textAlign: TextAlign.center,
        ),
        const OnboardingBodyWidget(
          body:
              'زي إن قائد المجلس هو الوحيد اللي مسموحله يضيف المجاميع والسواعد ويغير أي حاجه في إعدادات المجلس.. وبقيت الصلاحيات بديهية',
        ),
      ],
    );
  }
}
