import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class CommitteeCardTitle extends StatelessWidget {
  const CommitteeCardTitle({super.key, required this.committeeName});
  final String committeeName;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        constraints: BoxConstraints(maxWidth: 150.w, minWidth: 90.w),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32.r),
            topRight: Radius.circular(16.r),
          ),
        ),
        child: ArabicTextWidget(
          text: committeeName,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
