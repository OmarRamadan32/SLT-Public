part of 'members_dashboard_cubit.dart';

@immutable
sealed class MembersDashboardState {}

final class MembersDashboardInitial extends MembersDashboardState {}

final class MembersDashboardLoadingState extends MembersDashboardState {}

final class MembersDashboardSuccessState extends MembersDashboardState {}

final class MembersDashboardErrorState extends MembersDashboardState {
  final String message;
  MembersDashboardErrorState({required this.message});
}
