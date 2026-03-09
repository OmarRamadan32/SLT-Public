part of 'schedule_dashboard_cubit.dart';

@immutable
sealed class ScheduleDashboardState {}

final class ScheduleDashboardInitialState extends ScheduleDashboardState {}
final class ScheduleDashboardLoadingState extends ScheduleDashboardState {}
final class ScheduleDashboardSuccessState extends ScheduleDashboardState {}
final class ScheduleDashboardLoadedState extends ScheduleDashboardState {
  final List<ScheduleModel> schedules;
  ScheduleDashboardLoadedState({required this.schedules});
}
final class ScheduleDashboardErrorState extends ScheduleDashboardState {
  final String errMessage;
  ScheduleDashboardErrorState({required this.errMessage});

}
