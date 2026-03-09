import 'package:flutter/material.dart';
import 'package:new_slt/core/widgets/membership_check_view.dart';
import 'package:new_slt/core/widgets/screen_widget/screen_widget.dart';
import 'package:new_slt/features/home/presentation/views/home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenWidget(isMainScreen: true, child: MembershipCheckView(view: HomeView()));
  }
}
