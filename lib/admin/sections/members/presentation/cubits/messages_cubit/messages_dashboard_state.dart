part of 'messages_dashboard_cubit.dart';

@immutable
sealed class MessagesDashboardState {}

final class MessagesDashboardInitialState extends MessagesDashboardState {}

final class MessagesDashboardLoadingState extends MessagesDashboardState {}

final class MessagesDashboardSuccessState extends MessagesDashboardState {}

final class MessagesDashboardErrorState extends MessagesDashboardState {
  final String message;
  MessagesDashboardErrorState(this.message);
}
