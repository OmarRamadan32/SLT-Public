import 'package:flutter/material.dart';
import 'package:new_slt/admin/presentation/widgets/dashboard_cards_section.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_screen_widget.dart';


class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardScreenWidget(appBarTitle: "إدارة التطبيق", child:   DashBoardCardsSection());
  }
}
