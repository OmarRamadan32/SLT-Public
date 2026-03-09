part of 'messages_cubit.dart';

@immutable
sealed class MessagesState {}

final class MessagesInitialState extends MessagesState {}

final class MessagesLoadingState extends MessagesState {}

final class MessagesSuccessState extends MessagesState {}

final class MessagesLoadingMoreState extends MessagesState {}

final class MessagesNoMoreState extends MessagesState {}

final class MessagesNoMorePrivateState extends MessagesState {}

final class MessagesNoMoreTeamState extends MessagesState {}

final class MessagesErrorState extends MessagesState {
  final String error;
  MessagesErrorState({required this.error});
}
