import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_slt/admin/sections/members/presentation/widgets/member_of_the_month_section.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/loading_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_screen_widget.dart';
import 'package:new_slt/admin/sections/members/presentation/cubits/members_cubit/members_dashboard_cubit.dart';
import 'package:new_slt/admin/sections/members/presentation/widgets/board_of_directors_admin_section.dart';
import 'package:new_slt/admin/sections/members/presentation/widgets/members_admin_page_messages_section.dart';
import 'package:new_slt/admin/sections/members/presentation/widgets/team_actions_admin_section.dart';

class MembersAdminPage extends StatelessWidget {
  const MembersAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardScreenWidget(
      appBarTitle: "ادارة الاعضاء",
      child: BlocConsumer<MembersDashboardCubit, MembersDashboardState>(
        builder: (context, state) {
          if (state is MembersDashboardLoadingState) {
            return const LoadingWidget(isCentered: true);
          } else {
            return Column(
              children: [
                const MembersAdminPageMessagesSection(),
                const MemberOfTheMonthSection(),
                const TeamActionsAdminSection(),
                const BoardOfDirectorsAdminSection(),
                Spaces.sectionsSpace40,
              ],
            );
          }
        },
        listener: (context, state) {
          if (state is MembersDashboardErrorState) {
            context.read<UserCubit>().reset();
            Helpers.showSnackBar(
              context,
              state.message,
              isFailureMessage: true,
            );
          }
          if (state is MembersDashboardSuccessState) {
            context.read<UserCubit>().reset();
            Helpers.showSnackBar(
              context,
              "تمت العملية بنجاح",
              isSuccessMessage: true,
            );
          }
        },
      ),
    );
  }
}
