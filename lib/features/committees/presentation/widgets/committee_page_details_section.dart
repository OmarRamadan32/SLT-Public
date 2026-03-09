import 'package:flutter/material.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/details_box_widget.dart';
import 'package:new_slt/core/widgets/details_row_widget.dart';

class CommitteePageDetailsSection extends StatelessWidget {
  const CommitteePageDetailsSection({
    super.key,
    required this.committeeLeaderName,
    required this.committeeMembersCount,
    required this.committeeDescription,
  });
  final String committeeLeaderName;
  final int committeeMembersCount;
  final String committeeDescription;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DetailsRowWidget(
          cardsCount: 2,
          titles: ["عدد الاعضاء", "مسؤول اللجنة"],
          subTitles: ["$committeeMembersCount", committeeLeaderName],
          primaryColorCount: 1,
          flexes: [1, 2],
        ),
        Spaces.space5,

        Spaces.space10,
        DetailsBoxWidget(content: committeeDescription),
        Spaces.sectionsSpace40,
      ],
    );
  }
}
