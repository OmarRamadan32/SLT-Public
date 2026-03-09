import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/core/widgets/loading_widget.dart';
import 'package:new_slt/core/widgets/title_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_screen_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_sec_card.dart';
import 'package:new_slt/admin/sections/campaigns/presentation/cubit/campaign_dashboard_cubit.dart';
import 'package:new_slt/admin/sections/campaigns/presentation/widgets/campaign_settings_campaign_section.dart';

class CampaignSettingsAdminPage extends StatefulWidget {
  const CampaignSettingsAdminPage({super.key, required this.campaignId});
  final String campaignId;

  @override
  State<CampaignSettingsAdminPage> createState() =>
      _CampaignSettingsAdminPageState();
}

class _CampaignSettingsAdminPageState extends State<CampaignSettingsAdminPage> {
  @override
  void initState() {
    context.read<CampaignDashbaordCubit>().getCampaignAndActivitiesById(
      campaignId: widget.campaignId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CampaignDashbaordCubit campaignDashbaordCubit =
        context.read<CampaignDashbaordCubit>();
    return DashboardScreenWidget(
      appBarTitle: "إدارة الحملة",
      child: BlocConsumer<CampaignDashbaordCubit, CampaignDashboardState>(
        builder: (context, state) {
          if (state is CampaignDashboardLoadingState) {
            return const LoadingWidget(isCentered: true);
          } else if (state is CampaignDashboardErrorState) {
            return ErrorMessageWidget(isCentered: true, message: state.error);
          } else {
            return Column(
              children: [
                CampaignSettingsCampaignSection(campaignId: widget.campaignId),
                Spaces.sectionsSpace40,
                const TitleWidget(title: "انشطة الحملة"),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: campaignDashbaordCubit.activities.length,
                  itemBuilder: (context, index) {
                    return DashboardSecCard(
                      authorizedIds: [],
                      onTap: () {
                        context.pushReplacement(
                          '${AppRouter.kCampaignActivitySettingsAdminPage}/${campaignDashbaordCubit.activities[index].id}',
                        );
                      },
                      title:
                          campaignDashbaordCubit.activities[index].activityName,
                    );
                  },
                ),
              ],
            );
          }
        },
        listener: (context, state) {
          if (state is CampaignDashboardErrorState) {
            context.read<UserCubit>().reset();
            Helpers.showSnackBar(context, state.error, isFailureMessage: true);
          }
          if (state is CampaignDashboardLeaderChangedState) {
            context.read<UserCubit>().reset();
            Helpers.showSnackBar(
              context,
              "تم تغيير مسؤول الحملة بنجاح",
              isSuccessMessage: true,
            );
            context.read<CampaignDashbaordCubit>().getCampaignAndActivitiesById(
              campaignId: widget.campaignId,
            );
          }
        },
      ),
    );
  }
}
