import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FontAwesomeIcons;
import 'package:go_router/go_router.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/core/widgets/loading_widget.dart';
import 'package:new_slt/core/widgets/small_note_widget.dart';
import 'package:new_slt/admin/data/models/schedule_feature_page_admin_model.dart';
import 'package:new_slt/admin/presentation/shared_widgets/schedule_feature_widget_admin.dart';
import 'package:new_slt/features/campaigns/data/models/activity_fielda.dart';
import 'package:new_slt/admin/presentation/shared_widgets/choose_member_widget_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/choose_multible_members_widget_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_screen_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_sec_card.dart';
import 'package:new_slt/admin/sections/campaigns/presentation/cubit/campaign_dashboard_cubit.dart';

class CampaignActivitySettingsAdminPage extends StatefulWidget {
  const CampaignActivitySettingsAdminPage({
    super.key,
    required this.activityId,
  });

  final String activityId;
  @override
  State<CampaignActivitySettingsAdminPage> createState() =>
      _CampaignActivitySettingsAdminPageState();
}

class _CampaignActivitySettingsAdminPageState
    extends State<CampaignActivitySettingsAdminPage> {
  @override
  void initState() {
    context.read<CampaignDashbaordCubit>().getCampaignActivityById(
      activityId: widget.activityId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DashboardScreenWidget(
      appBarTitle: "إدارة النشاط",
      child: BlocConsumer<CampaignDashbaordCubit, CampaignDashboardState>(
        builder: (context, state) {
          UserCubit userCubit = context.read<UserCubit>();
          if (state is CampaignDashboardLoadingState) {
            return const LoadingWidget(isCentered: true);
          } else if (state is CampaignDashboardErrorState) {
            return ErrorMessageWidget(isCentered: true, message: state.error);
          } else {
            CampaignDashbaordCubit campaignDashbaordCubit =
                context.read<CampaignDashbaordCubit>();
            final String schedulePath =
                '${BackendEndpoints.campaignsCollection}/${campaignDashbaordCubit.campaign!.id}/${BackendEndpoints.activitiesCollection}/${widget.activityId}/${BackendEndpoints.schedulesCollection}';
            return Column(
              children: [
                ChooseMultibleMembersWidgetAdmin(
                  authorizedIds: [
                    campaignDashbaordCubit.campaign!.campaignLeaderId,
                    campaignDashbaordCubit.activity!.activityLeaderId!,
                    campaignDashbaordCubit.campaign!.campaignLeaderTwoId!,
                  ],
                  icon: FontAwesomeIcons.userPlus,
                  cardTitle: "إضافة اعضاء للتيم",
                  searchPath: BackendEndpoints.usersCollection,
                  onSavedFunction: () {
                    campaignDashbaordCubit.addActivityMembers(
                      membersIds:
                          userCubit.selectedUsers.map((e) => e.id!).toList(),
                    );
                  },
                ),
                ChooseMultibleMembersWidgetAdmin(
                  authorizedIds: [
                    campaignDashbaordCubit.campaign!.campaignLeaderId,
                    campaignDashbaordCubit.activity!.activityLeaderId!,
                    campaignDashbaordCubit.campaign!.campaignLeaderTwoId!,
                  ],
                  icon: FontAwesomeIcons.userMinus,
                  cardTitle: "إزالة اعضاء من التيم",
                  searchPath:
                      '${BackendEndpoints.campaignsCollection}/${campaignDashbaordCubit.campaign!.id}/${BackendEndpoints.activitiesCollection}',
                  searchDocument: widget.activityId,
                  searchField: ActivityFields.activityMembers,
                  onSavedFunction: () {
                    campaignDashbaordCubit.removeActivityMembers(
                      membersIds:
                          userCubit.selectedUsers.map((e) => e.id!).toList(),
                    );
                  },
                ),
                ChooseMemberWidgetAdmin(
                  authorizedIds: [
                    campaignDashbaordCubit.campaign!.campaignLeaderId,
                  ],
                  icon: FontAwesomeIcons.one,
                  cardTitle: "تغيير مسؤول النشاط",
                  onSavedFunction: () {
                    campaignDashbaordCubit.changeActivityLeader(
                      newActivityLeaderIdFieldName:
                          ActivityFields.activityLeaderId,
                      newActivityLeaderName: userCubit.selectedUser!.name,
                      newActivityLeaderNameFieldName:
                          ActivityFields.activityLeaderName,
                      oldActivityLeaderId:
                          campaignDashbaordCubit.activity!.activityLeaderId!,
                      newActivityLeaderId: userCubit.selectedUser!.id!,
                    );
                  },

                  searchPath: BackendEndpoints.usersCollection,
                ),
                SmallNoteWidget(
                  content:
                      'المسؤول الحالي هو : ${campaignDashbaordCubit.activity!.activityLeaderName}',
                ),
                ChooseMemberWidgetAdmin(
                  authorizedIds: [
                    campaignDashbaordCubit.campaign!.campaignLeaderId,
                  ],
                  icon: FontAwesomeIcons.two,
                  userNumber: 2,
                  cardTitle: "تغيير المسؤول الثاني للنشاط ",
                  onSavedFunction: () {
                    campaignDashbaordCubit.changeActivityLeader(
                      newActivityLeaderIdFieldName:
                          ActivityFields.activityLeaderTwoId,
                      newActivityLeaderName: userCubit.selectedUserTwo!.name,
                      newActivityLeaderNameFieldName:
                          ActivityFields.activityLeaderTwoName,
                      oldActivityLeaderId:
                          campaignDashbaordCubit.activity!.activityLeaderId!,
                      newActivityLeaderId: userCubit.selectedUserTwo!.id!,
                    );
                  },
                  searchPath: BackendEndpoints.usersCollection,
                ),
                SmallNoteWidget(
                  content:
                      'المسؤول الثاني هو : ${campaignDashbaordCubit.activity!.activityLeaderTwoName ?? "لا يوجد"}',
                ),
                ScheduleFeatureWidgetAdmin(
                  authorizedIds: [
                    campaignDashbaordCubit.campaign!.campaignLeaderId,
                    campaignDashbaordCubit.activity!.activityLeaderId!,
                    campaignDashbaordCubit.campaign!.campaignLeaderTwoId!,
                  ],
                  scheduleFeaturePageAdminModel: ScheduleFeaturePageAdminModel(
                    isTeamSchedule: true,
                    scheduleType: "موعد عام",
                    scheduleAuthorName: userCubit.userModel!.name,
                  ),
                  path: BackendEndpoints.schedulesCollection,
                ),

                const SmallNoteWidget(
                  content:
                      "من خلال الموعد العام, يمكنك إضافة مواعيد نشاطك وسيظهر في الصفحة الرئيسية لجميع اعضاء الفريق لتسجيل الحضور فيه",
                ),
                ScheduleFeatureWidgetAdmin(
                  authorizedIds: [
                    campaignDashbaordCubit.campaign!.campaignLeaderId,
                    campaignDashbaordCubit.activity!.activityLeaderId!,
                    campaignDashbaordCubit.campaign!.campaignLeaderTwoId!,
                  ],
                  scheduleFeaturePageAdminModel: ScheduleFeaturePageAdminModel(
                    isTeamSchedule: false,
                    scheduleAuthorName: userCubit.userModel!.name,
                    scheduleMembersIds:
                        campaignDashbaordCubit.activity!.activityMembers!
                            .map((e) => e.id!)
                            .toList(),
                    scheduleMembersTokens:
                        campaignDashbaordCubit.activity!.activityMembers!
                            .map((e) => e.token)
                            .toList(),
                    scheduleType: "إجتماع نشاط",
                  ),
                  path: schedulePath,
                ),

                DashboardSecCard(
                  authorizedIds: [
                    campaignDashbaordCubit.campaign!.campaignLeaderId,
                    campaignDashbaordCubit.activity!.activityLeaderId!,
                    campaignDashbaordCubit.campaign!.campaignLeaderTwoId!,
                  ],
                  icon: FontAwesomeIcons.penToSquare,
                  onTap: () {
                    context.pushReplacement(
                      AppRouter.kUpdateActivityDetailsAdminPage,
                      extra: campaignDashbaordCubit.activity,
                    );
                  },
                  title: "تحديث بيانات النشاط",
                ),
              ],
            );
          }
        },
        listener: (context, state) {
          if (state is CamapaignDashboardMembersUpdatedState) {
            Helpers.showSnackBar(
              context,
              "تم تحديث قائمة اعضاء تيم النشاط بنجاح",
              isSuccessMessage: true,
            );
          }
          if (state is CampaignDashboardErrorState) {
            Helpers.showSnackBar(context, state.error, isFailureMessage: true);
          }
          if (state is CampaignDashboardLeaderChangedState) {
            context.read<UserCubit>().reset();
            Helpers.showSnackBar(
              context,
              "تم تغيير مسؤول النشاط بنجاح",
              isSuccessMessage: true,
            );
            context.read<CampaignDashbaordCubit>().getCampaignActivityById(
              activityId: widget.activityId,
            );
          }
        },
      ),
    );
  }
}
