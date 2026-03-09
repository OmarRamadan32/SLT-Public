import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/core/widgets/avatar_image.dart';
import 'package:new_slt/core/widgets/verified_icon.dart';

class MultibleMembersCard extends StatelessWidget {
  const MultibleMembersCard({
    super.key,
    required this.userModel,
    required this.selected,
    required this.index,
    this.onChanged,
    this.onTap,
  });
  final UserModel userModel;
  final bool selected;
  final int index;
  final void Function(bool?)? onChanged;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      color:
          selected
              ? theme.primaryColor
              : theme.bottomNavigationBarTheme.backgroundColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                checkColor: Colors.white,
                activeColor: theme.primaryColor,
                value: selected,
                onChanged: onChanged,
              ),
              const Spacer(),
              Row(
                children: [
                  VerifiedIcon(accessLevel: userModel.accessLevel!),
                  ArabicTextWidget(
                    text: userModel.name,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
              SizedBox(width: 8.w),
              AvatarImage(height: 50, width: 50, imageUrl: userModel.imageUrl),
            ],
          ),
        ),
      ),
    );
  }
}
