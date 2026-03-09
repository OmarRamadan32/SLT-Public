import 'package:flutter/material.dart';
import 'package:new_slt/core/widgets/screen_widget/screen_widget.dart';
import 'package:new_slt/features/committees/presentation/views/committees_view.dart';

class CommitteesPage extends StatelessWidget {
  const CommitteesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenWidget(
      isMainScreen: true,
      child: SingleChildScrollView(child: Column(children: [CommitteesView()])),
    );
  }
}
