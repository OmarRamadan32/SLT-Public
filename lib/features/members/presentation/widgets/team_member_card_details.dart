import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/core/widgets/verified_icon.dart';

class TeamMemberCardDetails extends StatelessWidget {
  const TeamMemberCardDetails({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(top: 5.h, right: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              VerifiedIcon(accessLevel: userModel.accessLevel!),
              ArabicTextWidget(
                text: userModel.name,
                style: theme.textTheme.titleSmall,
              ),
            ],
          ),
          Spaces.space5,
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: ArabicTextWidget(
              text: userModel.bio!,
              style: theme.textTheme.bodySmall!.copyWith(
                fontSize: theme.textTheme.bodySmall!.fontSize! - 1,
              ),
              maxLines: 1,
            ),
          ),
          Spaces.space5,
          Row(
            children: [
              ArabicTextWidget(
                text: userModel.title,
                style: theme.textTheme.bodySmall,
              ),
              ArabicTextWidget(
                text: "اللقب: ",
                style: theme.textTheme.labelSmall,
              ),
              const ArabicTextWidget(text: "- "),
            ],
          ),
          Row(
            children: [
              ArabicTextWidget(
                text: userModel.councilNumber.toString(),
                style: theme.textTheme.bodySmall,
              ),
              ArabicTextWidget(
                text: "المجلس: ",
                style: theme.textTheme.labelSmall,
              ),
              const ArabicTextWidget(text: "- "),
            ],
          ),

          Spaces.space5,
        ],
      ),
    );
  }
}
