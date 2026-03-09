part of 'campaign_cubit.dart';

@immutable
sealed class CampaignState {}

final class CampaignInitialState extends CampaignState {}
final class CampaignLoadingState extends CampaignState {}
final class CampaignErrorState extends CampaignState {
  final String message;
  CampaignErrorState({required this.message});
}
final class CampaignActivitiesErrorState extends CampaignState {
  final String message;
  CampaignActivitiesErrorState({required this.message});
}
final class CampaignActivityErrorState extends CampaignState {
  final String message;
  CampaignActivityErrorState({required this.message});
}
final class CamapaignSuccessState extends CampaignState {}
