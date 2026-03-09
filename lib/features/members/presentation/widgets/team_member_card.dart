import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/features/members/presentation/widgets/team_member_card_details.dart';
import 'package:new_slt/features/members/presentation/widgets/team_member_card_image.dart';

class TeamMemberCard extends StatelessWidget {
  const TeamMemberCard({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: GestureDetector(
        onTap: () {
          context.push("${AppRouter.kProfilePage}/${userModel.id}");
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: theme.bottomNavigationBarTheme.backgroundColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TeamMemberCardImage(imageUrl: userModel.imageUrl),
                TeamMemberCardDetails(userModel: userModel),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
