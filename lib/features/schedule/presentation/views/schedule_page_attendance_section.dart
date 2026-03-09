import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/circle_image_and_title_row_widget.dart';
import 'package:new_slt/core/widgets/small_note_widget.dart';
import 'package:new_slt/core/widgets/title_widget.dart';
import 'package:new_slt/features/schedule/presentation/cubit/schedule_cubit.dart';
import 'package:new_slt/features/schedule/presentation/widgets/schedule_abs_users_list.dart';

class SchedulePageAttendanceSection extends StatelessWidget {
  const SchedulePageAttendanceSection({
    super.key,
    required this.attsList,
    required this.docId,
    required this.isAuthorized,
    required this.path,
  });
  final List<UserModel> attsList;
  final String docId;
  final String path;
  final bool isAuthorized;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spaces.sectionsSpace60,
        const TitleWidget(title: "تسجيلات الحضور"),
        Spaces.space10,
        CirlceImageAndTitleRowWidget(usersModels: attsList),
        Spaces.sectionsSpace40,
        if (isAuthorized)
          Column(
            children: [
              const TitleWidget(title: "قائمة الاعتذارات"),
              Spaces.space10,
              ScheduleAbsUsersList(
                isAuthorized: isAuthorized,
                path: path,
                docId: docId,
                scheduleAbsModel: context.read<ScheduleCubit>().scheduleAbs,
              ),
              SmallNoteWidget(
                textColor: isAuthorized ? null : Colors.red,
                content:
                    isAuthorized
                        ? "إضغط علي صورة المعتذر لعرض التفاصيل"
                        : 'مسؤول الإجتماع فقط يمكنه رؤية قائمة الاعتذارات',
                alignment: AlignmentDirectional.center,
              ),
            ],
          ),
      ],
    );
  }
}
