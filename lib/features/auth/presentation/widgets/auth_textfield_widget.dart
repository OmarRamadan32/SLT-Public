import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/constants/constants.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.hint,
    this.textInputType,
    this.isPassword,
    this.icon,
    this.isArabicText,
    this.onSaved,
    this.controller,
    this.validator,
  });
  final String hint;
  final TextInputType? textInputType;
  final bool? isPassword;
  final IconData? icon;
  final bool? isArabicText;
  final Function(String?)? onSaved;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onSaved: onSaved,
      controller: controller,
      decoration: InputDecoration(
        fillColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        filled: true,
        hint: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 3.h),
            child: Text(hint, style: Theme.of(context).textTheme.labelSmall),
          ),
        ),
        suffixIcon:
            icon != null
                ? Padding(
                  padding: EdgeInsets.only(right: 5.w),
                  child: Icon(
                    icon,
                    color: Theme.of(context).primaryColor,
                    size: 22.sp,
                  ),
                )
                : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0.r),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0.r),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0.r),
          borderSide: BorderSide(
            color: Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
          ),
        ),
      ),

      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        fontFamily:
            isArabicText == true ? Constants.appFont : Constants.englishFont,
      ),
      cursorColor: Theme.of(context).primaryColor,
      textAlign: isArabicText == true ? TextAlign.right : TextAlign.left,
      obscureText: isPassword ?? false,
      textDirection:
          isArabicText == true ? TextDirection.rtl : TextDirection.ltr,
      textInputAction: TextInputAction.done,
      keyboardType: textInputType ?? TextInputType.text,
      maxLines: 1,
    );
  }
}
