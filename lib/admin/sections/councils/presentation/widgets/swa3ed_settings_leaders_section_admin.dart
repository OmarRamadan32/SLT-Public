import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/widgets/small_note_widget.dart';
import 'package:new_slt/features/council/data/models/swa3ed_fields.dart';
import 'package:new_slt/features/council/data/models/swa3ed_model.dart';
import 'package:new_slt/admin/presentation/shared_widgets/choose_member_widget_admin.dart';
import 'package:new_slt/admin/sections/councils/presentation/cubit/council_dashboard_cubit.dart';

class Swa3edSettingsLeadersSection extends StatelessWidget {
  const Swa3edSettingsLeadersSection({super.key});

  Future<void> changeSwa3edLeader({
    required BuildContext context,
    required String newLeaderFieldName,
    required String newLeaderNameFieldName,
    required oldSwa3edLeaderId,
  }) async {
    final UserCubit userCubit = context.read<UserCubit>();
    context.read<CouncilDashboardCubit>().changeSwa3edLeader(
      oldSwa3edLeaderId: oldSwa3edLeaderId,
      newSwa3edLeaderId: userCubit.selectedUser!.id!,
      newLeaderFieldName: newLeaderFieldName,
      newLeaderNameFieldName: newLeaderNameFieldName,
      newSwa3edLeaderName: userCubit.selectedUser!.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Swa3edModel? swa3ed = context.read<CouncilDashboardCubit>().swa3ed;
    return Column(
      children: [
        ChooseMemberWidgetAdmin(
                    authorizedIds: [
          context.read<CouncilDashboardCubit>().council!.councilLeaderId,
          context.read<CouncilDashboardCubit>().council!.councilLeaderTwoId!
          ],
          icon: FontAwesomeIcons.userPen,
          cardTitle: "تغيير قائد السواعد",
          onSavedFunction: () {
            changeSwa3edLeader(
              oldSwa3edLeaderId: swa3ed!.swa3edLeaderId,
              newLeaderNameFieldName: Swa3edFields.swa3edLeaderName,
              context: context,
              newLeaderFieldName: Swa3edFields.swa3edLeaderId,
            );
          },
          searchPath: BackendEndpoints.usersCollection,
        ),
        SmallNoteWidget(
          content: "قائد السواعد الحالي هو: ${swa3ed!.swa3edLeaderName}",
        ),
        ChooseMemberWidgetAdmin(
                              authorizedIds: [
          context.read<CouncilDashboardCubit>().council!.councilLeaderId,
          context.read<CouncilDashboardCubit>().council!.councilLeaderTwoId!
          ],
          icon: FontAwesomeIcons.userPen,
          cardTitle: "تغيير مسؤولة السواعد",
          onSavedFunction: () {
            changeSwa3edLeader(
              oldSwa3edLeaderId: swa3ed.swa3edLeaderTwoId,
              newLeaderNameFieldName: Swa3edFields.swa3edLeaderTwoName,
              context: context,
              newLeaderFieldName: Swa3edFields.swa3edLeaderTwoId,
            );
          },
          searchPath: BackendEndpoints.usersCollection,
        ),
        SmallNoteWidget(
          content: "مسؤولة السواعد الحالية هي: ${swa3ed.swa3edLeaderTwoName}",
        ),
      ],
    );
  }
}
