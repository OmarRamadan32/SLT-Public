import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/core/widgets/loading_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_screen_widget.dart';
import 'package:new_slt/admin/sections/councils/presentation/cubit/council_dashboard_cubit.dart';
import 'package:new_slt/admin/sections/councils/presentation/widgets/group_settings_leaders_section_admin.dart';
import 'package:new_slt/admin/sections/councils/presentation/widgets/group_settings_members_section_admin.dart';
import 'package:new_slt/admin/sections/councils/presentation/widgets/group_settings_shield_section_admin.dart';

class GroupSettingsAdminPage extends StatelessWidget {
  const GroupSettingsAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardScreenWidget(
      appBarTitle: "إدارة المجموعة",
      child: BlocConsumer<CouncilDashboardCubit, CouncilDashboardState>(
        builder: (context, state) {
          if (state is CouncilDashboardLoadingState) {
            return const LoadingWidget(isCentered: true);
          } else if (state is CouncilDashboardErrorState) {
            return ErrorMessageWidget(isCentered: true, message: state.message);
          } else {
            return const Column(
              children: [
                GroupSettingsMembersSection(),
                GroupSettingsLeadersSection(),
                GroupSettingsShieldSection(),
              ],
            );
          }
        },
        listener: (context, state) {
          if (state is CouncilDashboardMembersUpdatedState) {
            context.read<UserCubit>().reset();
            Helpers.showSnackBar(
              context,
              "تم تحديث قائمة مرشحين المجموعة بنجاح",
              isSuccessMessage: true,
            );
          } else if (state is CouncilDashboardErrorState) {
            context.read<UserCubit>().reset();
            Helpers.showSnackBar(context, state.message);
          } else if (state is CouncilDashboardLeaderUpdatedState) {
            context.read<UserCubit>().reset();
            Helpers.showSnackBar(
              context,
              "تم تغيير أحد مسؤولين المجموعة بنجاح",
              isSuccessMessage: true,
            );
            context.pop();
          } else if (state is CouncilDashboardGroupShiledAddedState) {
            Helpers.showSnackBar(
              context,
              "تم إضافة الدرع للمجموعة بنجاح",
              isSuccessMessage: true,
            );
          }
        },
      ),
    );
  }
}
