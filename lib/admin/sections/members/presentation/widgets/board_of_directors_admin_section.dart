import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_slt/features/user/data/models/user_fields.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/constants/constants.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/title_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/choose_multible_members_widget_admin.dart';
import 'package:new_slt/admin/sections/members/presentation/cubits/members_cubit/members_dashboard_cubit.dart';

class BoardOfDirectorsAdminSection extends StatelessWidget {
  const BoardOfDirectorsAdminSection({super.key});

  Future<void> addMembersToMainBoardFunction(BuildContext context) async {
    UserCubit userCubit = context.read<UserCubit>();
    List<String> newMembersIds =
        userCubit.selectedUsers.map((e) => e.id!).toList();
    List<String> newMembersTokens =
        userCubit.selectedUsers.map((e) => e.token).toList();
    await context.read<MembersDashboardCubit>().addMembersToMainBoard(
      membersIds: newMembersIds,
      membersTokens: newMembersTokens,
    );
  }

  Future<void> addMembersToSubBoardFunction(BuildContext context) async {
    UserCubit userCubit = context.read<UserCubit>();
    List<String> newMembersIds =
        userCubit.selectedUsers.map((e) => e.id!).toList();
    List<String> newMembersTokens =
        userCubit.selectedUsers.map((e) => e.token).toList();
    await context.read<MembersDashboardCubit>().addMembersToSubBoard(
      membersIds: newMembersIds,
      membersTokens: newMembersTokens,
    );
  }

  Future<void> removeMembersFromMainBoardFunction(BuildContext context) async {
    UserCubit userCubit = context.read<UserCubit>();
    List<String> newMembersIds =
        userCubit.selectedUsers.map((e) => e.id!).toList();
    List<String> newMembersTokens =
        userCubit.selectedUsers.map((e) => e.token).toList();
    await context.read<MembersDashboardCubit>().removeMembersFromMainBoard(
      membersIds: newMembersIds,
      membersTokens: newMembersTokens,
    );
  }

  Future<void> removeMembersFromSubBoardFunction(BuildContext context) async {
    UserCubit userCubit = context.read<UserCubit>();
    List<String> newMembersIds =
        userCubit.selectedUsers.map((e) => e.id!).toList();
    List<String> newMembersTokens =
        userCubit.selectedUsers.map((e) => e.token).toList();
    await context.read<MembersDashboardCubit>().removeMembersFromSubBoard(
      membersIds: newMembersIds,
      membersTokens: newMembersTokens,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(width: 250.w, child: const Divider()),
        Spaces.inSectionSpace20,
        const TitleWidget(title: "مجلس الإدارة"),
        Spaces.space10,
        ChooseMultibleMembersWidgetAdmin(
          requiredAccessLevel: Constants.adminAccessLevel,
          icon: FontAwesomeIcons.userPlus,
          cardTitle: "اختيار اعضاء مجلس إدارة أساسي",
          searchPath: BackendEndpoints.usersCollection,
          onSavedFunction: () {
            addMembersToMainBoardFunction(context);
          },
        ),
        ChooseMultibleMembersWidgetAdmin(
          requiredAccessLevel: Constants.adminAccessLevel,
          icon: FontAwesomeIcons.userPlus,
          cardTitle: "اختيار اعضاء مجلس إدارة إستشاري",
          searchPath: BackendEndpoints.usersCollection,
          onSavedFunction: () {
            addMembersToSubBoardFunction(context);
          },
        ),
        ChooseMultibleMembersWidgetAdmin(
          requiredAccessLevel: Constants.adminAccessLevel,
          icon: FontAwesomeIcons.userMinus,
          cardTitle: "حذف اعضاء مجلس إدارة أساسي",
          where: {UserFields.userIsMainBOD: true},
          searchPath: BackendEndpoints.usersCollection,
          onSavedFunction: () {
            removeMembersFromMainBoardFunction(context);
          },
        ),
        ChooseMultibleMembersWidgetAdmin(
          requiredAccessLevel: Constants.adminAccessLevel,
          icon: FontAwesomeIcons.userMinus,
          where: {UserFields.userIsSubBOD: true},
          cardTitle: "حذف اعضاء مجلس إدارة إستشاري",
          searchPath: BackendEndpoints.usersCollection,
          onSavedFunction: () {
            removeMembersFromSubBoardFunction(context);
          },
        ),
      ],
    );
  }
}
