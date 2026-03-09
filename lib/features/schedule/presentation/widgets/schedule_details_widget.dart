import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class ScheduleDetailsWidget extends StatelessWidget {
  const ScheduleDetailsWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
  });
  final IconData icon;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      width: 175.w,
      height: 75.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: theme.bottomNavigationBarTheme.backgroundColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // TITLE
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ArabicTextWidget(text: title),
              const SizedBox(width: 8),
              FaIcon(icon, size: 15.sp, color: theme.primaryColor),
              const SizedBox(width: 10),
            ],
          ),
          // CONTENT
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: ArabicTextWidget(
                  textAlign: TextAlign.center,
                  text: content,
                  style: theme.textTheme.labelMedium!.copyWith(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
