import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/widgets/small_note_widget.dart';
import 'package:new_slt/features/council/data/models/group_fields.dart';
import 'package:new_slt/features/council/data/models/group_model.dart';
import 'package:new_slt/admin/presentation/shared_widgets/choose_member_widget_admin.dart';
import 'package:new_slt/admin/sections/councils/presentation/cubit/council_dashboard_cubit.dart';

class GroupSettingsLeadersSection extends StatelessWidget {
  const GroupSettingsLeadersSection({super.key});

  Future<void> changeGroupLeader({
    required BuildContext context,
    required String newLeaderFieldName,
    required String newLeaderNameFieldName,
    required String oldGroupLeaderId,
  }) async {
    final UserCubit userCubit = context.read<UserCubit>();
    await context.read<CouncilDashboardCubit>().changeGroupLeader(
      oldGroupLeaderId: oldGroupLeaderId,
      newGroupLeaderName: userCubit.selectedUser!.name,
      newLeaderNameFieldName: newLeaderNameFieldName,
      newGroupLeaderId: userCubit.selectedUser!.id!,
      newLeaderFieldName: newLeaderFieldName,
    );
  }

  @override
  Widget build(BuildContext context) {
    GroupModel group = context.read<CouncilDashboardCubit>().group!;
    return Column(
      children: [
        ChooseMemberWidgetAdmin(
          authorizedIds: [
            context.read<CouncilDashboardCubit>().council!.councilLeaderId,
            context.read<CouncilDashboardCubit>().council!.councilLeaderTwoId!
          ],
          icon: FontAwesomeIcons.one,
          cardTitle: "تغيير قائد المجموعة",
          onSavedFunction: () {
            changeGroupLeader(
              oldGroupLeaderId: group.groupLeaderId,
              newLeaderNameFieldName: GroupFields.groupLeaderName,
              context: context,
              newLeaderFieldName: GroupFields.groupLeaderId,
            );
          },
          searchPath: BackendEndpoints.usersCollection,
        ),
        SmallNoteWidget(
          content: 'قائد المجموع الحالي هو: ${group.groupLeaderName}',
        ),
        ChooseMemberWidgetAdmin(
                    authorizedIds: [
            context.read<CouncilDashboardCubit>().council!.councilLeaderId,
            context.read<CouncilDashboardCubit>().council!.councilLeaderTwoId!
          ],
          icon: FontAwesomeIcons.two,
          cardTitle: "تغيير مسؤولة المجموعة",
          onSavedFunction: () {
            changeGroupLeader(
              oldGroupLeaderId: group.groupFemaleLeaderId,
              newLeaderNameFieldName: GroupFields.groupFemaleLeaderName,
              context: context,
              newLeaderFieldName: GroupFields.groupFemaleLeaderId,
            );
          },
          searchPath: BackendEndpoints.usersCollection,
        ),
        SmallNoteWidget(
          content: 'مسؤولة المجموع الحالية هي: ${group.groupFemaleLeaderName}',
        ),
        ChooseMemberWidgetAdmin(
                    authorizedIds: [
            context.read<CouncilDashboardCubit>().council!.councilLeaderId,
            context.read<CouncilDashboardCubit>().council!.councilLeaderTwoId!
          ],
          icon: FontAwesomeIcons.three,
          cardTitle: "تغيير رائد المجموعة",
          onSavedFunction: () {
            changeGroupLeader(
              oldGroupLeaderId: group.groupCaptainId,
              newLeaderNameFieldName: GroupFields.groupCaptainName,
              context: context,
              newLeaderFieldName: GroupFields.groupCaptainId,
            );
          },
          searchPath: BackendEndpoints.usersCollection,
        ),
        SmallNoteWidget(
          content: 'رائد المجموع الحالي هو: ${group.groupCaptainName}',
        ),
      ],
    );
  }
}
