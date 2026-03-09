import 'package:flutter/material.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/skeleton_loading_view.dart';
import 'package:new_slt/features/team_history/presentation/widgets/history_card.dart';

class TeamHistoryLoadingView extends StatelessWidget {
  const TeamHistoryLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spaces.inSectionSpace20,
        const SkeletonLoadingView(
          card: HistoryCard(
            cardTitle:
                "----------------------------------------------------------",
            cardContent: "-------------------------------",
          ),
          cardsCount: 10,
        ),
      ],
    );
  }
}
