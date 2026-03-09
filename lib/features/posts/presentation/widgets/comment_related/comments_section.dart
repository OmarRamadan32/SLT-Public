import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/core/widgets/small_note_widget.dart';
import 'package:new_slt/features/posts/data/models/comment_model.dart';
import 'package:new_slt/features/posts/presentation/cubits/comment_cubit/comment_cubit.dart';
import 'package:new_slt/features/posts/presentation/cubits/post_cubit/posts_cubit.dart';
import 'package:new_slt/features/posts/presentation/view/comments_section_loading_view.dart';
import 'package:new_slt/features/posts/presentation/view/comments_section_view.dart';
import 'package:new_slt/features/posts/presentation/widgets/comment_related/post_comment_field.dart';

class CommentsSection extends StatefulWidget {
  const CommentsSection({
    super.key,
    required this.postID,
    this.commentID,
    this.commentAuthorId,
  });
  final String postID;
  final String? commentID;
  final String? commentAuthorId;

  @override
  State<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  Future<void> addCommentFunc() async {
    PostsCubit postsCubit = context.read<PostsCubit>();
    CommentCubit commentCubit = context.read<CommentCubit>();
    UserCubit userCubit = context.read<UserCubit>();
    CommentModel commentModel = CommentModel(
      repliesCount: 0,
      mentions: userCubit.selectedUsers.map((e) => e.id!).toList(),
      commentAuthorName: userCubit.userModel!.name,
      commentAuthorId: userCubit.userModel!.id!,
      commentDate: DateTime.now(),
      commentText: commentText,
    );
    await commentCubit.addComment(
      commentAuthorId: widget.commentAuthorId,
      commentId: widget.commentID,
      commentModel: commentModel,
      postId: widget.postID,
      postAuthorId: postsCubit.currentPost!.postAuthorId,
    );
  }

  String commentText = "";

  @override
  void initState() {
    context.read<CommentCubit>().getComments(
      postId: widget.postID,
      commentId: widget.commentID,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // add comment
        PostCommentField(
          onTap: (comment) async {
            // close keyboard
            FocusManager.instance.primaryFocus?.unfocus();
            commentText = comment;
            await addCommentFunc();
          },
        ),
        const SmallNoteWidget(content: "إضغط ضغطة مطولة علي التعليق للخيارات"),
        BlocConsumer<CommentCubit, CommentState>(
          builder: (context, state) {
            if (state is CommentLoadingState) {
              return const CommentsSectionLoadingView();
            } else if (state is CommentErrorState) {
              return ErrorMessageWidget(
                isCentered: true,
                message: state.message,
              );
            } else {
              return CommentsSectionView(
                postID: widget.postID,
                commentID: widget.commentID,
                state: state,
              );
            }
          },
          listener: (context, state) async {
            commentsSectionListeners(state, context);
          },
        ),
      ],
    );
  }

  void commentsSectionListeners(CommentState state, BuildContext context) {
    if (state is CommentAddedState) {
      Helpers.showSnackBar(
        context,
        "تم اضافة التعليق بنجاح",
        isSuccessMessage: true,
      );
      context.read<UserCubit>().reset();
      if (ModalRoute.of(context)?.isCurrent ?? false) {
        context.read<CommentCubit>().getComments(
          postId: widget.postID,
          commentId: widget.commentID,
        );
      }
    }
    if (state is CommentDeletedState) {
      Helpers.showSnackBar(
        context,
        "تم حذف التعليق بنجاح",
        isSuccessMessage: true,
      );
      if (ModalRoute.of(context)?.isCurrent ?? false) {
        context.read<CommentCubit>().getComments(
          postId: widget.postID,
          commentId: widget.commentID,
        );
      }
    }
    if (state is CommentUpdatedState) {
      Helpers.showSnackBar(
        context,
        "تم تعديل تعليقك بنجاح",
        isSuccessMessage: true,
      );
      context.read<UserCubit>().reset();
      if (ModalRoute.of(context)?.isCurrent ?? false) {
        context.read<CommentCubit>().getComments(
          postId: widget.postID,
          commentId: widget.commentID,
        );
      }
    } else if (state is CommentErrorState) {
      Helpers.showSnackBar(context, state.message, isFailureMessage: true);
    }
  }
}
