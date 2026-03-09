import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class AddPostButton extends StatelessWidget {
  const AddPostButton({
    super.key,
    required this.isPrimaryButton,
    required this.text,
    required this.icon,
    required this.onPressed,
  });
  final bool isPrimaryButton;
  final String text;
  final IconData icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color:
              isPrimaryButton
                  ? theme.primaryColor
                  : theme.bottomNavigationBarTheme.backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(),
            ArabicTextWidget(
              maxLines: 1,
              text: text,
              style: theme.textTheme.bodyMedium!.copyWith(
                color:
                    isPrimaryButton
                        ? theme.bottomNavigationBarTheme.backgroundColor
                        : theme.primaryColor,
              ),
            ),
            Icon(
              icon,
              size: 25.sp,
              color:
                  isPrimaryButton
                      ? theme.bottomNavigationBarTheme.backgroundColor
                      : theme.primaryColor,
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}
