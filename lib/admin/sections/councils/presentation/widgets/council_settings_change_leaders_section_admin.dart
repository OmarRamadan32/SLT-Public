import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/constants/constants.dart';
import 'package:new_slt/core/widgets/small_note_widget.dart';
import 'package:new_slt/features/council/data/models/council_fields.dart';
import 'package:new_slt/admin/presentation/shared_widgets/choose_member_widget_admin.dart';
import 'package:new_slt/admin/sections/councils/presentation/cubit/council_dashboard_cubit.dart';

class CouncilSettingsChangeLeadersSectionAdmin extends StatelessWidget {
  const CouncilSettingsChangeLeadersSectionAdmin({super.key});

  void changeCouncilLeaderFunction({
    required BuildContext context,
    required String newCouncilLeaderId,
    required String newLeaderIdFieldName,
    required String newLeaderNameFieldName,
    required String newCouncilLeaderName,
    
  }) {
    context.read<CouncilDashboardCubit>().changeCouncilLeader(
      newCouncilLeaderId: newCouncilLeaderId,
      newLeaderIdFieldName: newLeaderIdFieldName,
      newLeaderNameFieldName: newLeaderNameFieldName,
      newCouncilLeaderName: newCouncilLeaderName,
    );
  }

  @override
  Widget build(BuildContext context) {
    final CouncilDashboardCubit cubit = context.read<CouncilDashboardCubit>();
    final UserCubit userCubit = context.read<UserCubit>();
    return Column(
      children: [
        ChooseMemberWidgetAdmin(
          requiredAccessLevel: Constants.adminAccessLevel,
          icon: FontAwesomeIcons.userPen,
          cardTitle: "تغيير قائد المجلس",
          onSavedFunction: () {
            changeCouncilLeaderFunction(
              context: context,
              newCouncilLeaderId: userCubit.selectedUser!.id!,
              newLeaderIdFieldName: CouncilFields.councilLeaderId,
              newLeaderNameFieldName: CouncilFields.councilLeaderName,
              newCouncilLeaderName: userCubit.selectedUser!.name,
            );
          },
          userNumber: 1,
          searchPath: BackendEndpoints.usersCollection,
        ),
        SmallNoteWidget(
          content:
              "قائد المجلس الحالي هو: ${cubit.council!.councilLeaderName}",
        ),
        ChooseMemberWidgetAdmin(
          requiredAccessLevel: Constants.adminAccessLevel,
          icon: FontAwesomeIcons.userPen,
          cardTitle: "تغيير المسؤول الثاني للمجلس ",
          userNumber: 2,
          onSavedFunction: () {
            changeCouncilLeaderFunction(
              context: context,
              newCouncilLeaderId: userCubit.selectedUserTwo!.id!,
              newLeaderIdFieldName: CouncilFields.councilLeaderTwoId,
              newLeaderNameFieldName: CouncilFields.councilLeaderTwoName,
              newCouncilLeaderName: userCubit.selectedUserTwo!.name,
            );
          },
          searchPath: BackendEndpoints.usersCollection,
        ),
        SmallNoteWidget(
          content:
              "المسؤول الثاني للمجلس هو : ${cubit.council!.councilLeaderTwoName ?? "غير متوفر"}",
        ),
      ],
    );
  }
}
