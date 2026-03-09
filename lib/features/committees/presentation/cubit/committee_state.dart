part of 'committee_cubit.dart';

@immutable
sealed class CommitteeState {}

final class CommitteeInitialState extends CommitteeState {}
final class CommitteeLoadingState extends CommitteeState {}
final class CommitteeErrorState extends CommitteeState {
  final String message;
  CommitteeErrorState({required this.message});
}

final class CommitteeSuccessState extends CommitteeState {}
