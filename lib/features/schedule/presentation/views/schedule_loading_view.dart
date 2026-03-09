import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/features/schedule/data/models/schedule_model.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/cards/schedule_card.dart';
import 'package:new_slt/core/widgets/skeleton_loading_view.dart';
import 'package:new_slt/core/widgets/small_note_widget.dart';

class ScheduleLoadingView extends StatelessWidget {
  const ScheduleLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SkeletonLoadingView(
      cardsCount: 1,
      card: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Spaces.space10,
          Container(
            height: 20.h,
            color: Theme.of(context).scaffoldBackgroundColor,
            width: 100.w,
          ),
          Spaces.space10,
          SizedBox(
            height: 100.h,
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.95),
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return ScheduleCard(scheduleModel: ScheduleModel.fakeModel());
              },
            ),
          ),
          SmallNoteWidget(
            textColor: Theme.of(context).textTheme.bodySmall!.color,
            alignment: Alignment.centerRight,
            content:
                "المواعيد في هذه الصفحة تشمل اجتماعات الفريق ومواعيد أنشطة الحملة فقط",
          ),
        ],
      ),
    );
  }
}
