import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class MessagesPageTabBarSection extends StatelessWidget {
  const MessagesPageTabBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return TabBar(
      tabAlignment: TabAlignment.center,
      dividerColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.transparent, width: 1),
      ),
      labelColor: theme.primaryColor,
      unselectedLabelColor: theme.textTheme.labelLarge!.color,
      physics: const BouncingScrollPhysics(),
      isScrollable: true,
      tabs: [
        const TabItem(title: "إشعاراتي"),
        const TabItem(title: "الكل"),
        const TabItem(title: "إشعارات الفريق"),
        const TabItem(title: "البوستات المعلقة"),
      ],
    );
  }
}

class TabItem extends StatelessWidget {
  const TabItem({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 5.w),
          child: ArabicTextWidget(text: title),
        ),
      ],
    );
  }
}
