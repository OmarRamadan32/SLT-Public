import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeamHistoryPageTabBarSection extends StatelessWidget {
  const TeamHistoryPageTabBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabAlignment: TabAlignment.center,
      dividerColor: Colors.transparent,
      indicator: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
      labelStyle: Theme.of(context).textTheme.titleSmall,
      unselectedLabelStyle: Theme.of(context).textTheme.labelSmall,
      physics: const BouncingScrollPhysics(),
      isScrollable: true,
      tabs: [
        const Tab(text: "حكاوي القادة"),
        const Tab(text: "أعراف الفريق"),
        const Tab(text: "أغاني الفريق"),
        const Tab(text: "رسائل الخريجين"),
      ],
    );
  }
}
