import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/constants/constants.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class ScheduleCardDate extends StatelessWidget {
  const ScheduleCardDate({super.key, required this.meetingDate});

  final DateTime meetingDate;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ArabicTextWidget(
            text: Helpers.zeroFill(meetingDate.day),
            style: theme.textTheme.titleLarge!.copyWith(
              fontFamily: Constants.englishFont,
              fontSize: 20.sp,
            ),
          ),
          // the meeting month name
          ArabicTextWidget(
            text: Helpers.getMonthName(meetingDate.month),
            style: theme.textTheme.bodyLarge,
          ),
          ArabicTextWidget(
            text:
                "${meetingDate.hour % 12 == 0 ? 12 : meetingDate.hour % 12}:${meetingDate.minute.toString().padLeft(2, '0')} ${meetingDate.hour >= 12 ? 'مساءً' : 'صباحًا'}",
            style: theme.textTheme.bodyMedium!.copyWith(
              fontSize: theme.textTheme.labelMedium!.fontSize! + -2,
            ),
          ),
          // schedule day name
        ],
      ),
    );
  }
}
