import 'package:flutter/material.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/details_row_widget.dart';

class CampaignActivitiesPageDetailsSection extends StatelessWidget {
  const CampaignActivitiesPageDetailsSection({
    super.key,
    required this.campaignLeaderOne,
    this.campaignLeaderTwo,
    required this.activitiesCount,
  });
  final String campaignLeaderOne;
  final String? campaignLeaderTwo;
  final int activitiesCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DetailsRowWidget(
          cardsCount: 1,
          titles: ["مسؤولين الحملة"],
          subTitles: [
            "$campaignLeaderOne ${campaignLeaderTwo != null ? "و $campaignLeaderTwo" : ""}",
          ],
          primaryColorCount: 1,
        ),
        Spaces.space5,
        DetailsRowWidget(
          cardsCount: 1,
          titles: ["عدد الانشطة"],
          subTitles: [activitiesCount.toString()],
          primaryColorCount: 0,
        ),
      ],
    );
  }
}
