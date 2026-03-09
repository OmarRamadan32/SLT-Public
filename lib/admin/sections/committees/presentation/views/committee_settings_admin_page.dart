// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/constants/constants.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/core/widgets/loading_widget.dart';
import 'package:new_slt/core/widgets/small_note_widget.dart';
import 'package:new_slt/admin/data/models/schedule_feature_page_admin_model.dart';
import 'package:new_slt/admin/presentation/shared_widgets/schedule_feature_widget_admin.dart';
import 'package:new_slt/features/committees/data/models/committee_fields.dart';
import 'package:new_slt/admin/presentation/shared_widgets/choose_member_widget_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/choose_multible_members_widget_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_screen_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_sec_card.dart';
import 'package:new_slt/admin/sections/committees/presentation/cubit/committee_dashboard_cubit.dart';

class CommitteeSettingsAdminPage extends StatefulWidget {
  const CommitteeSettingsAdminPage({super.key, required this.committeeId});
  final String committeeId;

  @override
  State<CommitteeSettingsAdminPage> createState() =>
      _CommitteeSettingsAdminPageState();
}

class _CommitteeSettingsAdminPageState
    extends State<CommitteeSettingsAdminPage> {
  @override
  void initState() {
    context.read<CommitteeDashboardCubit>().getCommitteeById(
      committeeId: widget.committeeId,
    );
    super.initState();
  }

  Future<void> addCommitteeMembers() async {
    List<String> membersIDSList =
        context.read<UserCubit>().selectedUsers.map((e) => e.id!).toList();
    context.read<CommitteeDashboardCubit>().addCommitteeMembers(
      membersIDSList: membersIDSList,
    );
  }

  Future<void> removeCommitteeMembers() async {
    List<String> membersIDSList =
        context.read<UserCubit>().selectedUsers.map((e) => e.id!).toList();
    context.read<CommitteeDashboardCubit>().removeCommitteeMembers(
      membersIDSList: membersIDSList,
      committeeId: widget.committeeId,
    );
  }

  Future<void> changeCommitteeLeader() async {
    context.read<CommitteeDashboardCubit>().changeCommitteeLeader(
      newLeaderName: context.read<UserCubit>().selectedUser!.name,
      newLeaderId: context.read<UserCubit>().selectedUser!.id!,
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    CommitteeDashboardCubit committeeCubit =
        context.read<CommitteeDashboardCubit>();
    // ignore: unused_local_variable
    final String schedulePath =
        '${BackendEndpoints.committeesCollection}/${widget.committeeId}/${BackendEndpoints.schedulesCollection}';
    return DashboardScreenWidget(
      appBarTitle: "إعدادات اللجنة",
      child: BlocConsumer<CommitteeDashboardCubit, CommitteeDashboardState>(
        builder: (context, state) {
          if (state is CommitteeDashboardLoadingState) {
            return const LoadingWidget(isCentered: true);
          } else if (state is CommitteeDashboardErrorState) {
            return ErrorMessageWidget(message: state.message);
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ChooseMultibleMembersWidgetAdmin(
                  icon: FontAwesomeIcons.userPlus,
                  cardTitle: "اضافة اعضاء",
                  searchPath: BackendEndpoints.usersCollection,
                  onSavedFunction: () {
                    addCommitteeMembers();
                  },
                ),
                ChooseMultibleMembersWidgetAdmin(
                  icon: FontAwesomeIcons.userMinus,
                  cardTitle: "حذف اعضاء",
                  searchPath: BackendEndpoints.committeesCollection,
                  onSavedFunction: () {
                    removeCommitteeMembers();
                  },
                  searchDocument: widget.committeeId,
                  searchField: CommitteeFields.committeeMembers,
                ),
                ChooseMemberWidgetAdmin(
                  requiredAccessLevel: Constants.adminAccessLevel,
                  icon: FontAwesomeIcons.userPen,
                  cardTitle: "تغيير مسؤول اللجنة",
                  onSavedFunction: () {
                    changeCommitteeLeader();
                  },
                  searchPath: BackendEndpoints.usersCollection,
                ),
                SmallNoteWidget(
                  content:
                      'مسؤول اللجنة الحالي هو ${committeeCubit.committeeModel!.committeeLeaderName}',
                ),
                DashboardSecCard(
                  icon: FontAwesomeIcons.penToSquare,
                  onTap: () {
                    context.pushReplacement(
                      AppRouter.kUpdateCommitteeDetailsAdminPage,
                      extra: committeeCubit.committeeModel,
                    );
                  },
                  title: "تغيير تفاصيل اللجنة",
                ),
                const SmallNoteWidget(
                  alignment: Alignment.centerRight,
                  content:
                      "تفاصيل اللجنة هي: صورة اللجنة, إسم اللجنة, وصف اللجنة.",
                ),
                ScheduleFeatureWidgetAdmin(
                  scheduleFeaturePageAdminModel: ScheduleFeaturePageAdminModel(
                    scheduleAuthorName:
                        committeeCubit.committeeModel!.committeeLeaderName,
                    scheduleType: 'اجتماع لجنة',
                    scheduleMembersIds:
                        committeeCubit.committeeModel!.committeeMembers!
                            .map((e) => e.id!)
                            .toList(),
                    scheduleMembersTokens:
                        committeeCubit.committeeModel!.committeeMembers!
                            .map((e) => e.token)
                            .toList(),
                    isTeamSchedule: false,
                  ),
                  path: schedulePath,
                ),
              ],
            );
          }
        },
        listener: (context, state) {
          if (state is CommitteeDashboardleaderChangedState) {
            context.read<UserCubit>().reset();
            Helpers.showSnackBar(context, "تم تغيير مسؤول اللجنة");
            context.read<CommitteeDashboardCubit>().getCommitteeById(
              committeeId: widget.committeeId,
            );
          } else if (state is CommitteeDashboardMembersUpdatedState) {
            Helpers.showSnackBar(context, "تم تحديث قائمة اعضاء اللجنة بنجاح");
          } else if (state is CommitteeDashboardErrorState) {
            Helpers.showSnackBar(context, "فشلت العملية");
          }
        },
      ),
    );
  }
}
