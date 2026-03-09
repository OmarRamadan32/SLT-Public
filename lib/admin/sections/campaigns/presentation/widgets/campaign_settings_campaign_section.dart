import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/constants/constants.dart';
import 'package:new_slt/core/widgets/details_box_widget.dart';

import 'package:new_slt/core/widgets/small_note_widget.dart';
import 'package:new_slt/admin/data/models/schedule_feature_page_admin_model.dart';
import 'package:new_slt/admin/presentation/shared_widgets/choose_member_widget_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_sec_card.dart';
import 'package:new_slt/admin/presentation/shared_widgets/schedule_feature_widget_admin.dart';
import 'package:new_slt/admin/sections/campaigns/presentation/cubit/campaign_dashboard_cubit.dart';
import 'package:new_slt/features/campaigns/data/models/campaign_fields.dart';

class CampaignSettingsCampaignSection extends StatelessWidget {
  const CampaignSettingsCampaignSection({super.key, required this.campaignId});
  final String campaignId;

  Future<void> changeCampaignLeader(
    BuildContext context, {
    required String newCampaignLeaderId,
    required String newCampaignLeaderIdFieldName,
    required String newCampaignLeaderNameFieldName,
  }) async {
    UserCubit userCubit = context.read<UserCubit>();
    CampaignDashbaordCubit campaignDashbaordCubit =
        context.read<CampaignDashbaordCubit>();
    await campaignDashbaordCubit.changeCampaignLeader(
      newCampaignLeaderIdFieldName: newCampaignLeaderIdFieldName,
      newCampaignLeaderNameFieldName: newCampaignLeaderNameFieldName,
      newCampaignLeaderId: userCubit.selectedUser!.id!,
      newCampaignLeaderName: userCubit.selectedUser!.name,
    );
    userCubit.reset();
  }

  @override
  Widget build(BuildContext context) {
    CampaignDashbaordCubit campaignDashbaordCubit =
        context.read<CampaignDashbaordCubit>();

    return Column(
      children: [
        DashboardSecCard(
          authorizedIds: [campaignDashbaordCubit.campaign!.campaignLeaderId],
          icon: FontAwesomeIcons.folderPlus,
          onTap: () {
            (context).pushReplacement(
              '${AppRouter.kAddActivityAdminPage}/$campaignId',
            );
          },
          title: "إضافة نشاط",
        ),
        ScheduleFeatureWidgetAdmin(
          authorizedIds: [campaignDashbaordCubit.campaign!.campaignLeaderId],
          scheduleFeaturePageAdminModel: ScheduleFeaturePageAdminModel(
            isTeamSchedule: false,
            scheduleAuthorName:
                campaignDashbaordCubit.campaign?.campaignLeaderName,
            scheduleMembersIds:
                campaignDashbaordCubit.campaign?.campaignMembersModels
                    .map((e) => e.id!)
                    .toList(),
            scheduleMembersTokens:
                campaignDashbaordCubit.campaign?.campaignMembersModels
                    .map((e) => e.token)
                    .toList(),
            scheduleType: "اجتماع حملة",
          ),
          path:
              "${BackendEndpoints.campaignsCollection}/$campaignId/${BackendEndpoints.schedulesCollection}",
        ),
        ChooseMemberWidgetAdmin(
          requiredAccessLevel: Constants.adminAccessLevel,
          icon: FontAwesomeIcons.userPen,
          cardTitle: "تغيير مسؤول الحملة",
          onSavedFunction: () {
            changeCampaignLeader(
              context,
              newCampaignLeaderIdFieldName: CampaignFields.campaignLeaderId,
              newCampaignLeaderNameFieldName: CampaignFields.campaignLeaderName,
              newCampaignLeaderId: context.read<UserCubit>().selectedUser!.id!,
            );
          },
          searchPath: BackendEndpoints.usersCollection,
        ),
        SmallNoteWidget(
          content:
              "المسؤول الحالي هو : ${campaignDashbaordCubit.campaign?.campaignLeaderName}",
        ),
        ChooseMemberWidgetAdmin(
          requiredAccessLevel: Constants.adminAccessLevel,
          icon: FontAwesomeIcons.userPen,
          cardTitle: "تغيير المسؤول الثاني للحملة",
          onSavedFunction: () {
            changeCampaignLeader(
              context,
              newCampaignLeaderIdFieldName: CampaignFields.campaignLeaderTwoId,
              newCampaignLeaderNameFieldName:
                  CampaignFields.campaignLeaderTwoName,
              newCampaignLeaderId: context.read<UserCubit>().selectedUser!.id!,
            );
          },
          searchPath: BackendEndpoints.usersCollection,
        ),
        SmallNoteWidget(
          content:
              "المسؤول الحالي هو : ${campaignDashbaordCubit.campaign!.campaignLeaderTwoName ?? "لا يوجد"}",
        ),
        const DetailsBoxWidget(
          content:
              "إن لم يكن هناك مسؤول ثاني للحملة سيتم إضافة من اخترته كمسؤول عند الحفظ",
        ),
      ],
    );
  }
}
