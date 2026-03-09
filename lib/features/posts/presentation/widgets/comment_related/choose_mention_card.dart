import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_slt/features/user/data/models/user_model.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';

class ChooseMentionCard extends StatelessWidget {
  const ChooseMentionCard({
    super.key,
    required this.userModel,
    required this.onTap,
  });
  final UserModel userModel;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(3),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: theme.bottomNavigationBarTheme.backgroundColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ArabicTextWidget(
              text: userModel.name,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(width: 5),
            FaIcon(
              FontAwesomeIcons.xmark,
              color: theme.primaryColor,
              size: 10.sp,
            ),
          ],
        ),
      ),
    );
  }
}
