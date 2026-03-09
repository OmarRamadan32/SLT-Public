import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

import 'package:new_slt/core/widgets/circle_image_and_title_widget.dart';

class CirlceImageAndTitleRowWidget extends StatelessWidget {
  const CirlceImageAndTitleRowWidget({super.key, this.usersModels});

  final List<UserModel>? usersModels;

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115.h,
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
              usersModels == null || usersModels!.isEmpty
                  ? const Center(
                    child: ArabicTextWidget(text: "لا يوجد مستخدمين"),
                  )
                  : ListView.builder(
                    itemCount: usersModels!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final user = usersModels![index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: CirlceImageAndTitleWidget(
                          userImage: user.imageUrl,
                          userName: user.name,
                        ),
                      );
                    },
                  ),
        ),
      ),
    );
  }
}
