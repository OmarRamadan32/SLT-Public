import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/global_cubits/bottom_navigation_bar_cubit/bottom_navigation_bar_cubit.dart';

class CustomBottomNavigationBarItem extends StatelessWidget {
  const CustomBottomNavigationBarItem({
    super.key,
    required this.label,
    required this.itemIcon,
    required this.index,
    required this.route,
  });

  final String label;
  final IconData itemIcon;
  final int index;
  final String route;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return BlocBuilder<BottomNavigationBarCubit, int>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<BottomNavigationBarCubit>().changeIndex(index);
            context.go(route);
          },
          child: Container(
            decoration: BoxDecoration(
              color:
                  state == index
                      ? Colors.transparent.withAlpha(150)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Padding(
              padding:
                  state == index
                      ? EdgeInsets.symmetric(horizontal: 0.w, vertical: 8.h)
                      : EdgeInsets.symmetric(horizontal: 0.w, vertical: 4.h),
              child: SizedBox(
                // width: 60.w, // not sure about this width,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        itemIcon,
                        size: 18.sp,
                        color:
                            state == index
                                ? theme
                                    .bottomNavigationBarTheme
                                    .selectedItemColor
                                : theme
                                    .bottomNavigationBarTheme
                                    .unselectedItemColor,
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        label,
                        style:
                            state == index
                                ? theme
                                    .bottomNavigationBarTheme
                                    .selectedLabelStyle!
                                    .copyWith(
                                      color:
                                          theme
                                              .bottomNavigationBarTheme
                                              .selectedItemColor,
                                    )
                                : theme
                                    .bottomNavigationBarTheme
                                    .unselectedLabelStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
