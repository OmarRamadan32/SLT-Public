part of 'team_history_cubit.dart';

@immutable
sealed class TeamHistoryState {}

final class TeamHistoryInitial extends TeamHistoryState {}

final class TeamHistoryLoadingState extends TeamHistoryState {}

final class TeamHistorySuccessState extends TeamHistoryState {}

final class TeamHistoryErrorState extends TeamHistoryState {
  final String message;
  TeamHistoryErrorState({required this.message});
}



