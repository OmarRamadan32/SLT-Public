import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class HalfImageCardDetails extends StatelessWidget {
  const HalfImageCardDetails({
    super.key,
    required this.campaignTitle,
    required this.campaignLeaderOneName,
    required this.campaignLeaderTwoName,
  });
  final String campaignTitle;
  final String campaignLeaderOneName;
  final String campaignLeaderTwoName;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Expanded(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spaces.inSectionSpace20,
            Container(
              alignment: Alignment.centerRight,
              child: ArabicTextWidget(
                text: campaignTitle,
                style: theme.textTheme.bodyMedium,
              ),
            ),
            Spaces.inSectionSpace20,
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 3.h,
                  ),
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: ArabicTextWidget(
                    text: campaignLeaderOneName,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.bottomNavigationBarTheme.backgroundColor,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 3.h,
                  ),
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: ArabicTextWidget(
                    text: campaignLeaderTwoName,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.bottomNavigationBarTheme.backgroundColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
