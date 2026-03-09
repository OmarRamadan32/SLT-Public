import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/features/schedule/data/models/schedule_abs_model.dart';
import 'package:new_slt/features/schedule/presentation/cubit/schedule_cubit.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/core/widgets/circle_image_and_title_widget.dart';

class ScheduleAbsUserBottomsheet extends StatelessWidget {
  const ScheduleAbsUserBottomsheet({
    super.key,
    required this.path,
    required this.docId,
    required this.scheduleAbsModel,
  });
  final ScheduleAbsModel scheduleAbsModel;
  final String path;
  final String docId;

  @override
  Widget build(BuildContext context) {
    String approveMessage;
    scheduleAbsModel.isApproved
        ? approveMessage = "تمت الموافقه علي الاعتذار"
        : approveMessage = "لم يتم الموافقة";
    ScheduleCubit cubit = context.read<ScheduleCubit>();
    ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.bottomNavigationBarTheme.backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Spaces.sectionsSpace40,
              Center(
                child: CirlceImageAndTitleWidget(
                  userName: scheduleAbsModel.userName,
                  userImage: scheduleAbsModel.userImage,
                ),
              ),
              Spaces.sectionsSpace40,
              ArabicTextWidget(
                text: "سبب الاعتذار",
                style: theme.textTheme.bodyMedium,
              ),
              Spaces.space10,
              ArabicTextWidget(
                maxLines: 1000,
                text: scheduleAbsModel.absReason,
                style: theme.textTheme.labelSmall,
              ),
              Spaces.inSectionSpace20,
              ArabicTextWidget(
                text: "الحاله: ",
                style: theme.textTheme.bodyMedium,
              ),
              Spaces.space10,
              ArabicTextWidget(
                text: approveMessage,
                style: theme.textTheme.labelSmall,
              ),
              Spaces.screenLastItemSpace70,
              // actions
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          backgroundColor:
                              theme
                                  .bottomNavigationBarTheme
                                  .unselectedItemColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        onPressed: () {
                          cubit.declineScheduleAbs(
                            path: path,
                            docId: docId,
                            userId: scheduleAbsModel.absId,
                          );
                          cubit.getScheduleById(path: path, docId: docId);
                        },
                        child: ArabicTextWidget(
                          text: "رفض",
                          style: theme.textTheme.bodyMedium?.copyWith(),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          backgroundColor: theme.primaryColor,
                        ),
                        onPressed: () async {
                          cubit.approveScheduleAbs(
                            path: path,
                            docId: docId,
                            userId: scheduleAbsModel.absId,
                          );
                          cubit.getScheduleById(path: path, docId: docId);
                        },
                        child: ArabicTextWidget(
                          text: "قبول",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spaces.screenLastItemSpace70,
            ],
          ),
        ),
      ),
    );
  }
}
