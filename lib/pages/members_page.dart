import 'package:flutter/material.dart';
import 'package:new_slt/core/widgets/screen_widget/screen_widget.dart';
import 'package:new_slt/features/members/presentation/views/members_view.dart';

class MembersPage extends StatelessWidget {
  const MembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenWidget(isMainScreen: true, child: MembersView());
  }
}
