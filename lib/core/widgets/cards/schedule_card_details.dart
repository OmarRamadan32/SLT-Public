import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/constants/constants.dart';
import 'package:new_slt/core/theme/spaces.dart';

import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class ScheduleCardDetails extends StatelessWidget {
  const ScheduleCardDetails({
    super.key,
    required this.meetingTitle,
    required this.meetingDescription,
  });
  final String meetingTitle;
  final String meetingDescription;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: EdgeInsets.only(right: 15.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ArabicTextWidget(
              text: meetingTitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Spaces.space5,
            ArabicTextWidget(
              maxLines: 2,
              text: meetingDescription,
              style: Theme.of(
                context,
              ).textTheme.labelSmall!.copyWith(fontFamily: Constants.appFont),
            ),
          ],
        ),
      ),
    );
  }
}
