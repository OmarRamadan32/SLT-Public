import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/features/schedule/data/models/schedule_abs_model.dart';
import 'package:new_slt/features/schedule/presentation/cubit/schedule_cubit.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/custom_text_field_admin.dart';

class ScheduleAbsBottomsheet extends StatefulWidget {
  const ScheduleAbsBottomsheet({
    super.key,
    required this.path,
    required this.userModel,
    required this.docId,
  });

  final String path;
  final UserModel userModel;
  final String docId;

  @override
  State<ScheduleAbsBottomsheet> createState() => _ScheduleAbsBottomsheetState();
}

class _ScheduleAbsBottomsheetState extends State<ScheduleAbsBottomsheet> {
  TextEditingController reasonController = TextEditingController();

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Column(
        children: [
          Spaces.sectionsSpace40,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: CustomTextFieldAdmin(
              controller: reasonController,
              label: "سبب الاعتذار",
            ),
          ),
          Spaces.sectionsSpace40,
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 50.w),
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            onPressed: () async {
              ScheduleCubit cubit = context.read<ScheduleCubit>();

              if (reasonController.text.isNotEmpty) {
                context.pop();
                await cubit.absSchedule(
                  path: widget.path,
                  scheduleAbsModel: ScheduleAbsModel(
                    absId: widget.userModel.id.toString(),
                    absReason: reasonController.text,
                    isApproved: false,
                    userName: widget.userModel.name,
                    userImage: widget.userModel.imageUrl,
                  ),
                  docId: widget.docId,
                );
                await cubit.getScheduleById(
                  path: widget.path,
                  docId: widget.docId,
                );
              } else {
                Helpers.showSnackBar(context, "يرجى كتابة سبب الاعتذار");
                context.pop();
              }
            },
            child: ArabicTextWidget(
              text: "حفظ",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
