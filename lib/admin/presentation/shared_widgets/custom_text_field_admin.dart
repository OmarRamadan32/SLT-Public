import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class CustomTextFieldAdmin extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final TextInputAction? textInputAction;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  const CustomTextFieldAdmin({
    super.key,
    required this.label,
    this.controller,
    this.hintText,
    this.obscureText = false,
    this.maxLines,
    this.keyboardType,
    this.textAlign,
    this.textInputAction,
    this.onSaved,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ArabicTextWidget(
          text: label,
          style: theme.textTheme.bodySmall!.copyWith(
            fontSize: theme.textTheme.bodySmall!.fontSize! + 1.sp,
          ),
        ),
        Spaces.space5,
        TextFormField(
          validator: validator,
          onSaved: onSaved,
          textInputAction: textInputAction ?? TextInputAction.done,
          cursorColor: theme.primaryColor,
          textAlign: textAlign ?? TextAlign.right,
          keyboardType: keyboardType ?? TextInputType.text,
          maxLines: maxLines ?? 1,
          textDirection: TextDirection.rtl,
          style: theme.textTheme.bodyMedium,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: theme.bottomNavigationBarTheme.backgroundColor,
            hintText: hintText,
            hintStyle: theme.textTheme.labelSmall,
            hintTextDirection: TextDirection.rtl,
            alignLabelWithHint: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: theme.primaryColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: theme.primaryColor.withAlpha(0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: theme.primaryColor, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 14.h,
            ),
          ),
        ),
      ],
    );
  }
}
