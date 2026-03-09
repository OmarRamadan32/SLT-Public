import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/widgets/custom_bottom_navigation_bar_item.dart';

class CustomBottomNavigationBarWidget extends StatelessWidget {
  const CustomBottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Theme.of(context).primaryColor.withValues(alpha: 0.9),
      ),

      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: CustomBottomNavigationBarItem(
              label: "الأنشطة",
              itemIcon: Icons.local_activity_rounded,
              index: 0,
              route: AppRouter.kActivitiesPage,
            ),
          ),
          Expanded(
            child: CustomBottomNavigationBarItem(
              label: "اللجان",
              itemIcon: FontAwesomeIcons.handshakeAngle,
              index: 1,
              route: AppRouter.kCommitteesPage,
            ),
          ),
          Expanded(
            child: CustomBottomNavigationBarItem(
              label: "الرئيسية",
              itemIcon: FontAwesomeIcons.houseChimney,
              index: 2,
              route: AppRouter.kHomePage,
            ),
          ),
          Expanded(
            child: CustomBottomNavigationBarItem(
              label: "الاعضاء",
              itemIcon: FontAwesomeIcons.solidUser,
              index: 3,
              route: AppRouter.kMembersPage,
            ),
          ),
          Expanded(
            child: CustomBottomNavigationBarItem(
              label: "الإشعارات",
              itemIcon: FontAwesomeIcons.solidBell,
              index: 4,
              route: AppRouter.kMessagesPage,
            ),
          ),
        ],
      ),
    );
  }
}
