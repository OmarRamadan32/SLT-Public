import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/features/posts/data/models/comment_model.dart';
import 'package:new_slt/features/posts/presentation/cubits/comment_cubit/comment_cubit.dart';
import 'package:new_slt/features/posts/presentation/widgets/comment_related/comment_item_author.dart';
import 'package:new_slt/features/posts/presentation/widgets/comment_related/comment_item_content.dart';
import 'package:new_slt/features/posts/presentation/widgets/comment_related/comment_item_date.dart';
import 'package:new_slt/features/posts/presentation/widgets/comment_related/comment_item_options.dart';
import 'package:new_slt/features/posts/presentation/widgets/comment_related/comment_item_reply.dart';
import 'package:new_slt/features/posts/presentation/widgets/comment_related/comment_mentions.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({
    super.key,
    required this.commentModel,
    required this.postId,
    required this.canReply,
    this.repledCommentId,
  });
  final CommentModel commentModel;
  final String postId;
  final bool canReply;
  final String? repledCommentId;

  Future<void> updateCommentFunc({
    required String newCommentText,
    required BuildContext context,
  }) async {
    CommentModel newCommentModel = CommentModel(
      mentions: context.read<UserCubit>().selectedUsers,
      commentAuthorId: commentModel.commentAuthorId,
      commentDate: commentModel.commentDate,
      commentText: newCommentText,
    );
    await context.read<CommentCubit>().updateComment(
      repledCommentId: repledCommentId,
      commentModel: newCommentModel,
      commentId: commentModel.commentId!,
      postId: postId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isAdmin = context.read<UserCubit>().isAdmin();
    final String userId = context.read<UserCubit>().userModel!.id!;
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: GestureDetector(
        onLongPress: () {
          if (isAdmin || commentModel.commentAuthorId == userId) {
            Helpers.showBottomSheetMethod(
              context: context,
              child: Container(
                height: 100.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal:
                      commentModel.commentAuthorId != userId ? 100.w : 30.w,
                  vertical: 25.h,
                ),
                decoration: BoxDecoration(
                  color: theme.bottomNavigationBarTheme.backgroundColor,

                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                ),
                child: CommentItemOptions(
                  isCommentAuthor: commentModel.commentAuthorId == userId,
                  deleteComment: () {
                    context.read<CommentCubit>().deleteComment(
                      repledCommentId: repledCommentId,
                      postId: postId,
                      commentId: commentModel.commentId!,
                    );
                  },
                  updateComment: (newCommentText) {
                    context.pop();
                    updateCommentFunc(
                      newCommentText: newCommentText,
                      context: context,
                    );
                  },
                  oldCommentText: commentModel.commentText,
                  commentId: commentModel.commentId!,
                  postId: postId,
                ),
              ),
            );
          } else {
            Helpers.showSnackBar(context, "ياعم مش بتاعك ده");
          }
        },
        child: Container(
          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
          decoration: BoxDecoration(
            color:
                commentModel.commentAuthorId == userId
                    ? theme.primaryColor
                    : theme.bottomNavigationBarTheme.backgroundColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommentItemDate(
                    isAuthor: commentModel.commentAuthorId == userId,
                    commentDate: commentModel.commentDate,
                  ),
                  CommentItemAuthor(
                    isAuthor: commentModel.commentAuthorId == userId,
                    postAuthorName: commentModel.commentAuthorName ?? "مجهول",
                    postAuthorImage: commentModel.commentAuthorImage ?? "",
                    postAuthorAccessLevel:
                        commentModel.commentAuthorAccessLevel ?? 0,
                  ),
                ],
              ),
              Spaces.space10,
              CommentItemContent(
                isAuthor: commentModel.commentAuthorId == userId,
                commentContent: commentModel.commentText,
              ),
              if (canReply == false && commentModel.mentions.isNotEmpty)
                Spaces.space10,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  canReply
                      ? Align(
                        alignment: Alignment.centerLeft,
                        child: CommentItemReply(
                          isAuthor: commentModel.commentAuthorId == userId,
                          commentModel: commentModel,
                          postId: postId,
                        ),
                      )
                      : Spaces.space10,
                  CommentMentions(
                    isAuthor: commentModel.commentAuthorId == userId,
                    mentionedNames:
                        commentModel.mentions
                            .map<String>((e) => e.name)
                            .toList(),
                  ),
                ],
              ),
              if (canReply == false) Spaces.space10,
            ],
          ),
        ),
      ),
    );
  }
}
