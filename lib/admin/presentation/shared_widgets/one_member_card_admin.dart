import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/core/widgets/avatar_image.dart';
import 'package:new_slt/core/widgets/verified_icon.dart';

class OneMemberCardAdmin extends StatelessWidget {
  const OneMemberCardAdmin({
    super.key,
    required this.radioValue,
    required this.radioGroupValue,
    required this.onChanged,
    required this.cardTitle,
    required this.cardImage,
    required this.membersAccessLevel,
  });
  final String cardTitle;
  final String cardImage;
  final bool radioValue;
  final bool radioGroupValue;
  final int membersAccessLevel;
  final void Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: InkWell(
        onTap: () => onChanged(radioValue),
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color:
                (radioValue == radioGroupValue)
                    ? theme.primaryColor
                    : theme.bottomNavigationBarTheme.backgroundColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            children: [
              Radio<bool>(
                value: radioValue,
                groupValue: radioGroupValue,
                onChanged: onChanged,
                activeColor: theme.bottomNavigationBarTheme.backgroundColor,
              ),
              const Spacer(),
              Row(
                children: [
                  VerifiedIcon(accessLevel: membersAccessLevel),
                  ArabicTextWidget(
                    text: cardTitle,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
              SizedBox(width: 8.w),
              AvatarImage(imageUrl: cardImage, height: 50, width: 50),
            ],
          ),
        ),
      ),
    );
  }
}
