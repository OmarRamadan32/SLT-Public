import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/core/widgets/circle_image_and_title_widget.dart';

class GroupLeaderWidget extends StatelessWidget {
  const GroupLeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ArabicTextWidget(
          text: "قائد المجموعة",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        SizedBox(height: 10.h),
        const CirlceImageAndTitleWidget(
                          userImage: "",
                  userName: "",
        ),
      ],
    );
  }
}
