import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/features/council/data/models/swa3ed_fields.dart';
import 'package:new_slt/admin/presentation/shared_widgets/choose_multible_members_widget_admin.dart';
import 'package:new_slt/admin/sections/councils/presentation/cubit/council_dashboard_cubit.dart';

class Swa3edSettingsMembersSection extends StatelessWidget {
  const Swa3edSettingsMembersSection({super.key});

  Future<void> addSwa3edMembersFunction({required BuildContext context}) async {
    List<String> membersIds =
        context.read<UserCubit>().selectedUsers.map((e) => e.id!).toList();
    await context.read<CouncilDashboardCubit>().addSwa3edMembers(
      membersIds: membersIds,
    );
  }

  Future<void> removeSwa3edMembersFunction({
    required BuildContext context,
  }) async {
    List<String> membersIds =
        context.read<UserCubit>().selectedUsers.map((e) => e.id!).toList();
    await context.read<CouncilDashboardCubit>().removeSwa3edMembers(
      membersIds: membersIds,
    );
  }

  @override
  Widget build(BuildContext context) {
    final CouncilDashboardCubit cubit = context.read<CouncilDashboardCubit>();
    return Column(
      children: [
        ChooseMultibleMembersWidgetAdmin(
          authorizedIds: [
            cubit.council!.councilLeaderId,
            cubit.council!.councilLeaderTwoId!,
            cubit.swa3ed!.swa3edLeaderId,
            cubit.swa3ed!.swa3edLeaderTwoId
          ],
          icon: FontAwesomeIcons.userPlus,
          cardTitle: "إضافة أعضاء للسواعد",
          searchPath: BackendEndpoints.usersCollection,
          onSavedFunction: () {
            addSwa3edMembersFunction(context: context);
          },
        ),
        ChooseMultibleMembersWidgetAdmin(
                    authorizedIds: [
            cubit.council!.councilLeaderId,
            cubit.council!.councilLeaderTwoId!,
            cubit.swa3ed!.swa3edLeaderId,
            cubit.swa3ed!.swa3edLeaderTwoId
          ],
          icon: FontAwesomeIcons.userMinus,
          cardTitle: "حذف أعضاء من السواعد",
          searchPath:
              '${BackendEndpoints.councilCollection}/${cubit.council!.id}/${BackendEndpoints.swa3edCollection}',
          onSavedFunction: () {
            removeSwa3edMembersFunction(context: context);
          },
          searchDocument: cubit.swa3ed!.id,
          searchField: Swa3edFields.swa3edMembers,
        ),
      ],
    );
  }
}
