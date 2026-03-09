import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class MentionCard extends StatelessWidget {
  const MentionCard({
    super.key,
    required this.isAuthor,
    required this.cardName,
  });
  final bool isAuthor;
  final String cardName;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      margin: const EdgeInsets.only(left: 2, bottom: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color:
            isAuthor
                ? theme.bottomNavigationBarTheme.backgroundColor
                : theme.scaffoldBackgroundColor,
      ),
      child: ArabicTextWidget(
        text: cardName,
        style: Theme.of(
          context,
        ).textTheme.bodySmall!.copyWith(color: theme.primaryColor),
      ),
    );
  }
}
