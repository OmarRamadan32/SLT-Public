part of 'council_dashboard_cubit.dart';

@immutable
sealed class CouncilDashboardState {}
//? main states

final class CouncilDashboardSuccessState extends CouncilDashboardState {}

final class CouncilDashboardErrorState extends CouncilDashboardState {
  final String message;
  CouncilDashboardErrorState({required this.message});
}

final class CouncilDashboardLoadingState extends CouncilDashboardState {}

final class CouncilDashboardInitialState extends CouncilDashboardState {}
// ----------------------------------------------------

//? add council admin page
final class CouncilDashboardCouncilAddedState extends CouncilDashboardState {}
// ----------------------------------------------------

//? council,swa3ed,group settings page
final class CouncilDashboardLeaderUpdatedState extends CouncilDashboardState {}

final class CouncilDashboardMembersUpdatedState extends CouncilDashboardState {}

final class CouncilDashboardEndedState
    extends CouncilDashboardState {} // for End Council Method
final class CouncilDashboardGroupShiledAddedState extends CouncilDashboardState {}

// ----------------------------------------------------