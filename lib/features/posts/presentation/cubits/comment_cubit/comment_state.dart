part of 'comment_cubit.dart';

@immutable
sealed class CommentState {}

final class CommentInitial extends CommentState {}

final class CommentLoadingState extends CommentState {}

final class CommentLoadingMoreState extends CommentState {}

final class CommentNoMoreState extends CommentState {}

final class CommentErrorState extends CommentState {
  final String message;
  CommentErrorState({required this.message});
}

final class CommentSuccessState extends CommentState {}

final class CommentDeletedState extends CommentState {}

final class CommentAddedState extends CommentState {}

final class CommentUpdatedState extends CommentState {}
