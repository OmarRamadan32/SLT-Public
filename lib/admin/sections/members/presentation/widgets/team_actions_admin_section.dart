import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/constants/constants.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/title_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/choose_member_widget_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_sec_card.dart';
import 'package:new_slt/admin/sections/members/presentation/cubits/members_cubit/members_dashboard_cubit.dart';

class TeamActionsAdminSection extends StatelessWidget {
  const TeamActionsAdminSection({super.key});

  Future<void> chooseAssistantTeamLeaderFunction(BuildContext context) async {
    UserCubit userCubit = context.read<UserCubit>();
    final String newLeaderId = userCubit.selectedUser!.id!;
    final String newLeaderToken = userCubit.selectedUser!.token;
    await context.read<MembersDashboardCubit>().chooseAssistantTeamLeader(
      newLeaderId: newLeaderId,
      leaderToken: newLeaderToken,
    );
  }

  Future<void> removeAssistantTeamLeaderFunction(BuildContext context) async {
    await context.read<MembersDashboardCubit>().removeAssistantTeamLeader();
  }

  Future<void> chooseViceTeamLeaderFunction(BuildContext context) async {
    UserCubit userCubit = context.read<UserCubit>();
    final String newLeaderId = userCubit.selectedUser!.id!;
    final String newLeaderToken = userCubit.selectedUser!.token;
    await context.read<MembersDashboardCubit>().chooseViceTeamLeader(
      newLeaderId: newLeaderId,
      leaderToken: newLeaderToken,
    );
  }

  Future<void> removeViceTeamLeaderFunction(BuildContext context) async {
    await context.read<MembersDashboardCubit>().removeViceTeamLeader();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(width: 250.w, child: const Divider()),
        Spaces.inSectionSpace20,
        const TitleWidget(title: "الهيكل القيادي"),
        Spaces.space10,
        ChooseMemberWidgetAdmin(
          requiredAccessLevel: Constants.adminAccessLevel,
          cardTitle: "اختيار مساعد قائد فريق",
          icon: FontAwesomeIcons.userPen,
          onSavedFunction: () {
            chooseAssistantTeamLeaderFunction(context);
          },
          searchPath: BackendEndpoints.usersCollection,
        ),
        DashboardSecCard(
          requiredAccessLevel: Constants.adminAccessLevel,
          icon: FontAwesomeIcons.userSlash,
          onTap: () {
            removeAssistantTeamLeaderFunction(context);
          },
          title: "حل مساعد قائد الفريق",
        ),
        ChooseMemberWidgetAdmin(
          requiredAccessLevel: Constants.adminAccessLevel,
          icon: FontAwesomeIcons.userPen,
          cardTitle: "اختيار نائب قائد فريق",
          onSavedFunction: () {
            chooseViceTeamLeaderFunction(context);
          },
          searchPath: BackendEndpoints.usersCollection,
        ),
        DashboardSecCard(
          requiredAccessLevel: Constants.adminAccessLevel,
          icon: FontAwesomeIcons.userSlash,
          onTap: () {
            removeViceTeamLeaderFunction(context);
          },
          title: "حل نائب قائد الفريق",
        ),
      ],
    );
  }
}
