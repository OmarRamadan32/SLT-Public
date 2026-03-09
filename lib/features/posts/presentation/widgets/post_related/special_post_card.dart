import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/features/posts/data/models/post_model.dart';
import 'package:new_slt/features/posts/presentation/widgets/post_related/post_card_author.dart';
import 'package:new_slt/features/posts/presentation/widgets/post_related/post_card_content.dart';
import 'package:new_slt/features/posts/presentation/widgets/post_related/post_images_widget.dart';
import 'package:new_slt/features/posts/presentation/widgets/post_related/special_post_card_button.dart';
import 'package:new_slt/features/posts/presentation/widgets/post_related/special_post_card_signed_part.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/small_note_widget.dart';

class SpecialPostCard extends StatelessWidget {
  const SpecialPostCard({super.key, required this.postModel});
  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    final bool isSigned = postModel.specialPostSigners!.any(
      (user) => user.id == context.read<UserCubit>().userModel!.id,
    );
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: theme.bottomNavigationBarTheme.backgroundColor,
                  borderRadius: BorderRadius.circular(16.r),
                  // boxShadow: [Styles.cardsBoxShadow],
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PostCardAuthor(
                          accessLevel: postModel.postAuthorAccessLevel!,
                          postDate: postModel.postDate,
                          authorImage: postModel.postAuthorImage,
                          authorName: postModel.postAuthorName ?? "بدون اسم",
                        ),
                        SizedBox(height: 8.h),
                        PostCardContent(postContent: postModel.postContent),
                        Spaces.space10,
                        PostImagesWidget(imagesList: postModel.postImages),
                        Spaces.space10,
                        SizedBox(
                          width: double.infinity,
                          height: 1,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: theme.textTheme.bodySmall!.color!
                                  .withAlpha(75),
                            ),
                          ),
                        ),
                        Spaces.space10,
                        SpecialPostCardSignedPart(postModel: postModel),
                        Spaces.space10,
                        SpecialPostCardButtons(
                          isSigned: isSigned,
                          postModel: postModel,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          postModel.specialpostNote != null &&
                  postModel.specialpostNote!.isNotEmpty
              ? SmallNoteWidget(content: postModel.specialpostNote!)
              : const SizedBox(),
        ],
      ),
    );
  }
}
