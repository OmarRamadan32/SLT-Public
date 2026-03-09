import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/screen_widget/screen_widget.dart';
import 'package:new_slt/features/campaigns/presentation/views/campaigns_view.dart';
import 'package:new_slt/features/council/presentation/widgets/council_section.dart';

// صفحة الحملات وبنك الدم والمهرجانات
class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ScreenWidget(
      isMainScreen: true,
      child: DefaultTabController(
        length: 2,
        animationDuration: const Duration(milliseconds: 500),
        child: Column(
          children: [
            Spaces.inSectionSpace20,
            TabBar(
              tabs: [
                Tab(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('عشان ربنا'),
                        const SizedBox(width: 10),
                        FaIcon(FontAwesomeIcons.solidMoon, size: 18.sp),
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('المجالس'),
                        const SizedBox(width: 10),
                        FaIcon(FontAwesomeIcons.users, size: 18.sp),
                      ],
                    ),
                  ),
                ),
              ],
              dividerColor: Colors.transparent,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.transparent, width: 1),
              ),
              labelColor: theme.primaryColor,
              unselectedLabelColor: theme.textTheme.labelLarge!.color,
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      child: CampaignsView(),
                    ),
                  ),
                  CouncilSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
