part of 'campaign_dashboard_cubit.dart';

@immutable
sealed class CampaignDashboardState {}

final class CampaignDashboardInitialState extends CampaignDashboardState {}

final class CampaignDashboardLoadingState extends CampaignDashboardState {}

final class CampaignDashboardSuccessState extends CampaignDashboardState {}

final class CampaignDashboardErrorState extends CampaignDashboardState {
  final String error;
  CampaignDashboardErrorState({required this.error});
}

// ------------------------------------------------------------------
//? for council and activity settings page
final class CampaignDashboardLeaderChangedState
    extends CampaignDashboardState {}

final class CamapaignDashboardMembersUpdatedState
    extends CampaignDashboardState {}

// -------------------------------------------------------------------
//? add Events States
final class CampaignDashboardEventAddedState extends CampaignDashboardState {}
// -------------------------------------------------------------------