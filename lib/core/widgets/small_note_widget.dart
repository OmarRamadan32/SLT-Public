import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class SmallNoteWidget extends StatelessWidget {
  const SmallNoteWidget({
    super.key,
    required this.content,
    this.alignment,
    this.textColor,
  });

  final String content;
  final AlignmentGeometry? alignment;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: alignment ?? Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
      child: ArabicTextWidget(
        text: content,
        maxLines: 1000,
        style: Theme.of(
          context,
        ).textTheme.labelSmall!.copyWith(color: textColor),
      ),
    );
  }
}
