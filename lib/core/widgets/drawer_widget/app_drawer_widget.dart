import 'package:flutter/material.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/drawer_widget/drawer_logout_card.dart';
import 'package:new_slt/core/widgets/drawer_widget/drawer_widget_cards.dart';
import 'package:new_slt/core/widgets/drawer_widget/drawer_widget_personal_info.dart';
import 'package:new_slt/core/widgets/drawer_widget/theme_switcher.dart';

class AppDrawerWidget extends StatelessWidget {
  const AppDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DrawerWidgetPersonalInfo(),
            Spaces.sectionsSpace40,
            const DrawerWidgetCards(),
            Spaces.sectionsSpace40,
            const ThemeSwitcher(),
            Spaces.space10,
            Spaces.sectionsSpace40,
            const DrawerLogoutCard(),
            //             Spaces.sectionsSpace40,
            // const DrawerWidgetInfo(),
          ],
        ),
      ),
    );
  }
}
