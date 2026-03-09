part of 'committee_dashboard_cubit.dart';

@immutable
sealed class CommitteeDashboardState {}

final class CommitteeDashboardInitialState extends CommitteeDashboardState {}

final class CommitteeDashboardLoadingState extends CommitteeDashboardState {}

final class CommitteeDashboardErrorState extends CommitteeDashboardState {
  final String message;
  CommitteeDashboardErrorState({required this.message});
}

final class CommitteeDashboardSuccessState extends CommitteeDashboardState {}
// ? committee settings states
final class CommitteeDashboardleaderChangedState
    extends CommitteeDashboardState {}

final class CommitteeDashboardMembersUpdatedState
    extends CommitteeDashboardState {}

//? add committee states
final class CommitteeDashboardCommitteeAddedState
    extends CommitteeDashboardState {}

