part of 'schedule_cubit.dart';

@immutable
sealed class ScheduleState {}

final class ScheduleInitialState extends ScheduleState {}

final class ScheduleLoadingState extends ScheduleState {}

final class ScheduleSuccessState extends ScheduleState {}

final class ScheduleApproveAbsState extends ScheduleState {}
final class ScheduleDeclineAbsState extends ScheduleState {}

final class ScheduleAbsSuccessState extends ScheduleState {}
final class ScheduleAttsSuccessState extends ScheduleState {}


final class ScheduleErrorState extends ScheduleState {
  final String errMessage;
  ScheduleErrorState({required this.errMessage});
}
