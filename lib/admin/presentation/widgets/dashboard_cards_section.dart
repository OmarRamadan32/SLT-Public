import 'package:flutter/material.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_card.dart';
import 'package:new_slt/core/constants/constants.dart';

class DashBoardCardsSection extends StatelessWidget {
  const DashBoardCardsSection({super.key});
  // here will be the descriptions of all cards

  static String committeesDescription = '''
- اضافة وتعديل اللجان
- اضافة وحذف اجتماعات اللجان
- اضافة وحذف اعضاء اللجان
''';

  static String campaignsDescription = '''
- إضافة الحملات وأنشطتها
- تعديل الانشطة والمسؤولين
- اضافة وحذف الاجتماعات ومواعيد الانشطة
''';

  static String councilsDescription = '''
- إضافة المجلس والمجاميع والسواعد
- تعديل تفاصيل المجلس
- اضافة وحذف اجتماعات المجلس والسواعد
''';

  static String membersDescription = '''
- إرسال رسائل
- إدارة كل ما يخص اعضاء الفريق
- تغيير المناصب   
''';

  static String meetingsDescription = '''
- إضافة مواعيد عامة
- حذف مواعيد عامة 
''';

  static String postsDescription = '''
- إضافة وحذف بوستات
- إضافة وحذف بوستات بخاصية التسجيل
- تعديل البوستات
''';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DashBoardCard(
          moveToPage: AppRouter.kPostsAdminPage,
          cardTitle: "البوستات",
          cardDescription: postsDescription,
          cardAccessDescription: "خاص بالجميع",
        ),
        DashBoardCard(
          requiredAccessLevel: Constants.adminAccessLevel,
          moveToPage: AppRouter.kScheduleAdminPage,
          cardTitle: "المواعيد العامة",
          cardDescription: meetingsDescription,
          cardAccessDescription: "خاص بقائد الفريق فقط",
        ),

        DashBoardCard(
          moveToPage: AppRouter.kCommitteesAdminPage,
          cardTitle: "اللجان",
          cardDescription: committeesDescription,
          cardAccessDescription: "خاص بمسؤولين اللجان",
        ),
        DashBoardCard(
          moveToPage: AppRouter.kCampaignsAdminPage,
          cardTitle: "الحملات",
          cardDescription: campaignsDescription,
          cardAccessDescription: "خاص بمسؤولين الحملة والانشطة",
        ),
        DashBoardCard(
          moveToPage: AppRouter.kCouncilsAdminPage,
          cardTitle: "المجالس",
          cardDescription: councilsDescription,
          cardAccessDescription: "خاص بقائد المجلس والمجاميع والسواعد",
        ),
        DashBoardCard(
          requiredAccessLevel: 3,
          moveToPage: AppRouter.kMembersAdminPage,
          cardTitle: "اعضاء الفريق",
          cardDescription: membersDescription,
          cardAccessDescription: "خاص بقائد الفريق فقط",
        ),
      ],
    );
  }
}
