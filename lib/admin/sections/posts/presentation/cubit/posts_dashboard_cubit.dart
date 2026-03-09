import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:new_slt/features/posts/data/models/post_model.dart';
import 'package:new_slt/features/posts/data/repo/posts_repo.dart';

part 'posts_dashboard_state.dart';

class PostsDashboardCubit extends Cubit<PostsDashboardState> {
  final PostsRepo postsRepo;
  PostsDashboardCubit({required this.postsRepo})
    : super(PostsDashboardInitial());

  List<PostModel> postsModels = [];

  Future<void> addPost({required PostModel postModel}) async {
    emit(PostsDashboardLoadingState());
    var result = await postsRepo.addPost(postModel: postModel);
    result.fold(
      (err) => emit(PostsDashboardFailureState(errorMessage: err.message)),
      (r) => emit(PostsDashboardSuccessState()),
    );
  }

  Future<void> updatePost({
    required String postId,
    required PostModel postModel,
  }) async {
    emit(PostsDashboardLoadingState());
    var result = await postsRepo.updatePost(
      postId: postId,
      postModel: postModel,
    );
    result.fold(
      (error) => emit(PostsDashboardFailureState(errorMessage: error.message)),
      (r) => emit(SinglePostDashboardUpdatedState()),
    );
  }

  Future<void> deletePost({required String postId}) async {
    emit(PostsDashboardLoadingState());
    var result = await postsRepo.deletePost(postId: postId);
    result.fold(
      (error) => emit(PostsDashboardFailureState(errorMessage: error.message)),
      (r) => emit(PostsDashboardSuccessState()),
    );
  }

  Future<void> getAllPosts({
    int? limit = 5,
    dynamic startAfter,
    bool append = false,
  }) async {
    if (!append) {
      emit(PostsDashboardLoadingState());
    } else {
      emit(PostsDashboardLoadingMoreState());
    }
    var result = await postsRepo.getAllPosts(
      limit: limit,
      startAfter: startAfter,
    );
    result.fold(
      (error) => emit(PostsDashboardFailureState(errorMessage: error.message)),
      (posts) {
        if (posts.isEmpty && append) {
          emit(PostsDashboardNoMoreState());
        } else {
          if (append) {
            postsModels.addAll(posts);
          } else {
            postsModels = posts;
          }
          emit(PostsDashboardLoadedState());
        }
      },
    );
  }

  Future<void> getAllUserPosts({
    required String userId,
    int? limit = 5,
    dynamic startAfter,
    bool append = false,
  }) async {
    if (!append) {
      emit(PostsDashboardLoadingState());
    } else {
      emit(PostsDashboardLoadingMoreState());
    }
    var result = await postsRepo.getAllUserPosts(
      startAfter: startAfter,
      limit: limit,
      userId: userId,
    );
    result.fold(
      (error) => emit(PostsDashboardFailureState(errorMessage: error.message)),
      (posts) {
        if (posts.isEmpty) {
          emit(PostsDashboardNoMoreState());
        } else {
          if (append) {
            postsModels.addAll(posts);
          } else {
            postsModels = posts;
          }
          emit(PostsDashboardLoadedState());
        }
      },
    );
  }

  Future<void> getPostById({required String postId}) async {
    emit(PostsDashboardLoadingState());
    var result = await postsRepo.getPostById(postId: postId);
    result.fold(
      (error) => emit(PostsDashboardFailureState(errorMessage: error.message)),
      (post) => emit(SinglePostDashboardLoadedState(post: post)),
    );
  }
}
