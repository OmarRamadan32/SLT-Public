import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/admin/data/models/choose_members_page_model.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_sec_card.dart';

class ChooseMemberWidgetAdmin extends StatelessWidget {
  const ChooseMemberWidgetAdmin({
    super.key,
    required this.cardTitle,
    required this.onSavedFunction,
    required this.searchPath,
    this.userNumber,
    this.icon, this.authorizedIds, this.requiredAccessLevel,
  });
  final String cardTitle;
  final Function onSavedFunction;
  final String searchPath;
  final int? userNumber;
  final IconData? icon;
  final List<String>? authorizedIds;
  final int? requiredAccessLevel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        UserCubit userCubit = context.read<UserCubit>();
        final String? selectedUserName =
            userNumber == 1
                ? userCubit.selectedUser?.name
                : userNumber == 2
                ? userCubit.selectedUserTwo?.name
                : userNumber == 3
                ? userCubit.selectedUserThree?.name
                : userCubit.selectedUser?.name;

        return DashboardSecCard(
          icon: icon,
          authorizedIds: authorizedIds, 
          requiredAccessLevel: requiredAccessLevel,
          onTap: () {
            context.push(
              "${AppRouter.kChooseMemberPage}?path=$searchPath",
              extra: ChooseMembersPageModel(
                userNumber: userNumber ?? 1,
                onSaved: () {
                  onSavedFunction();
                },
              ),
            );
          },
          title: selectedUserName ?? cardTitle,
        );
      },
    );
  }
}
