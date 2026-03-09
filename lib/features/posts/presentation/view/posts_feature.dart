import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/load_more_widget.dart';
import 'package:new_slt/features/posts/data/models/post_model.dart';
import 'package:new_slt/features/posts/presentation/cubits/post_cubit/posts_cubit.dart';
import 'package:new_slt/features/posts/presentation/view/post_loading_view.dart';
import 'package:new_slt/features/posts/presentation/widgets/add_post_buttons.dart';
import 'package:new_slt/features/posts/presentation/widgets/post_related/posts_view.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/widgets/empty_view_widget.dart';

class PostsFeature extends StatefulWidget {
  const PostsFeature({super.key});

  @override
  State<PostsFeature> createState() => _PostsFeatureState();
}

class _PostsFeatureState extends State<PostsFeature> {
  @override
  void initState() {
    context.read<PostsCubit>().getApprovedPosts(limit: 5);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsState>(
      builder: (context, state) {
        if (state is PostsLoadingState) {
          return const PostLoadingView();
        } else if (state is PostsFailureState) {
          return ErrorWidget(state.errorMessage);
        } else {
          List<PostModel> posts = context.read<PostsCubit>().approvedPostsList;
          if (posts.isEmpty) {
            return const Column(
              children: [
                EmptyViewWidget(
                  isCentered: true,
                  message: "لا توجد أي بوستات",
                  viewTitle: "البوستات",
                ),
              ],
            );
          } else {
            return Column(
              children: [
                // const TitleWidget(title: "البوستات"),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: SizedBox(
                //     width: 75.w,
                //     child: Divider(
                //       color: Theme.of(context).primaryColor,
                //       thickness: 0.5,
                //     ),
                //   ),
                // ),
                Spaces.space10,
                const AddPostButtons(),
                Spaces.space10,
                PostsView(posts: posts),
                LoadMoreWidget(
                  isDone: state is PostsNoMorePostsState,
                  onTap: () {
                    context.read<PostsCubit>().getApprovedPosts(
                      startAfter: posts.last.postId,
                      append: true,
                    );
                  },
                  isLoading: state is PostsLoadingMoreState,
                ),
              ],
            );
          }
        }
      },
      listener: (context, state) {
        if (state is PostsFailureState) {
          Helpers.showSnackBar(
            context,
            state.errorMessage,
            isFailureMessage: true,
          );
        }
        if (state is PostSignedState) {
          Helpers.showSnackBar(
            context,
            "تمت العملية بنجاح",
            isSuccessMessage: true,
          );
        }
        if (state is PostsNoMorePostsState) {
          Helpers.showSnackBar(context, "تم عرض جميع البوستات");
        }
      },
    );
  }
}
