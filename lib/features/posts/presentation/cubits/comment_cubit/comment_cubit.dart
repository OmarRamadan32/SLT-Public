import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:new_slt/features/posts/data/models/comment_model.dart';
import 'package:new_slt/features/posts/data/repo/posts_repo.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  final PostsRepo postsRepo;
  CommentCubit({required this.postsRepo}) : super(CommentInitial());
  List<CommentModel> comments = [];
  CommentModel? commentModel;

  Future<void> addComment({
    required CommentModel commentModel,
    required String postId,
    required String postAuthorId,
    String? commentId,
    String? commentAuthorId,
  }) async {
    emit(CommentLoadingState());
    final result = await postsRepo.addComment(
      postAuthorId: postAuthorId,
      commentModel: commentModel,
      postId: postId,
      commentId: commentId,
      commentAuthorId: commentAuthorId,
    );
    result.fold(
      (l) => emit(CommentErrorState(message: l.message)),
      (r) => emit(CommentAddedState()),
    );
  }

  Future<void> deleteComment({
    required String commentId,
    required String postId,
    String? repledCommentId,
  }) async {
    emit(CommentLoadingState());
    final result = await postsRepo.deleteComment(
      commentId: commentId,
      postId: postId,
      repledCommentId:  repledCommentId,
    );
    result.fold(
      (l) => emit(CommentErrorState(message: l.message)),
      (r) => emit(CommentDeletedState()),
    );
  }

  Future<void> updateComment({
    required CommentModel commentModel,
    required String commentId,
    required String postId,
    String? repledCommentId,
  }) async {
    emit(CommentLoadingState());
    final result = await postsRepo.updateComment(
      commentModel: commentModel,
      commentId: commentId,
      postId: postId,
      repledCommentId: repledCommentId
    );
    result.fold(
      (l) => emit(CommentErrorState(message: l.message)),
      (r) => emit(CommentUpdatedState()),
    );
  }

  Future<void> getComments({
    required String postId,
    String? startAfter,
    bool append = false,
    String? commentId,
  }) async {
    print("--------------------");
    print("fetching comments");
    print("--------------------");
    final int limit = 5;
    if (!append) {
      emit(CommentLoadingState());
    } else {
      emit(CommentLoadingMoreState());
    }
    final result = await postsRepo.getComments(
      postId: postId,
      limit: limit,
      startAfter: startAfter,
      commentId: commentId,
    );
    result.fold((l) => emit(CommentErrorState(message: l.message)), (r) {
      if (append) {
        comments.addAll(r);
      } else {
        comments = r;
      }
      if (!isClosed) {
        if (r.length < limit) {
          emit(CommentNoMoreState());
        } else {
          emit(CommentSuccessState());
        }
      }
    });
  }
}
