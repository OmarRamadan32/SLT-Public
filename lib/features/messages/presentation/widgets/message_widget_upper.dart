import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class MessageWidgetUpperPart extends StatelessWidget {
  const MessageWidgetUpperPart({
    super.key,
    required this.senderName,
    required this.messageDate,
    required this.isPrimary,
  });
  final String senderName;
  final DateTime messageDate;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ArabicTextWidget(
          text: '${messageDate.day}/${messageDate.month}/${messageDate.year}',
          style: theme.textTheme.labelSmall!.copyWith(
            fontSize: theme.textTheme.labelSmall!.fontSize! + 1.sp,
            color: isPrimary ? Colors.black : null,
          ),
        ),
        ArabicTextWidget(
          text:
              'من: '
              '$senderName',
          style: theme.textTheme.labelSmall!.copyWith(
            fontSize: theme.textTheme.labelSmall!.fontSize! + 1.sp,
            color: isPrimary ? Colors.black : null,
          ),
        ),
      ],
    );
  }
}
