import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_slt/features/schedule/data/models/schedule_model.dart';
import 'package:new_slt/features/schedule/presentation/cubit/schedule_cubit.dart';
import 'package:new_slt/features/schedule/presentation/widgets/schedule_details_widget.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class SchedulePageDetailsSection extends StatelessWidget {
  const SchedulePageDetailsSection({super.key, required this.scheduleModel});
  final ScheduleModel scheduleModel;

  @override
  Widget build(BuildContext context) {
    ScheduleCubit cubit = context.read<ScheduleCubit>();
    final ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Spaces.sectionsSpace40,
        Center(
          child: ArabicTextWidget(
            text: scheduleModel.scheduleTitle,
            style: theme.textTheme.bodyLarge,
            maxLines: 1000,
          ),
        ),
        Spaces.inSectionSpace20,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: ArabicTextWidget(
            maxLines: 1000,
            text: scheduleModel.scheduleContent,
            style: theme.textTheme.labelMedium!.copyWith(
              fontSize: theme.textTheme.labelMedium!.fontSize!,
            ),
          ),
        ),
        Spaces.space10,
        SizedBox(
          width: 150.w,
          child: Divider(
            color: Theme.of(context).primaryColor.withAlpha(150),
            thickness: 1.3,
          ),
        ),
        Spaces.sectionsSpace40,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ScheduleDetailsWidget(
              icon: FontAwesomeIcons.solidClock,
              title: "الموعد",
              content:
                  "${(scheduleModel.scheduleDate.hour % 12 == 0 ? 12 : scheduleModel.scheduleDate.hour % 12)}:"
                  "${scheduleModel.scheduleDate.minute.toString().padLeft(2, '0')} "
                  "${scheduleModel.scheduleDate.hour >= 12 ? 'مساءً' : 'صباحًا'}",
            ),
            ScheduleDetailsWidget(
              icon: FontAwesomeIcons.solidCalendar,
              title: "التاريخ",
              content:
                  "${Helpers.zeroFill(scheduleModel.scheduleDate.day)} ${Helpers.getMonthName(scheduleModel.scheduleDate.month)} ${scheduleModel.scheduleDate.year}",
            ),
          ],
        ),
        Spaces.inSectionSpace20,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ScheduleDetailsWidget(
              icon: FontAwesomeIcons.peopleGroup,
              title: "الاعتذارات",
              content: Helpers.zeroFill(cubit.scheduleAbs.length),
            ),
            ScheduleDetailsWidget(
              icon: FontAwesomeIcons.users,
              title: "الحضور",
              content: Helpers.zeroFill(scheduleModel.scheduleAtts!.length),
            ),
          ],
        ),
      ],
    );
  }
}
