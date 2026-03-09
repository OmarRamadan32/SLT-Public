import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_slt/core/global_cubits/remote_config_cubit.dart/remote_config_cubit.dart';
import 'package:new_slt/core/constants/constants.dart';
import 'package:new_slt/core/theme/styles.dart';

class ScreenWidgetAppBar extends StatelessWidget {
  const ScreenWidgetAppBar({
    super.key,
    required this.isMainScreen,
    required this.hasDrawer,
  });

  final bool isMainScreen;
  final bool hasDrawer;

  @override
  Widget build(BuildContext context) {
    final RemoteConfigCubit remoteConfigCubit = context.read<RemoteConfigCubit>();
    final ThemeData theme = Theme.of(context);
    return Center(
      child: Container(
        decoration: BoxDecoration(color: theme.appBarTheme.backgroundColor),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // open drawer icon
            hasDrawer == false
                ? SizedBox(width: 50.w)
                : GestureDetector(  
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: FaIcon(
                      FontAwesomeIcons.barsStaggered,
                      size: 22.sp,
                      color: theme.appBarTheme.iconTheme?.color,
                    ),
                  ),
                ),

            const Spacer(),
            // screen title
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h),
              child: Text(
               remoteConfigCubit.loadAppTitle(),
                style: Styles.appBarTitleTextStyle.copyWith(
                  fontFamily: Constants.appNameFont,
                  color: theme.textTheme.bodyMedium?.color,
                ),
              ),
            ),
            isMainScreen ? const SizedBox() : const Spacer(),
            // if isMainScreen, show mainscreen icon icon, else show back icon
            Padding(
              padding: EdgeInsets.only(right: 20.w),
              child:
                  isMainScreen
                      ? const SizedBox()
                      : GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: FaIcon(
                          FontAwesomeIcons.arrowLeft,
                          color: theme.appBarTheme.iconTheme?.color,
                          size: 22.sp,
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
