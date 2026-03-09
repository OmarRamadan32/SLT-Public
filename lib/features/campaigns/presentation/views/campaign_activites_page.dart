import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/core/widgets/screen_widget/screen_widget.dart';
import 'package:new_slt/features/campaigns/data/models/campaign_model.dart';
import 'package:new_slt/features/campaigns/presentation/cubit/campaign_cubit.dart';
import 'package:new_slt/features/campaigns/presentation/views/campaign_activities_loading_view.dart';
import 'package:new_slt/features/campaigns/presentation/widgets/campaign_activities_page_activities_section.dart';
import 'package:new_slt/features/campaigns/presentation/widgets/campaign_activities_page_details_section.dart';
import 'package:new_slt/features/schedule/presentation/views/schedule_feature.dart';

class CampaignActivitesPage extends StatefulWidget {
  const CampaignActivitesPage({super.key, required this.campaignModel});
  final CampaignModel campaignModel;

  @override
  State<CampaignActivitesPage> createState() => _CampaignActivitesPageState();
}

class _CampaignActivitesPageState extends State<CampaignActivitesPage> {
  @override
  void initState() {
    context.read<CampaignCubit>().getCampaignActivities(
      campaignId: widget.campaignModel.id!,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CampaignCubit campaignCubit = context.read<CampaignCubit>();
    final ThemeData theme = Theme.of(context);
    return ScreenWidget(
      isMainScreen: false,
      child: BlocBuilder<CampaignCubit, CampaignState>(
        builder: (context, state) {
          if (state is CampaignLoadingState) {
            return const CampaignActivitiesLoadingView();
          } else if (state is CampaignActivitiesErrorState) {
            return ErrorMessageWidget(isCentered: true, message: state.message);
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Spaces.inSectionSpace20,
                  ScheduleFeature(
                    authorizedUsers: [
                      widget.campaignModel.campaignLeaderId,
                      widget.campaignModel.campaignLeaderTwoId!,
                      ...widget.campaignModel.campaignMembersModels.map(
                        (e) => e.id!,
                      ),
                    ],
                    path:
                        '${BackendEndpoints.campaignsCollection}/${widget.campaignModel.id}/${BackendEndpoints.schedulesCollection}',
                  ),
                  Spaces.sectionsSpace40,
                  SizedBox(
                    width: 200.w,
                    child: Divider(color: theme.primaryColor, thickness: 1.3),
                  ),
                  Spaces.space5,
                  CampaignActivitiesPageDetailsSection(
                    activitiesCount: campaignCubit.activities.length,
                    campaignLeaderOne: widget.campaignModel.campaignLeaderName,
                    campaignLeaderTwo:
                        widget.campaignModel.campaignLeaderTwoName,
                  ),
                  Spaces.sectionsSpace40,
                  CampaignActivitiesPageActivitiesSection(
                    campaignId: widget.campaignModel.id!,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
