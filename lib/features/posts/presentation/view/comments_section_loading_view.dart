import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/skeleton_loading_view.dart';
import 'package:new_slt/features/posts/presentation/widgets/comment_related/comment_item_author.dart';
import 'package:new_slt/features/posts/presentation/widgets/comment_related/comment_item_content.dart';
import 'package:new_slt/features/posts/presentation/widgets/comment_related/comment_item_date.dart';

class CommentsSectionLoadingView extends StatelessWidget {
  const CommentsSectionLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SkeletonLoadingView(
      cardsCount: 10,
      card: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: theme.bottomNavigationBarTheme.backgroundColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommentItemDate(isAuthor: false, commentDate: DateTime.now()),
                  const CommentItemAuthor(
                    isAuthor: false,
                    postAuthorName: "--------------",
                    postAuthorImage: "-",
                    postAuthorAccessLevel: 0,
                  ),
                ],
              ),
              Spaces.space10,
              const CommentItemContent(
                isAuthor: false,
                commentContent:
                    "---------------------------------------------------------------------------------",
              ),
              Spaces.space10,
              //! const CommentItemFooter(),  will be implemented later
            ],
          ),
        ),
      ),
    );
  }
}
