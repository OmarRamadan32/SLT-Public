import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:new_slt/features/posts/data/models/post_model.dart';
import 'package:new_slt/features/posts/data/repo/posts_repo.dart';
part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final PostsRepo postsRepo;
  PostsCubit({required this.postsRepo}) : super(PostsInitial());

  List<PostModel> pendingPostsList = [];
  List<PostModel> approvedPostsList = [];
  PostModel? currentPost;
  List<PostModel> allPostsList = [];

  Future<void> signSpost({
    required String postId,
    required String userId,
  }) async {
    emit(PostsLoadingState());
    var result = await postsRepo.signPost(postId: postId, userId: userId);
    result.fold((error) {
      emit(PostsFailureState(errorMessage: error.message));
    }, (r) => emit(PostSignedState()));
  }

  Future<void> getApprovedPosts({
    int limit = 5,
    String? startAfter,
    bool append = false,
  }) async {
    if (!append) {
      emit(PostsLoadingState());
    } else {
      emit(PostsLoadingMoreState());
    }
    var result = await postsRepo.getApprovedPosts(
      limit: limit,
      startAfter: startAfter,
    );
    result.fold(
      (error) => emit(PostsFailureState(errorMessage: error.message)),
      (posts) {
        if (posts.isEmpty && append) {
          emit(PostsNoMorePostsState());
        } else {
          if (append) {
            approvedPostsList.addAll(posts);
          } else {
            approvedPostsList = posts;
          }
          if (!isClosed) {
            if (posts.length < limit && append) {
              emit(PostsNoMorePostsState());
            } else {
              emit(PostsSuccessState());
            }
          }
        }
      },
    );
  }

  Future<void> getPendingPosts({
    int limit = 5,
    String? startAfter,
    bool append = false,
  }) async {
    if (append) {
      emit(PostsLoadingMoreState());
    } else {
      emit(PostsLoadingState());
    }

    var result = await postsRepo.getPendingPosts(
      limit: limit,
      startAfter: startAfter,
    );
    result.fold(
      (error) => emit(PostsFailureState(errorMessage: error.message)),
      (posts) {
        if (posts.isEmpty && append) {
          emit(PostsNoMorePendingPostsState());
        } else {
          if (append) {
            pendingPostsList.addAll(posts);
          } else {
            pendingPostsList = posts;
          }
          if (!isClosed) {
            if (append && posts.length < limit) {
              emit(PostsNoMorePendingPostsState());
            } else {
              emit(PostsSuccessState());
            }
          }
        }
      },
    );
  }

  Future<void> approvePost({
    required String postId,
    required String authorId,
  }) async {
    emit(PostsLoadingState());
    var result = await postsRepo.approvePost(
      postId: postId,
      postAuthorId: authorId,
    );
    result.fold(
      (error) => emit(PostsFailureState(errorMessage: error.message)),
      (nothing) {
        emit(PostsApprovedState());
      },
    );
  }

  Future<void> deletePost({required String postId}) async {
    emit(PostsLoadingState());
    var result = await postsRepo.deletePost(postId: postId);
    result.fold(
      (error) => emit(PostsFailureState(errorMessage: error.message)),
      (nothing) {
        emit(PostsDeletedState());
      },
    );
  }
}
