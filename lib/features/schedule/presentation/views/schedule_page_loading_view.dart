import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/features/schedule/data/models/schedule_model.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/circle_image_and_title_row_widget.dart';
import 'package:new_slt/core/widgets/skeleton_loading_view.dart';
import 'package:new_slt/core/widgets/title_widget.dart';
import 'package:new_slt/features/schedule/presentation/views/schedule_page_details_section.dart';

class SchedulePageLoadingView extends StatelessWidget {
  const SchedulePageLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SkeletonLoadingView(
      cardsCount: 1,
      card: Column(
        children: [
          SchedulePageDetailsSection(scheduleModel: ScheduleModel.fakeModel()),
          Spaces.sectionsSpace40,
          const TitleWidget(title: "---------"),
          Spaces.space5,
          CirlceImageAndTitleRowWidget(
            usersModels: [
              UserModel.fakeModel(),
              UserModel.fakeModel(),
              UserModel.fakeModel(),
              UserModel.fakeModel(),
              UserModel.fakeModel(),
            ],
          ),
          const TitleWidget(title: "--------"),
          Spaces.space5,
          CirlceImageAndTitleRowWidget(
            usersModels: [
              UserModel.fakeModel(),
              UserModel.fakeModel(),
              UserModel.fakeModel(),
              UserModel.fakeModel(),
              UserModel.fakeModel(),
            ],
          ),
          Spaces.sectionsSpace40,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            textDirection:
                TextDirection
                    .rtl, // This puts the first child (الحضور) on the right
            children: [
              ElevatedButton(
                onPressed: () async {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 35.w,
                    vertical: 12.h,
                  ),
                ),
                child: Text(
                  "الحضور",
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 50.w),
              ElevatedButton(
                onPressed: () async {},
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      theme.bottomNavigationBarTheme.backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 35.w,
                    vertical: 12.h,
                  ),
                ),
                child: Text("الاعتذار", style: theme.textTheme.bodyMedium),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
