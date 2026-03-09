import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.isCentered,
    this.titleFontSize,
    this.titleColor,
  });

  final String title;
  final String? subtitle;
  final bool? isCentered;
  final int? titleFontSize;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: isCentered ?? false ? 0 : 3.w),
      child: Container(
        width: double.infinity,
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment:
              isCentered ?? false
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.end,
          children: [
            subtitle == null
                ? const SizedBox()
                : ArabicTextWidget(
                  text: "($subtitle)",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
            SizedBox(width: 5.w),
            ArabicTextWidget(
              text: title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: titleFontSize?.sp,
                color: titleColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
