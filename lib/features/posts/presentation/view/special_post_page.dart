import 'package:flutter/material.dart';
import 'package:new_slt/features/posts/data/models/post_model.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/arabic_text_widget.dart';
import 'package:new_slt/core/widgets/circle_image_and_title_row_widget.dart';
import 'package:new_slt/core/widgets/screen_widget/screen_widget.dart';
import 'package:new_slt/core/widgets/title_widget.dart';
import 'package:new_slt/features/posts/presentation/widgets/comment_related/comments_section.dart';
import 'package:new_slt/features/posts/presentation/widgets/content_page_content.dart';
import 'package:new_slt/features/posts/presentation/widgets/post_related/post_images_widget.dart';

class SpecialPostPage extends StatelessWidget {
  const SpecialPostPage({super.key, required this.postModel});

  final PostModel postModel;

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
            Center(
              child: ArabicTextWidget(
                textAlign: TextAlign.center,
                maxLines: 1000,
                text: postModel.postTitle!,
                style: theme.textTheme.titleLarge,
              ),
            ),
            Spaces.space10,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ContentPageContent(postContent: postModel.postContent),
            ),
            Spaces.space10,
            PostImagesWidget(imagesList: postModel.postImages),
            Spaces.inSectionSpace20,
            TitleWidget(
              title: "قاموا بالتسجيل",
              subtitle: postModel.specialPostSigners!.length.toString(),
            ),
            Spaces.space5,
            CirlceImageAndTitleRowWidget(
              usersModels: postModel.specialPostSigners!,
            ),
            Spaces.inSectionSpace20,
            SizedBox(
              child: Divider(
                color: theme.textTheme.bodySmall!.color,
                thickness: 0.5,
              ),
            ),

            Spaces.inSectionSpace20,
            CommentsSection(postID: postModel.postId!),
          ],
        ),
      ),
    );
  }
}
