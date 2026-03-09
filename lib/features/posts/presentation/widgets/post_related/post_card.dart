import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/features/posts/data/models/post_model.dart';
import 'package:new_slt/features/posts/presentation/widgets/post_related/post_card_author.dart';
import 'package:new_slt/features/posts/presentation/widgets/post_related/post_card_content.dart';
import 'package:new_slt/features/posts/presentation/widgets/post_related/post_card_pending_post_message.dart';
import 'package:new_slt/features/posts/presentation/widgets/post_related/post_card_show_comments_button.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/features/posts/presentation/widgets/post_related/post_images_widget.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.postModel, this.maxLines});
  final PostModel postModel;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              color: theme.bottomNavigationBarTheme.backgroundColor,
              borderRadius: BorderRadius.circular(16.r),
              // boxShadow: [Styles.cardsBoxShadow],
            ),
            child: Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 16.h,
                bottom: 5.h,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PostCardPendingPostMessage(postModel: postModel),
                    PostCardAuthor(
                      accessLevel: postModel.postAuthorAccessLevel!,
                      postDate: postModel.postDate,
                      authorImage: postModel.postAuthorImage,
                      authorName: postModel.postAuthorName ?? "بدون اسم",
                    ),
                    SizedBox(height: 8.h),
                    PostCardContent(
                      postContent: postModel.postContent,
                      maxLines: maxLines,
                    ),
                    Spaces.space10,
                    PostImagesWidget(imagesList: postModel.postImages),
                    PostCardShowCommentsButton(postModel: postModel),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
