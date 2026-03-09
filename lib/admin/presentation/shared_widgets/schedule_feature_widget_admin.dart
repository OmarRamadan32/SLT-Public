import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/admin/data/models/schedule_feature_page_admin_model.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_sec_card.dart';

class ScheduleFeatureWidgetAdmin extends StatelessWidget {
  const ScheduleFeatureWidgetAdmin({
    super.key,
    required this.scheduleFeaturePageAdminModel,
    required this.path, this.authorizedIds, this.requiredAccessLevel,
  });
  final String path;
  final ScheduleFeaturePageAdminModel scheduleFeaturePageAdminModel;
  final List<String>? authorizedIds;
  final int? requiredAccessLevel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DashboardSecCard(
          authorizedIds: authorizedIds,
          requiredAccessLevel: requiredAccessLevel,
          icon: FontAwesomeIcons.calendarPlus,
          onTap: () {
            context.push(
              '${AppRouter.kAddMeetingAdminPage}?path=$path',
              extra: scheduleFeaturePageAdminModel,
            );
          },
          title: 'إضافة ${scheduleFeaturePageAdminModel.scheduleType}',
        ),
        DashboardSecCard(
          authorizedIds: authorizedIds,
          requiredAccessLevel: requiredAccessLevel,
          icon: FontAwesomeIcons.calendarMinus,
          onTap: () {
            context.push(
              '${AppRouter.kRemoveMeetingAdminPage}?path=$path',
              extra: scheduleFeaturePageAdminModel,
            );
          },
          title: 'حذف ${scheduleFeaturePageAdminModel.scheduleType}',
        ),
      ],
    );
  }
}
