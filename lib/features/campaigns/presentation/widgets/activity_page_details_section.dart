import 'package:flutter/material.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/details_box_widget.dart';
import 'package:new_slt/core/widgets/details_row_widget.dart';
import 'package:new_slt/features/campaigns/data/models/activity_model.dart';

class ActivityPageDetailsSection extends StatelessWidget {
  const ActivityPageDetailsSection({super.key, required this.activityModel});
  final ActivityModel activityModel;

  @override
  Widget build(BuildContext context) {
    final String leaderOneName = activityModel.activityLeaderName ?? "";
    final String leaderTwoName = activityModel.activityLeaderTwoName ?? "";
    final String seperate =
        activityModel.activityLeaderTwoName != null &&
                activityModel.activityLeaderName != null
            ? " و "
            : "";
    return Column(
      children: [
        DetailsRowWidget(
          cardsCount: 1,
          titles: ["مسؤولين النشاط"],
          subTitles: ['$leaderOneName$seperate$leaderTwoName'],
          primaryColorCount: 1,
        ),
        Spaces.space5,
        DetailsRowWidget(
          cardsCount: 2,
          titles: ["عدد المنضمين", "رقم الحملة"],
          subTitles: [
            activityModel.activityMembers!.length.toString(),
            "${activityModel.activityCampaignNumber}",
          ],
          primaryColorCount: 0,
          flexes: [1, 2],
        ),
        Spaces.inSectionSpace20,
        DetailsBoxWidget(content: activityModel.activityDescription),
      ],
    );
  }
}
