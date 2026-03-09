// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/widgets/empty_view_widget.dart';
import 'package:new_slt/features/messages/presentation/widgets/messages_page_posts_section_view.dart';
import 'package:new_slt/features/posts/data/models/post_model.dart';
import 'package:new_slt/features/posts/presentation/cubits/post_cubit/posts_cubit.dart';
import 'package:new_slt/features/posts/presentation/view/post_loading_view.dart';

class MessagesPagePostsSection extends StatelessWidget {
  const MessagesPagePostsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      builder: (context, state) {
        if (state is PostsLoadingState) {
          return const PostLoadingView();
        } else if (state is PostsFailureState) {
          return ErrorWidget(state.errorMessage);
        } else {
          List<PostModel> posts = context.read<PostsCubit>().pendingPostsList;
          if (posts.isNotEmpty) {
            return MessagesPagePostsSectionView(posts: posts, state: state);
          } else {
            return const EmptyViewWidget(message: "لا توجد بوستات معلقة");
          }
        }
      },
      listener: (context, state) async {
        PostsCubit postsCubit = context.read<PostsCubit>();
        if (state is PostsApprovedState) {
          Helpers.showSnackBar(
            context,
            'تم قبول البوست بنجاح',
            isSuccessMessage: true,
          );
          await postsCubit.getPendingPosts();
          await postsCubit.getApprovedPosts();
        }
        if (state is PostsDeletedState) {
          Helpers.showSnackBar(
            context,
            'تم حذف البوست بنجاح',
            isSuccessMessage: true,
          );
          await postsCubit.getPendingPosts();
          await postsCubit.getApprovedPosts();
        }
        if (state is PostsFailureState) {
          Helpers.showSnackBar(context, state.errorMessage);
        } else if (state is PostsNoMorePendingPostsState) {
          Helpers.showSnackBar(context, "تم عرض جميع البوستات المعلقة");
        }
      },
    );
  }
}
