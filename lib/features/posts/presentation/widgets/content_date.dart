import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class ContentDate extends StatelessWidget {
  const ContentDate({super.key, required this.postDate});
  final DateTime postDate;

  @override
  Widget build(BuildContext context) {
    final int hour = postDate.hour % 12 == 0 ? 12 : postDate.hour % 12;
    final String period = postDate.hour < 12 ? 'صباحًا' : 'مساءً';
    final String time =
        "${hour.toString().padLeft(2, '0')}:${postDate.minute.toString().padLeft(2, '0')} $period";
    final ThemeData theme = Theme.of(context);
    return Column(
      children: [
        ArabicTextWidget(
          text:
              "${Helpers.zeroFill(postDate.day)} ${Helpers.getMonthName(postDate.month)} ${postDate.year}",
          style: theme.textTheme.labelSmall!.copyWith(),
        ),
        ArabicTextWidget(
          text: time,
          style: theme.textTheme.labelSmall!.copyWith(
            fontSize: theme.textTheme.labelSmall!.fontSize! + 0.5.sp,
          ),
        ),
      ],
    );
  }
}
