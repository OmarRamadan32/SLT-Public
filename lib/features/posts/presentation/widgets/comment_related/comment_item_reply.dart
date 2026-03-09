import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/features/posts/data/models/comment_model.dart';
import 'package:new_slt/features/posts/data/models/content_page_model.dart';
import 'package:new_slt/features/posts/presentation/cubits/comment_cubit/comment_cubit.dart';

class CommentItemReply extends StatelessWidget {
  const CommentItemReply({
    super.key,
    required this.commentModel,
    required this.postId,
    required this.isAuthor,
  });

  final CommentModel commentModel;
  final String postId;
  final bool isAuthor;

  @override
  Widget build(BuildContext context) {
    CommentCubit commentCubit = context.read<CommentCubit>();
    ThemeData theme = Theme.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        alignment: Alignment.centerLeft,
        backgroundColor: Colors.transparent,
        elevation: 0,
        padding: EdgeInsets.zero,
        minimumSize: const Size(0, 0),
      ),
      onPressed: () async {
        await context.push(
          "${AppRouter.kPostPage}/$postId",
          extra: ContentPageModel(
            contentAuthorID: commentModel.commentAuthorId,
            contentDate: commentModel.commentDate,
            contentAuthorName: commentModel.commentAuthorName ?? "بدون اسم",
            contentAuthorImage: commentModel.commentAuthorImage ?? "",
            contentText: commentModel.commentText,
            contentID: commentModel.commentId,
          ),
        );
        await commentCubit.getComments(
          postId: postId,
        ); // This method will be called when the next page is closed
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          commentModel.repliesCount != null
              ? Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Text(
                  commentModel.repliesCount!.toString(),
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color:
                        isAuthor
                            ? theme.bottomNavigationBarTheme.backgroundColor
                            : theme.primaryColor,
                  ),
                ),
              )
              : const SizedBox(),
          Icon(
            size: 20.sp,
            Icons.subdirectory_arrow_right_rounded,
            color:
                isAuthor
                    ? theme.bottomNavigationBarTheme.backgroundColor
                    : theme.primaryColor,
          ),
        ],
      ),
    );
  }
}
