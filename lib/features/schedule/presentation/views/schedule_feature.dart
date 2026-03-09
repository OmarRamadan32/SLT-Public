import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/enums.dart';
import 'package:new_slt/core/widgets/cards/schedule_card.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/empty_view_widget.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/core/widgets/small_note_widget.dart';

import 'package:new_slt/core/widgets/title_widget.dart';
import 'package:new_slt/core/widgets/unauthorized_sign_widget.dart';
import 'package:new_slt/features/schedule/presentation/cubit/schedule_cubit.dart';
import 'package:new_slt/features/schedule/presentation/views/schedule_loading_view.dart';

class ScheduleFeature extends StatefulWidget {
  const ScheduleFeature({
    super.key,
    required this.path,
    this.isPublicSchedule,
    this.authorizedUsers,
  });
  final String path;
  final bool? isPublicSchedule;
  final List<String>? authorizedUsers;

  @override
  State<ScheduleFeature> createState() => _ScheduleFeatureState();
}

class _ScheduleFeatureState extends State<ScheduleFeature> {
  @override
  initState() {
    context.read<ScheduleCubit>().getUpcomingSchedules(path: widget.path);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScheduleCubit cubit = context.read<ScheduleCubit>();
    String currentUserId = context.read<UserCubit>().userModel!.id!;
    return BlocBuilder<ScheduleCubit, ScheduleState>(
      builder: (context, state) {
        if (state is ScheduleLoadingState) {
          return const ScheduleLoadingView();
        } else if (state is ScheduleErrorState) {
          return ErrorMessageWidget(message: state.errMessage);
        } else {
          if (widget.authorizedUsers == null ||
              widget.authorizedUsers!.contains(currentUserId) ||
              context.read<UserCubit>().isAdmin()) {
            if (cubit.schedulesList.isEmpty) {
              if (widget.isPublicSchedule != true) {
                return const Column(
                  children: [
                    EmptyViewWidget(
                      viewTitle: "المواعيد",
                      message: "لا يوجد مواعيد",
                    ),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            } else {
              return Column(
                children: [
                  Spaces.inSectionSpace20,
                  TitleWidget(
                    title: "المواعيد",
                    subtitle: cubit.schedulesList.length.toString(),
                  ),
                  Spaces.space10,
                  SizedBox(
                    height: 100.h,
                    child: PageView.builder(
                      controller: PageController(
                        viewportFraction:
                            cubit.schedulesList.length > 1
                                ? 0.95
                                : 1, // Card takes full width
                      ),
                      scrollDirection: Axis.horizontal,
                      padEnds: false,
                      itemCount: cubit.schedulesList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            final String path = widget.path;
                            final String docId = cubit.schedulesList[index].id!;
                            context.push(
                              "${AppRouter.kschedulePage}?path=$path&docId=$docId",
                            );
                          },
                          child: ScheduleCard(
                            scheduleModel: cubit.schedulesList[index],
                          ),
                        );
                      },
                    ),
                  ),
                  widget.isPublicSchedule == true
                      ? SmallNoteWidget(
                        textColor: Theme.of(context).textTheme.bodySmall!.color,
                        alignment: Alignment.centerRight,
                        content:
                            "المواعيد في هذه الصفحة تشمل اجتماعات الفريق ومواعيد أنشطة الحملة فقط",
                      )
                      : const SizedBox(),
                ],
              );
            }
          } else {
            return const Column(
              children: [
                TitleWidget(title: "المواعيد"),
                UnauthorizedSignWidget(
                  height: 200,
                  message: UnauthorizedMessages.accessLevelMessage,
                ),
              ],
            );
          }
        }
      },
    );
  }
}
