part of 'posts_cubit.dart';

@immutable
sealed class PostsState {}

final class PostsInitial extends PostsState {}

final class PostsLoadingState extends PostsState {}

final class PostsLoadedState extends PostsState {
  final List<PostModel> postsList;
  PostsLoadedState({required this.postsList});
}

final class PostsLoadingMoreState extends PostsState {}

final class PostsNoMorePostsState extends PostsState {}

final class PostsNoMorePendingPostsState extends PostsState {}
final class SinglePostLoadedState extends PostsState {
  final PostModel post;
  SinglePostLoadedState({required this.post});
}

final class PostsSuccessState extends PostsState {}

final class PostsDeletedState extends PostsState {}

final class PostsApprovedState extends PostsState {}

final class PostSignedState extends PostsState {}

final class PostsFailureState extends PostsState {
  final String errorMessage;
  PostsFailureState({required this.errorMessage});
}
