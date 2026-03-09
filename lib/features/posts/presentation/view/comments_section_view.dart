import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/load_more_widget.dart';
import 'package:new_slt/core/widgets/title_widget.dart';
import 'package:new_slt/features/posts/presentation/cubits/comment_cubit/comment_cubit.dart';
import 'package:new_slt/features/posts/presentation/view/comments_section_empty_view.dart';
import 'package:new_slt/features/posts/presentation/widgets/comment_related/comment_item.dart';

class CommentsSectionView extends StatelessWidget {
  const CommentsSectionView({
    super.key,
    required this.postID,
    this.commentID,
    required this.state,
  });
  final String postID;
  final String? commentID;
  final CommentState state;

  @override
  Widget build(BuildContext context) {
    CommentCubit commentCubit = context.read<CommentCubit>();
    ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Spaces.inSectionSpace20,
        const TitleWidget(title: "التعليقات"),
        SizedBox(
          width: 100.w,
          child: Divider(color: theme.primaryColor, thickness: 0.8),
        ),
        Spaces.inSectionSpace20,
        commentCubit.comments.isEmpty
            ? const CommentsSectionEmptyView()
            : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: commentCubit.comments.length,
              itemBuilder: (context, index) {
                return CommentItem(
                  repledCommentId: commentID,
                  postId: postID,
                  commentModel: commentCubit.comments[index],
                  canReply: commentID == null ? true : false,
                );
              },
            ),
        Center(
          child: LoadMoreWidget(
            onTap: () async {
              await commentCubit.getComments(
                commentId: commentID,
                postId: postID,
                startAfter: commentCubit.comments.last.commentId,
                append: true,
              );
            },
            isLoading: state is CommentLoadingMoreState,
            isDone: state is CommentNoMoreState,
          ),
        ),
      ],
    );
  }
}
