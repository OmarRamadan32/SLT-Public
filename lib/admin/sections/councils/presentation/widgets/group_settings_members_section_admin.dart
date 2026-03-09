import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';

import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/features/council/data/models/group_fields.dart';
import 'package:new_slt/admin/presentation/shared_widgets/choose_multible_members_widget_admin.dart';
import 'package:new_slt/admin/sections/councils/presentation/cubit/council_dashboard_cubit.dart';

class GroupSettingsMembersSection extends StatelessWidget {
  const GroupSettingsMembersSection({super.key});

  Future<void> addGroupMembers({required BuildContext context}) async {
    List<String> membersIds =
        context.read<UserCubit>().selectedUsers.map((e) => e.id!).toList();
    await context.read<CouncilDashboardCubit>().addGroupMembers(
      membersIds: membersIds,
    );
  }

  Future<void> removeGroupMembers({required BuildContext context}) async {
    List<String> membersIds =
        context.read<UserCubit>().selectedUsers.map((e) => e.id!).toList();
    await context.read<CouncilDashboardCubit>().removeGroupMembers(
      membersIds: membersIds,
    );
  }

  @override
  Widget build(BuildContext context) {
    CouncilDashboardCubit cubit = context.read<CouncilDashboardCubit>();
    final String searchPath =
        '${BackendEndpoints.councilCollection}/${cubit.council!.id}/${BackendEndpoints.groupsCollection}';
    return Column(
      children: [
        ChooseMultibleMembersWidgetAdmin(
          authorizedIds: [
            cubit.council!.councilLeaderId,
            cubit.council!.councilLeaderTwoId!,
            cubit.group!.groupLeaderId,
            cubit.group!.groupFemaleLeaderId,
            cubit.group!.groupCaptainId
            
          ],
          icon: FontAwesomeIcons.userPlus,
          cardTitle: "إضافة مرشحين",
          searchPath: BackendEndpoints.usersCollection,
          isNewUsers: true,
          onSavedFunction: () {
            addGroupMembers(context: context);
          },
        ),
        ChooseMultibleMembersWidgetAdmin(
                    authorizedIds: [
            cubit.council!.councilLeaderId,
            cubit.council!.councilLeaderTwoId!,
            cubit.group!.groupLeaderId,
            cubit.group!.groupFemaleLeaderId,
            cubit.group!.groupCaptainId
            
          ],
          icon: FontAwesomeIcons.userMinus,
          cardTitle: "إستبعاد مرشحين",
          searchPath: searchPath,
          searchDocument: cubit.group!.id,
          searchField: GroupFields.groupMembers,
          onSavedFunction: () {
            removeGroupMembers(context: context);
          },
        ),
      ],
    );
  }
}
