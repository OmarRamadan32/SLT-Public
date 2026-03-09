import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/global_cubits/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/constants/constants.dart';

class DashboardAppBar extends StatelessWidget {
  const DashboardAppBar({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      color: theme.appBarTheme.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: GestureDetector(
              onTap: () {
                context.pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: theme.primaryColor,
                size: 28.sp,
              ),
            ),
          ),
          Text(
            title,
            style: theme.textTheme.titleLarge!.copyWith(
              fontFamily: Constants.appNameFont,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: GestureDetector(
              onTap: () {
                context.read<BottomNavigationBarCubit>().changeIndex(2);
                context.go(AppRouter.kHomePage);
              },
              child: Icon(
                Icons.home_filled,
                color: theme.primaryColor,
                size: 28.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
