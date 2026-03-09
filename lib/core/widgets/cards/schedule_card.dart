import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/features/schedule/data/models/schedule_model.dart';
import 'package:new_slt/core/widgets/cards/schedule_card_date.dart';
import 'package:new_slt/core/widgets/cards/schedule_card_details.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key, this.scheduleModel});
  final ScheduleModel? scheduleModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ScheduleCardDate(
              meetingDate: scheduleModel?.scheduleDate ?? DateTime.now(),
            ),
            ScheduleCardDetails(
              meetingTitle: scheduleModel?.scheduleTitle ?? 'موعد الاجتماع',
              meetingDescription:
                  scheduleModel?.scheduleContent ?? 'محتوي الاجتماع',
            ),
          ],
        ),
      ),
    );
  }
}
