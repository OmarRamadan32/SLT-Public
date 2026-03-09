import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';

import 'package:new_slt/core/widgets/screen_widget/screen_widget.dart';
import 'package:new_slt/features/schedule/presentation/cubit/schedule_cubit.dart';
import 'package:new_slt/features/schedule/presentation/views/schedule_page_attendance_section.dart';
import 'package:new_slt/features/schedule/presentation/views/schedule_page_details_section.dart';
import 'package:new_slt/features/schedule/presentation/views/schedule_page_loading_view.dart';
import 'package:new_slt/features/schedule/presentation/widgets/meeting_page_buttons.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key, required this.path, required this.docId});
  final String path, docId;

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  void initState() {
    context.read<ScheduleCubit>().getScheduleById(
      path: widget.path,
      docId: widget.docId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScheduleCubit cubit = context.read<ScheduleCubit>();
    UserCubit userCubit = context.read<UserCubit>();
    return ScreenWidget(
      isMainScreen: false,
      child: BlocConsumer<ScheduleCubit, ScheduleState>(
        builder: (context, state) {
          if (state is ScheduleLoadingState) {
            return const SchedulePageLoadingView();
          } else if (state is ScheduleErrorState) {
            return ErrorMessageWidget(message: state.errMessage);
          } else {
            final bool isAuthorized =
                cubit.schedule!.scheduleAuthorId == userCubit.userModel!.id;
            return SingleChildScrollView(
              child: Column(
                children: [
                  SchedulePageDetailsSection(scheduleModel: cubit.schedule!),
                  SchedulePageAttendanceSection(
                    isAuthorized: isAuthorized,
                    path: widget.path,
                    docId: widget.docId,
                    attsList: cubit.schedule!.scheduleAtts!,
                  ),
                  Spaces.sectionsSpace40,
                  if (isAuthorized == false)
                    SchedulePageButtons(path: widget.path, docId: widget.docId),
                ],
              ),
            );
          }
        },
        listener: (context, state) {
          if (state is ScheduleAttsSuccessState) {
            Helpers.showSnackBar(
              context,
              "تم تسجيلك في قائمة الحضور بنجاح",
              isSuccessMessage: true,
            );
          }
          if (state is ScheduleAbsSuccessState) {
            Helpers.showSnackBar(
              context,
              "تم إرسال اعتذارك بنجاح وسيصلك إشعار في حال قبوله",
              isSuccessMessage: true,
            );
          }
          if (state is ScheduleApproveAbsState) {
            context.pop();
            Helpers.showSnackBar(
              context,
              "تم قبول الاعتذار بنجاح",
              isSuccessMessage: true,
            );
          }
          if (state is ScheduleDeclineAbsState) {
            context.pop();
            Helpers.showSnackBar(
              context,
              "تم رفض الاعتذار بنجاح",
              isSuccessMessage: true,
            );
          }
        },
      ),
    );
  }
}
