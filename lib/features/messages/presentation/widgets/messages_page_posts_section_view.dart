import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/widgets/screen_widget/access_level_check_view.dart';
import 'package:new_slt/core/widgets/load_more_widget.dart';
import 'package:new_slt/features/messages/presentation/widgets/messages_page_pending_posts_dialog.dart';
import 'package:new_slt/features/posts/data/models/post_model.dart';
import 'package:new_slt/features/posts/presentation/cubits/post_cubit/posts_cubit.dart';
import 'package:new_slt/features/posts/presentation/widgets/post_related/post_card.dart';

class MessagesPagePostsSectionView extends StatelessWidget {
  const MessagesPagePostsSectionView({
    super.key,
    required this.posts,
    required this.state,
  });

  final List<PostModel> posts;
  final PostsState state;

  @override
  Widget build(BuildContext context) {
    return AccessLevelCheckView(
      authorizedAccessLevel: 2,
      view: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: GestureDetector(
                        onTap: () {
                          Helpers.showDialogMethod(
                            context,
                            dialogTitle: "بوست معلق",
                            actionsWidget: MessagesPagePendingPostsDialog(
                              onAccept: () async {
                                await context.read<PostsCubit>().approvePost(
                                  authorId: posts[index].postAuthorId,
                                  postId: posts[index].postId!,
                                );
                              },
                              onDecline: () async {
                                await context.read<PostsCubit>().deletePost(
                                  postId: posts[index].postId!,
                                );
                              },
                            ),
                          );
                        },
                        child: AbsorbPointer(
                          absorbing: true,
                          child: PostCard(
                            maxLines: 10000,
                            postModel: posts[index],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          LoadMoreWidget(
            isDone: state is PostsNoMorePendingPostsState,
            onTap: () {
              context.read<PostsCubit>().getPendingPosts(
                startAfter: posts.last.postId,
                append: true,
              );
            },
            isLoading: state is PostsLoadingMoreState,
          ),
          Spaces.inSectionSpace20,
        ],
      ),
    );
  }
}
