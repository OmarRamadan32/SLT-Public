import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_app_bar.dart';

class DashboardScreenWidget extends StatelessWidget {
  const DashboardScreenWidget({
    super.key,
    required this.appBarTitle,
    required this.child,
    this.floatingActionButton,
  });
  final String appBarTitle;
  final Widget child;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          floatingActionButton: floatingActionButton,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SingleChildScrollView(
            child: Column(
              children: [
                DashboardAppBar(title: appBarTitle),
              Spaces.inSectionSpace20,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
