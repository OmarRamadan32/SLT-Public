import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_card_details.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/constants/constants.dart';

class DashBoardCard extends StatelessWidget {
  const DashBoardCard({
    super.key,
    required this.cardTitle,
    required this.cardDescription,
    required this.cardAccessDescription,
    required this.moveToPage,
    this.requiredAccessLevel,
  });
  final String cardTitle;
  final String cardDescription;
  final String cardAccessDescription;
  final String moveToPage;
  final int? requiredAccessLevel;

  @override
  Widget build(BuildContext context) {
    int userAccessLevel = context.read<UserCubit>().getUserAccessLevel();
    int requiredAccessLevel = this.requiredAccessLevel ?? 0;
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
      child: GestureDetector(
        onTap: () {
          if (userAccessLevel >= Constants.adminAccessLevel) {
            context.push(moveToPage);
          } else if (userAccessLevel >= requiredAccessLevel) {
            context.push(moveToPage);
          } else {
            Helpers.showSnackBar(
              context,
              "لا تمتلك الصلاحية الكافية",
              isFailureMessage: true,
            );
          }
        },
        child: Container(
          constraints: BoxConstraints(minHeight: 110.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          alignment: Alignment.center,
          width: double.infinity,
          decoration: BoxDecoration(
            color: theme.bottomNavigationBarTheme.backgroundColor,
            borderRadius: BorderRadius.circular(32.h),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Text(
                    cardAccessDescription,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall!.copyWith(
                      fontSize: theme.textTheme.bodySmall!.fontSize! - 1.sp,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: DashboardCardDetails(
                    cardDescription: cardDescription,
                    cardTitle: cardTitle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
