import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/widgets/small_note_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_sec_card.dart';
import 'package:new_slt/admin/sections/councils/presentation/cubit/council_dashboard_cubit.dart';
import 'package:new_slt/admin/sections/councils/presentation/widgets/council_settings_add_events_section_admin.dart';
import 'package:new_slt/admin/sections/councils/presentation/widgets/council_settings_change_leaders_section_admin.dart';
import 'package:new_slt/admin/sections/councils/presentation/widgets/council_settings_end_council_dialog_admin.dart';
import 'package:new_slt/admin/sections/councils/presentation/widgets/council_settings_schedule_section_admin.dart';

class CouncilSettingsCouncilSection extends StatelessWidget {
  const CouncilSettingsCouncilSection({super.key, required this.councilId});

  final String councilId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CouncilSettingsAddEventsSectionAdmin(),
        const CouncilSettingsChangeLeadersSectionAdmin(),
        CouncilSettingsScheduleSectionAdmin(councilId: councilId),
        DashboardSecCard(
          authorizedIds: [
            context.read<CouncilDashboardCubit>().council!.councilLeaderId,
            context.read<CouncilDashboardCubit>().council!.councilLeaderTwoId!,
          ],
          icon: FontAwesomeIcons.check,
          isActionCard: true,
          onTap: () {
            Helpers.showDialogMethod(
              context,
              dialogTitle: "انهاء المجلس",
              actionsWidget: EndCouncilDialogActionsWidgets(
                endCouncil: () {
                  context.read<CouncilDashboardCubit>().endCouncil();
                },
              ),
            );
          },
          title: "إنهاء المجلس",
        ),
        const SmallNoteWidget(
          content:
              "إنهاء المجلس هي خطوة تقوم بها بعد انتهاء المجلس لتغير لقب المرشحين ليصبح عضو فريق",
        ),
      ],
    );
  }
}
