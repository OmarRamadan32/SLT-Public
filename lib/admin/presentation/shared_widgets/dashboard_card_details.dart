import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class DashboardCardDetails extends StatelessWidget {
  const DashboardCardDetails({
    super.key,
    required this.cardTitle,
    required this.cardDescription,
  });
  final String cardTitle;
  final String cardDescription;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ArabicTextWidget(text: cardTitle, style: theme.textTheme.titleMedium),
        SizedBox(height: 10.h),
        ArabicTextWidget(
          text: cardDescription,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}
