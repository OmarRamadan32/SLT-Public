import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/core/widgets/cards/full_image_card/full_image_card_details_sheet.dart';

class FullImageCardDetails extends StatelessWidget {
  const FullImageCardDetails({
    super.key,
    required this.cardTitle,
    required this.cardLeaderOne,
    required this.cardLeaderTwo,
  });
  final String cardTitle;
  final String cardLeaderOne;
  final String cardLeaderTwo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Spaces.inSectionSpace20,
          ArabicTextWidget(
            text: cardTitle,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: Colors.white),
          ),
          SizedBox(height: 16.h),
          FullImageCardDetailsSheet(isLast: false, text: cardLeaderOne),
          SizedBox(height: 8.h),
          FullImageCardDetailsSheet(isLast: true, text: cardLeaderTwo),
        ],
      ),
    );
  }
}
