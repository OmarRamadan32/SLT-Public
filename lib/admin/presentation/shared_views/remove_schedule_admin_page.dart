import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/core/widgets/cards/schedule_card.dart';
import 'package:new_slt/core/widgets/empty_view_widget.dart';
import 'package:new_slt/core/widgets/loading_widget.dart';
import 'package:new_slt/admin/data/models/schedule_feature_page_admin_model.dart';
import 'package:new_slt/admin/presentation/cubits/schedule_cubit/schedule_dashboard_cubit.dart';
import 'package:new_slt/admin/presentation/shared_views/remove_schedule_dialog_view.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_screen_widget.dart';

class RemoveScheduleAdminPage extends StatefulWidget {
  const RemoveScheduleAdminPage({
    super.key,
    required this.path,
    required this.scheduleFeaturePageAdminModel,
  });
  final String path;
  final ScheduleFeaturePageAdminModel scheduleFeaturePageAdminModel;
  @override
  State<RemoveScheduleAdminPage> createState() =>
      _RemoveScheduleAdminPageState();
}

class _RemoveScheduleAdminPageState extends State<RemoveScheduleAdminPage> {
  @override
  void initState() {
    fetchSchedulesFunction();
    super.initState();
  }

  Future<void> fetchSchedulesFunction() async {
    bool isAdmin = context.read<UserCubit>().isAdmin();
    if (isAdmin) {
      context.read<ScheduleDashboardCubit>().getAllTeamSchedule(
        path: widget.path,
      );
    } else {
      context.read<ScheduleDashboardCubit>().getAllUserSchedule(
        path: widget.path,
        userId: context.read<UserCubit>().userModel!.id!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DashboardScreenWidget(
      appBarTitle: "حذف موعد",
      child: BlocConsumer<ScheduleDashboardCubit, ScheduleDashboardState>(
        builder: (context, state) {
          if (state is ScheduleDashboardLoadingState) {
            return const LoadingWidget(isCentered: true);
          } else if (state is ScheduleDashboardErrorState) {
            return Center(
              child: ArabicTextWidget(text: state.errMessage.toString()),
            );
          } else if (state is ScheduleDashboardLoadedState) {
            if (state.schedules.isEmpty) {
              return const EmptyViewWidget(isCentered: true);
            }
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.schedules.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: GestureDetector(
                    onTap: () {
                      Helpers.showDialogMethod(
                        context,
                        dialogTitle: "هل تريد حذف هذا الموعد؟",
                        actionsWidget: RemoveScheduleDialogView(
                          onConfirm: () async {
                            await context
                                .read<ScheduleDashboardCubit>()
                                .deleteSchedule(
                                  scheduleFeaturePageAdminModel:
                                      widget.scheduleFeaturePageAdminModel,
                                  path: widget.path,
                                  docId: state.schedules[index].id!,
                                );
                            await fetchSchedulesFunction();
                          },
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 100.h,
                      child: ScheduleCard(
                        scheduleModel: state.schedules[index],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: ArabicTextWidget(text: "لا يوجد اي مواعيد"),
            );
          }
        },
        listener: (context, state) {
          if (state is ScheduleDashboardSuccessState) {
            Helpers.showSnackBar(
              context,
              "تم حذف الموعد بنجاح",
              isSuccessMessage: true,
            );
          }
          if (state is ScheduleDashboardErrorState) {
            Helpers.showSnackBar(
              context,
              state.errMessage.toString(),
              isFailureMessage: true,
            );
          }
        },
      ),
    );
  }
}
