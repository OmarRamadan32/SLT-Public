import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/drawer_widget/app_drawer_widget.dart';
import 'package:new_slt/core/widgets/custom_bottom_navigation_bar_widget.dart';
import 'package:new_slt/core/widgets/screen_widget/screen_widget_appbar.dart';
import 'package:new_slt/core/widgets/screen_widget/screen_widget_content.dart';

class ScreenWidget extends StatelessWidget {
  const ScreenWidget({
    super.key,
    required this.isMainScreen,
    required this.child,
    this.hasDrawer = true,
  });
  final bool isMainScreen;
  final Widget child;
  final bool? hasDrawer;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      child: SafeArea(
        bottom: true,
        child: Scaffold(
          backgroundColor:
              Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          body: Stack(
            alignment: Alignment.center,
            children: [
              ScreenWidgetContent(child: child),
              isMainScreen
                  ? Positioned(
                    bottom: 15.h,
                    child: const CustomBottomNavigationBarWidget(),
                  )
                  : const SizedBox.shrink(),
              Positioned(
                top: 0,
                child: ScreenWidgetAppBar(
                  hasDrawer: hasDrawer!,
                  isMainScreen: isMainScreen,
                ),
              ),
            ],
          ),
          drawer: hasDrawer == true ? const AppDrawerWidget() : null,
        ),
      ),
    );
  }
}
