import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/global_cubits/app_theme_cubit/app_theme_cubit.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      child: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Switch.adaptive(
                  value: context.watch<AppThemeCubit>().state == ThemeMode.dark,
                  onChanged:
                      (value) =>
                          context.read<AppThemeCubit>().toggleTheme(value),
                  activeTrackColor: theme.primaryColor,
                  inactiveTrackColor:
                      theme.bottomNavigationBarTheme.backgroundColor,
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: ArabicTextWidget(
                    text: "الوضع الليلي",
                    style: theme.textTheme.titleMedium,
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
