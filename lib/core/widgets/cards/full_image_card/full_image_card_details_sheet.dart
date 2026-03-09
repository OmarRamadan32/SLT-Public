import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class FullImageCardDetailsSheet extends StatelessWidget {
  const FullImageCardDetailsSheet({super.key, required this.isLast, required this.text});
  final bool isLast;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: isLast ? 130.w : 100.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 10.w),
                alignment: Alignment.centerRight,
                child: ArabicTextWidget(
                  text: text,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
