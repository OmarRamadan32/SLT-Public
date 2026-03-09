import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_sec_card.dart';
import 'package:new_slt/admin/sections/councils/presentation/cubit/council_dashboard_cubit.dart';

class CouncilSettingsAddEventsSectionAdmin extends StatelessWidget {
  const CouncilSettingsAddEventsSectionAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final CouncilDashboardCubit cubit = context.read<CouncilDashboardCubit>();
    return Column(
      children: [
        DashboardSecCard(
          authorizedIds: [
            cubit.council!.councilLeaderId,
            cubit.council!.councilLeaderTwoId!
          ],
          icon: FontAwesomeIcons.userGroup,
          onTap: () {
            cubit.resetState();
            context.push(AppRouter.kAddSwa3edAdminPage);
          },
          title: "إضافة السواعد",
        ),
        DashboardSecCard(
                    authorizedIds: [
            cubit.council!.councilLeaderId,
            cubit.council!.councilLeaderTwoId!
          ],
          icon: FontAwesomeIcons.peopleGroup,
          onTap: () {
            cubit.resetState();
            context.push(AppRouter.kAddGroupAdminPage);
          },
          title: "إضافة مجموعة",
        ),
      ],
    );
  }
}
