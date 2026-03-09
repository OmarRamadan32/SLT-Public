import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/admin/data/models/schedule_feature_page_admin_model.dart';
import 'package:new_slt/admin/presentation/shared_widgets/schedule_feature_widget_admin.dart';
import 'package:new_slt/admin/sections/councils/presentation/cubit/council_dashboard_cubit.dart';

class Swa3edSettingsScheduleSection extends StatelessWidget {
  const Swa3edSettingsScheduleSection({super.key});
  @override
  Widget build(BuildContext context) {
    final String councilId = context.read<CouncilDashboardCubit>().council!.id!;
    final String swa3edId = context.read<CouncilDashboardCubit>().swa3ed!.id!;
    final String schedulePath =
        '${BackendEndpoints.councilCollection}/$councilId/${BackendEndpoints.swa3edCollection}/$swa3edId/${BackendEndpoints.schedulesCollection}';
    return ScheduleFeatureWidgetAdmin(
      authorizedIds: [
        context.read<CouncilDashboardCubit>().council!.councilLeaderId,
        context.read<CouncilDashboardCubit>().council!.councilLeaderTwoId!,
        context.read<CouncilDashboardCubit>().swa3ed!.swa3edLeaderId,
        context.read<CouncilDashboardCubit>().swa3ed!.swa3edLeaderTwoId
      ],
      scheduleFeaturePageAdminModel: ScheduleFeaturePageAdminModel(
        isTeamSchedule: false,
        scheduleAuthorName: context.read<UserCubit>().userModel!.name,
        scheduleMembersIds:
            context
                .read<CouncilDashboardCubit>()
                .swa3ed!
                .swa3edMembers
                .map((e) => e.id!)
                .toList(),
        scheduleMembersTokens:
            context
                .read<CouncilDashboardCubit>()
                .swa3ed!
                .swa3edMembers
                .map((e) => e.token)
                .toList(),
        scheduleType: 'اجتماع سواعد',
      ),
      path: schedulePath,
    );
  }
}
