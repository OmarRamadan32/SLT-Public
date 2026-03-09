import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/features/schedule/data/models/schedule_model.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/core/widgets/details_box_widget.dart';
import 'package:new_slt/admin/data/models/schedule_feature_page_admin_model.dart';
import 'package:new_slt/admin/presentation/cubits/schedule_cubit/schedule_dashboard_cubit.dart';
import 'package:new_slt/admin/presentation/shared_views/pick_date_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_button_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_text_field_admin.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_screen_widget.dart';

class AddScheduleAdminPage extends StatefulWidget {
  const AddScheduleAdminPage({
    super.key,
    required this.path,
    required this.scheduleFeaturePageAdminModel,
  });
  final String path;
  final ScheduleFeaturePageAdminModel scheduleFeaturePageAdminModel;
  void addMeetingButtonAction(
    BuildContext context,
    TextEditingController scheduleTitleController,
    TextEditingController scheduleDescriptionController,
    DateTime selectedDate,
  ) {
    String scheduleAuthorId = context.read<UserCubit>().userModel!.id!;
    String scheduleTitle = scheduleTitleController.text.trim();
    String scheduleContent = scheduleDescriptionController.text.trim();
    DateTime scheduleDate = selectedDate;
    ScheduleDashboardCubit scheduleDashboardCubit =
        context.read<ScheduleDashboardCubit>();
    scheduleDashboardCubit.addSchedule(
      scheduleFeaturePageAdminModel: scheduleFeaturePageAdminModel,
      path: path,
      scheduleModel: ScheduleModel(
        scheduleTitle: scheduleTitle,
        scheduleContent: scheduleContent,
        scheduleAuthorId: scheduleAuthorId,
        scheduleDate: scheduleDate,
        scheduleAtts: [],
      ),
    );
  }

  @override
  State<AddScheduleAdminPage> createState() => _AddScheduleAdminPageState();
}

class _AddScheduleAdminPageState extends State<AddScheduleAdminPage> {
  DateTime selectedDate = DateTime.now();
  TextEditingController scheduleTitleController = TextEditingController();
  TextEditingController scheduleDescriptionController = TextEditingController();

  @override
  void dispose() {
    scheduleTitleController.dispose();
    scheduleDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DashboardScreenWidget(
      appBarTitle: "إضافة موعد",
      child: BlocConsumer<ScheduleDashboardCubit, ScheduleDashboardState>(
        builder: (context, state) {
          if (state is ScheduleDashboardErrorState) {
            return Center(
              child: ArabicTextWidget(text: state.errMessage.toString()),
            );
          } else {
            return Column(
              children: [
                CustomTextFieldAdmin(
                  hintText: "أضف عنوان للموعد",
                  label: "عنوان الموعد",
                  controller: scheduleTitleController,
                ),
                Spaces.inSectionSpace20,
                CustomTextFieldAdmin(
                  hintText: "الهدف من الموعد",
                  label: "وصف الموعد",
                  maxLines: 5,
                  controller: scheduleDescriptionController,
                ),
                Spaces.sectionsSpace40,
                DateTimePickerField(
                  onDateTimeSelected: (dateTime) {
                    selectedDate = dateTime;
                  },
                ),
                Spaces.inSectionSpace20,
                const DetailsBoxWidget(
                  content: "يرجي حذف الموعد بعد انتهاء مدته",
                ),
                Spaces.screenLastItemSpace70,
                CustomButtonAdmin(
                  isLoading: state is ScheduleDashboardLoadingState,
                  onPressed: () {
                    widget.addMeetingButtonAction(
                      context,
                      scheduleTitleController,
                      scheduleDescriptionController,
                      selectedDate,
                    );
                  },
                  text: "حفظ",
                ),
              ],
            );
          }
        },
        listener: (context, state) {
          if (state is ScheduleDashboardSuccessState) {
            Helpers.showSnackBar(
              context,
              "تم إضافة الموعد بنجاح",
              isSuccessMessage: true,
            );
            context.pop(context);
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
