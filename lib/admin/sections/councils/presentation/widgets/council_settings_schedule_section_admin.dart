import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/admin/data/models/schedule_feature_page_admin_model.dart';
import 'package:new_slt/admin/presentation/shared_widgets/schedule_feature_widget_admin.dart';
import 'package:new_slt/admin/sections/councils/presentation/cubit/council_dashboard_cubit.dart';
import 'package:new_slt/features/council/data/models/council_model.dart';

class CouncilSettingsScheduleSectionAdmin extends StatelessWidget {
  const CouncilSettingsScheduleSectionAdmin({
    super.key,
    required this.councilId,
  });

  final String councilId;

  @override
  Widget build(BuildContext context) {
    CouncilModel council = context.read<CouncilDashboardCubit>().council!;
    final String schedulePath =
        '${BackendEndpoints.councilCollection}/$councilId/${BackendEndpoints.schedulesCollection}';
    return ScheduleFeatureWidgetAdmin(
                authorizedIds: [
           council.councilLeaderId,
           council.councilLeaderTwoId!
          ],
      scheduleFeaturePageAdminModel: ScheduleFeaturePageAdminModel(
        isTeamSchedule: false,
        scheduleAuthorName: context.read<UserCubit>().userModel!.name,
        scheduleMembersIds:
            council.councilMembersModel.map((e) => e.id!).toList(),
        scheduleMembersTokens:
            council.councilMembersModel.map((e) => e.token).toList(),
        scheduleType: 'اجتماع مجلس',
      ),
      path: schedulePath,
    );
  }
}
