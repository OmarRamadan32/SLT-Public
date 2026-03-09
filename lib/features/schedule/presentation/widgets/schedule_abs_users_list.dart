import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_slt/features/schedule/data/models/schedule_abs_model.dart';
import 'package:new_slt/features/schedule/presentation/widgets/schedule_abs_user_bottomsheet.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/core/widgets/circle_image_and_title_widget.dart';

class ScheduleAbsUsersList extends StatelessWidget {
  const ScheduleAbsUsersList({
    super.key,
    this.scheduleAbsModel,
    required this.path,
    required this.docId,
    required this.isAuthorized,
  });

  final List<ScheduleAbsModel>? scheduleAbsModel;
  final String path;
  final String docId;
  final bool isAuthorized;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 130.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      decoration: BoxDecoration(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        borderRadius: BorderRadius.circular(32.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32.r),
          child:
              scheduleAbsModel == null ||
                      scheduleAbsModel!.isEmpty ||
                      !isAuthorized
                  ? const Center(
                    child: ArabicTextWidget(text: "لا يوجد مستخدمين"),
                  )
                  : ListView.builder(
                    itemCount: scheduleAbsModel!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final ScheduleAbsModel user = scheduleAbsModel![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13),
                        child: GestureDetector(
                          onTap: () {
                        Helpers.     showBottomSheetMethod(
                              context: context,
                              child: ScheduleAbsUserBottomsheet(
                                docId: docId,
                                scheduleAbsModel: user,
                                path: path,
                              ),
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CirlceImageAndTitleWidget(
                                userImage: user.userImage,
                                userName: user.userName,
                              ),
                              const SizedBox(height: 5),
                              scheduleAbsModel![index].isApproved
                                  ? FaIcon(
                                    size: 15.sp,
                                    FontAwesomeIcons.check,
                                    color: Colors.green,
                                  )
                                  : const ArabicTextWidget(text: "--"),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
        ),
      ),
    );
  }
}
