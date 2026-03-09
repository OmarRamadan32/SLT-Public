import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/activity_image.dart';
import 'package:new_slt/core/widgets/circle_image_and_title_row_widget.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/core/widgets/screen_widget/screen_widget.dart';
import 'package:new_slt/core/widgets/title_widget.dart';
import 'package:new_slt/features/campaigns/presentation/cubit/campaign_cubit.dart';
import 'package:new_slt/features/campaigns/presentation/views/activity_page_loading_view.dart';
import 'package:new_slt/features/campaigns/presentation/widgets/activity_page_details_section.dart';
import 'package:new_slt/features/schedule/presentation/views/schedule_feature.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({
    super.key,
    required this.campaignId,
    required this.activityId,
  });
  final String campaignId;
  final String activityId;

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  void initState() {
    context.read<CampaignCubit>().getActivityById(
      activityId: widget.activityId,
      campaignId: widget.campaignId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CampaignCubit campaignCubit = context.read<CampaignCubit>();
    return ScreenWidget(
      isMainScreen: false,
      child: SingleChildScrollView(
        child: BlocBuilder<CampaignCubit, CampaignState>(
          builder: (context, state) {
            if (state is CampaignLoadingState) {
              return const ActivityPageLoadingView();
            } else if (state is CampaignActivityErrorState) {
              return ErrorMessageWidget(
                isCentered: true,
                message: state.message,
              );
            } else {
              final String schedulePath =
                  '${BackendEndpoints.campaignsCollection}/${widget.campaignId}/${BackendEndpoints.activitiesCollection}/${widget.activityId}/${BackendEndpoints.schedulesCollection}';
              return Column(
                children: [
                  Spaces.inSectionSpace20,
                  TitleWidget(title: campaignCubit.activityModel!.activityName),
                  Spaces.inSectionSpace20,
                  ActivityImage(
                    imageUrl: campaignCubit.activityModel!.activityImage,
                  ),
                  Spaces.inSectionSpace20,
                  ActivityPageDetailsSection(
                    activityModel: campaignCubit.activityModel!,
                  ),
                  Spaces.sectionsSpace40,
                  const TitleWidget(title: "اعضاء التيم"),
                  Spaces.space10,
                  CirlceImageAndTitleRowWidget(
                    usersModels: campaignCubit.activityModel!.activityMembers,
                  ),
                  Spaces.sectionsSpace40,
                  ScheduleFeature(
                    authorizedUsers: [
                      campaignCubit.activityModel!.activityLeaderId!,
                      campaignCubit.activityModel!.activityLeaderTwoId!,
                      ...campaignCubit.activityModel!.activityMembers!.map(
                        (e) => e.id!,
                      ),
                    ],
                    path: schedulePath,
                  ),
                  Spaces.inSectionSpace20,
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
