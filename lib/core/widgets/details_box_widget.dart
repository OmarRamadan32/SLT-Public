import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class DetailsBoxWidget extends StatelessWidget {
  const DetailsBoxWidget({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      constraints: BoxConstraints(minHeight: 75.h),
      decoration: BoxDecoration(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: ArabicTextWidget(
        text: content,
        maxLines: 5,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}
