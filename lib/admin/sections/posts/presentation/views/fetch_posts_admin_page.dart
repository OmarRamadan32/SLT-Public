import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_slt/core/constants/constants.dart';
import 'package:new_slt/core/theme/spaces.dart';
import 'package:new_slt/core/widgets/empty_view_widget.dart';
import 'package:new_slt/core/widgets/load_more_widget.dart';
import 'package:new_slt/features/posts/presentation/widgets/post_related/post_card.dart';
import 'package:new_slt/features/user/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:new_slt/core/utils/helpers.dart';
import 'package:new_slt/core/routes/app_router.dart';
import 'package:new_slt/core/widgets/error_message_widget.dart';
import 'package:new_slt/core/widgets/loading_widget.dart';
import 'package:new_slt/admin/presentation/shared_widgets/dashboard_screen_widget.dart';
import 'package:new_slt/admin/sections/posts/data/models/fetch_posts_page_model.dart';
import 'package:new_slt/admin/sections/posts/presentation/cubit/posts_dashboard_cubit.dart';
import 'package:new_slt/admin/sections/posts/presentation/widgets/remove_post_dialog_view.dart';

class FetchPostsAdminPage extends StatefulWidget {
  const FetchPostsAdminPage({super.key, required this.showPostsPageModel});
  final ShowPostsPageModel showPostsPageModel;

  @override
  State<FetchPostsAdminPage> createState() => _FetchPostsAdminPageState();
}

class _FetchPostsAdminPageState extends State<FetchPostsAdminPage> {
  Future<void> deletePostFunction(
    BuildContext context,
    int index,
    String postId,
  ) async {
    final postsCubit = context.read<PostsDashboardCubit>();
    await postsCubit.deletePost(postId: postId);
    await fetchPostsFunction();
  }

  @override
  void initState() {
    super.initState();
    fetchPostsFunction();
  }

  Future<void> fetchPostsFunction() async {
    final int userAccessLevel = context.read<UserCubit>().getUserAccessLevel();
    if (userAccessLevel >= Constants.adminAccessLevel) {
      context.read<PostsDashboardCubit>().getAllPosts();
    } else {
      context.read<PostsDashboardCubit>().getAllUserPosts(
        userId: context.read<UserCubit>().userModel!.id!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DashboardScreenWidget(
      appBarTitle: widget.showPostsPageModel.title,
      child: BlocConsumer<PostsDashboardCubit, PostsDashboardState>(
        builder: (context, state) {
          PostsDashboardCubit postsCubit = context.read<PostsDashboardCubit>();
          if (state is PostsDashboardLoadingState) {
            return const LoadingWidget(isCentered: true);
          } else if (state is PostsDashboardFailureState) {
            return ErrorMessageWidget(
              message: state.errorMessage,
              isCentered: true,
            );
          } else {
            if (postsCubit.postsModels.isNotEmpty) {
              return Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: postsCubit.postsModels.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (widget.showPostsPageModel.isDeletePage) {
                            Helpers.showDialogMethod(
                              context,
                              dialogTitle: "حذف بوست",
                              actionsWidget: RemovePostDialogView(
                                onRemove:
                                    () => deletePostFunction(
                                      context,
                                      index,
                                      postsCubit.postsModels[index].postId!,
                                    ),
                              ),
                            );
                          } else {
                            if (postsCubit.postsModels[index].isSpecialPost ==
                                true) {
                              context.pushReplacement(
                                "${AppRouter.kEditSpecialPostAdminPage}/${postsCubit.postsModels[index].postId}",
                              );
                            } else if (postsCubit
                                    .postsModels[index]
                                    .isSpecialPost ==
                                false) {
                              context.pushReplacement(
                                "${AppRouter.kEditPostAdminPage}/${postsCubit.postsModels[index].postId}",
                              );
                            }
                          }
                        },
                        child: AbsorbPointer(
                          absorbing: true,
                          child: PostCard(
                            maxLines: 10000,
                            postModel:
                                context
                                    .read<PostsDashboardCubit>()
                                    .postsModels[index],
                          ),
                        ),
                      );
                    },
                  ),
                  postsCubit.postsModels.isNotEmpty
                      ? LoadMoreWidget(
                        onTap: () {
                          int userAccessLevel =
                              context.read<UserCubit>().getUserAccessLevel();
                          if (userAccessLevel >= Constants.adminAccessLevel) {
                            postsCubit.getAllPosts(
                              append: true,
                              startAfter: postsCubit.postsModels.last.postId,
                            );
                          } else {
                            context.read<PostsDashboardCubit>().getAllUserPosts(
                              startAfter:
                                  context
                                      .read<PostsDashboardCubit>()
                                      .postsModels
                                      .last
                                      .postId,
                              userId: context.read<UserCubit>().userModel!.id!,
                              append: true,
                            );
                          }
                        },
                        isLoading: state is PostsDashboardLoadingMoreState,
                        isDone: state is PostsDashboardNoMoreState,
                      )
                      : const SizedBox(),
                  Spaces.inSectionSpace20,
                ],
              );
            } else {
              return const EmptyViewWidget(
                isCentered: true,
                message: "لا توجد اي بوستات لعرضها",
              );
            }
          }
        },
        listener: (context, state) {
          if (state is PostsDashboardFailureState) {
            Helpers.showSnackBar(context, state.errorMessage);
          }
          if (state is PostsDashboardSuccessState) {
            Helpers.showSnackBar(
              context,
              "تم حذف البوست بنجاح",
              isSuccessMessage: true,
            );
          }
          if (state is PostsDashboardNoMoreState) {
            Helpers.showSnackBar(context, "لا يوجد المزيد من البوستات");
          }
        },
      ),
    );
  }
}
