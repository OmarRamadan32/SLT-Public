import 'package:flutter/material.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/activity_image.dart';
import 'package:new_slt/core/widgets/circle_image_and_title_row_widget.dart';
import 'package:new_slt/core/widgets/screen_widget/screen_widget.dart';
import 'package:new_slt/core/widgets/title_widget.dart';
import 'package:new_slt/features/committees/data/models/committee_model.dart';
import 'package:new_slt/features/committees/presentation/widgets/committee_page_details_section.dart';
import 'package:new_slt/features/schedule/presentation/views/schedule_feature.dart';

class CommitteePage extends StatelessWidget {
  const CommitteePage({super.key, required this.committeeModel});
  final CommitteeModel committeeModel;

  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
      isMainScreen: false,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Spaces.inSectionSpace20,
            ActivityImage(imageUrl: committeeModel.committeeImage),
            Spaces.inSectionSpace20,
            TitleWidget(
              title: committeeModel.committeeName,
              isCentered: true,
              titleFontSize: 15,
              titleColor: Theme.of(context).primaryColor,
            ),
            Spaces.inSectionSpace20,
            CommitteePageDetailsSection(
              committeeDescription: committeeModel.committeeDescription,
              committeeLeaderName:
                  committeeModel.committeeLeaderName ?? 'لا يوجد إسم',
              committeeMembersCount: committeeModel.committeeMembers!.length,
            ),
            const TitleWidget(title: "اعضاء اللجنة"),
            Spaces.space10,
            CirlceImageAndTitleRowWidget(
              usersModels: committeeModel.committeeMembers!,
            ),
            Spaces.sectionsSpace40,
            ScheduleFeature(
              authorizedUsers: [
                ...committeeModel.committeeMembers!.map((e) => e.id!),
                committeeModel.committeeLeaderId!,
              ],
              path:
                  '${BackendEndpoints.committeesCollection}/${committeeModel.id}/${BackendEndpoints.schedulesCollection}',
            ),
            Spaces.inSectionSpace20,
          ],
        ),
      ),
    );
  }
}
