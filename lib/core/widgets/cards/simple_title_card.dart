import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class SimpleTitleCard extends StatelessWidget {
  const SimpleTitleCard({super.key, required this.cardText});
  final String cardText;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: ArabicTextWidget(
        text:cardText,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
