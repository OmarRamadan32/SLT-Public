import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/core/widgets/profile_images_widget.dart';
import 'package:new_slt/core/widgets/skeleton_loading_view.dart';
import 'package:new_slt/features/members/presentation/widgets/edit_profile_button.dart';

class ProfilePageLoadingView extends StatelessWidget {
  const ProfilePageLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Spaces.inSectionSpace20,
        const SkeletonLoadingView(
          cardsCount: 1,
          card: ProfileImagesWidget(
            isDrawer: false,
            isCentered: true,
            imageUrl: "",
            backGroundImageUrl: "",
          ),
        ),
        Spaces.sectionsSpace40,
        SkeletonLoadingView(
          cardsCount: 1,
          card: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ArabicTextWidget(
                maxLines: 1,
                text: "اسم المستخدم",
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontSize: theme.textTheme.bodyLarge!.fontSize! + 4.sp,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 3),
        SkeletonLoadingView(
          cardsCount: 1,
          card: Align(
            alignment: Alignment.centerRight,
            child: ArabicTextWidget(
              text: "قم بوضع نبذه عنك",
              style: theme.textTheme.titleSmall!.copyWith(
                fontSize: theme.textTheme.bodySmall!.fontSize,
              ),
            ),
          ),
        ),

        Spaces.inSectionSpace20,
        SkeletonLoadingView(
          cardsCount: 1,
          card: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ArabicTextWidget(text: "قائد", style: theme.textTheme.bodyMedium),
              ArabicTextWidget(
                text: "اللقب: ",
                style: theme.textTheme.labelMedium,
              ),
            ],
          ),
        ),
        Spaces.space10,
        SkeletonLoadingView(
          cardsCount: 1,
          card: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ArabicTextWidget(text: "--", style: theme.textTheme.bodyMedium),
              ArabicTextWidget(
                text: "المجلس: ",
                style: theme.textTheme.labelMedium,
              ),
            ],
          ),
        ),
        Spaces.space10,
        SkeletonLoadingView(
          cardsCount: 1,
          card: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ArabicTextWidget(text: "--", style: theme.textTheme.bodyMedium),
              ArabicTextWidget(
                text: "المجموعة: ",
                style: theme.textTheme.labelMedium,
              ),
            ],
          ),
        ),
        const Spacer(),

        const SkeletonLoadingView(card: EditProfileButton(), cardsCount: 1),
        Spaces.sectionsSpace40,
      ],
    );
  }
}
