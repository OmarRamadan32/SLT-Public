import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/networking/backend_endpoints.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/details_box_widget.dart';
import 'package:new_slt/admin/data/models/schedule_feature_page_admin_model.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_screen_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/schedule_feature_widget_admin.dart';

class ScheduleAdminPage extends StatelessWidget {
  const ScheduleAdminPage({super.key});
  static const String path = BackendEndpoints.schedulesCollection;

  @override
  Widget build(BuildContext context) {
    return DashboardScreenWidget(
      appBarTitle: "المواعيد",
      child: Column(
        children: [
          ScheduleFeatureWidgetAdmin(
            scheduleFeaturePageAdminModel: ScheduleFeaturePageAdminModel(
              isTeamSchedule: true,
              scheduleAuthorName: context.read<UserCubit>().userModel!.name,
              scheduleType: 'موعد عام',
            ),
            path: path,
          ),
          Spaces.inSectionSpace20,
          const DetailsBoxWidget(
            content: '''
امثله علي المواعيد العامه:
- اجتماعات الفريق
- إنترفيوهات اعضاء الفريق
''',
          ),
        ],
      ),
    );
  }
}
