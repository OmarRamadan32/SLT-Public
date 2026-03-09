import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/core/widgets/avatar_image.dart';
import 'package:new_slt/core/widgets/screen_widget/screen_widget.dart';
import 'package:new_slt/features/posts/data/models/content_page_model.dart';
import 'package:new_slt/features/posts/presentation/widgets/comment_related/comments_section.dart';
import 'package:new_slt/features/posts/presentation/widgets/content_page_content.dart';
import 'package:new_slt/features/posts/presentation/widgets/content_date.dart';
import 'package:new_slt/features/posts/presentation/widgets/post_related/post_images_widget.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({
    super.key,
    required this.contentModel,
    required this.postID,
  });
  final ContentPageModel contentModel;
  final String postID;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ScreenWidget(
      isMainScreen: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Spaces.inSectionSpace20,
            ContentPageHidder(
              authorImage: contentModel.contentAuthorImage,
              authorName: contentModel.contentAuthorName,
              contentDate: contentModel.contentDate,
            ),
            Spaces.inSectionSpace20,
            ContentPageContent(postContent: contentModel.contentText),
            if (contentModel.postImages != null &&
                contentModel.postImages!.isNotEmpty)
              Spaces.space10,
            PostImagesWidget(imagesList: contentModel.postImages ?? []),
            Spaces.space10,
            SizedBox(
              child: Divider(
                color: theme.textTheme.bodySmall!.color,
                thickness: 0.5,
              ),
            ),
            Spaces.inSectionSpace20,
            // ---------------------- Add Comment ----------------------
            CommentsSection(
              postID: postID,
              commentAuthorId: contentModel.contentAuthorID,
              commentID: contentModel.contentID,
            ),
          ],
        ),
      ),
    );
  }
}

class ContentPageAuthor extends StatelessWidget {
  const ContentPageAuthor({
    super.key,
    required this.authorName,
    required this.authorImage,
  });
  final String authorName;
  final String authorImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ArabicTextWidget(
          text: authorName,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(width: 10.w),
        AvatarImage(imageUrl: authorImage),
      ],
    );
  }
}

class ContentPageHidder extends StatelessWidget {
  const ContentPageHidder({
    super.key,
    required this.authorName,
    required this.authorImage,
    required this.contentDate,
  });
  final String authorName;
  final String authorImage;
  final DateTime contentDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ContentDate(postDate: contentDate),
        ContentPageAuthor(authorName: authorName, authorImage: authorImage),
      ],
    );
  }
}
