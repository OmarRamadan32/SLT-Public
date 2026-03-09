import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class MessageWidgetBottomSheet extends StatelessWidget {
  const MessageWidgetBottomSheet({
    super.key,
    required this.message,
    required this.isPrimary,
  });
  final String message;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      alignment: Alignment.topRight,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
      width: double.infinity,
      constraints: BoxConstraints(maxHeight: 600.h, minHeight: 400.h),
      decoration: BoxDecoration(
        color: theme.bottomNavigationBarTheme.backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: SingleChildScrollView(
        child: ArabicTextWidget(maxLines: 1000, text: message),
      ),
    );
  }
}
