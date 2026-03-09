// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/constants/constants.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class DashboardSecCard extends StatelessWidget {
  const DashboardSecCard({
    super.key,
    required this.onTap,
    required this.title,
    this.icon,
    this.isActionCard,
    this.requiredAccessLevel,
    this.authorizedIds,
  });
  final GestureTapCallback onTap; // card action
  final String title; // card icon
  final IconData? icon;
  final bool? isActionCard; // just to show icon
  final int? requiredAccessLevel; // the minimum access level to use this card
  final List<String>? authorizedIds; // the List of ids who can enter

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    // User Access
    String userId = context.read<UserCubit>().userModel!.id!;
    int userAccessLevel = context.read<UserCubit>().getUserAccessLevel();
    // Access Methods
    List<String> authorizedIds = this.authorizedIds ?? [];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 5.h),
      child: GestureDetector(
        onTap: () {
          // if user is Admin
          if (userAccessLevel >= Constants.adminAccessLevel) {
            onTap();
          }
          // if access level is =>
          else if (requiredAccessLevel != null &&
              userAccessLevel >= requiredAccessLevel!) {
            onTap();
          }
          // if user is on the list
          else if (authorizedIds.isNotEmpty && authorizedIds.contains(userId)) {
            onTap();
          } else if (authorizedIds.isEmpty && requiredAccessLevel == null) {
            onTap();
          } else {
            Helpers.showSnackBar(
              context,
              "لا تمتلك الصلاحية الكافية",
              isFailureMessage: true,
            );
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: theme.bottomNavigationBarTheme.backgroundColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FaIcon(
                isActionCard == true ? null : FontAwesomeIcons.angleLeft,
                size: 15.sp,
                color: Theme.of(
                  context,
                ).textTheme.bodyLarge!.color!.withAlpha(100),
              ),
              const Spacer(),
              ArabicTextWidget(
                text: title,
                style: theme.textTheme.bodySmall!.copyWith(
                  fontSize: theme.textTheme.bodySmall!.fontSize! - 1.sp,
                ),
              ),
              SizedBox(width: 10.w),
              if (icon != null)
                SizedBox(
                  width: 20.w,
                  child: Center(
                    child: FaIcon(icon, color: theme.primaryColor, size: 20.sp),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
