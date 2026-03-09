import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class CommentItemFooter extends StatelessWidget {
  const CommentItemFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: ArabicTextWidget(
            style: theme.textTheme.titleMedium,
            text: "رد",
          ),
        ),
        ArabicTextWidget(
          style: theme.textTheme.labelMedium!.copyWith(
            fontSize: theme.textTheme.labelMedium!.fontSize! - 2,
          ),
          text: "عدد الردود: 12",
        ),
      ],
    );
  }
}
