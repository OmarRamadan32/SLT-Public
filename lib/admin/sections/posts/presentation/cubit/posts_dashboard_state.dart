part of 'posts_dashboard_cubit.dart';

@immutable
sealed class PostsDashboardState {}

final class PostsDashboardInitial extends PostsDashboardState {}

final class PostsDashboardLoadedState extends PostsDashboardState {
  PostsDashboardLoadedState();
}

final class SinglePostDashboardLoadedState extends PostsDashboardState {
  final PostModel post;
  SinglePostDashboardLoadedState({required this.post});
}
final class SinglePostDashboardUpdatedState extends PostsDashboardState {
}

final class PostsDashboardFailureState extends PostsDashboardState {
  final String errorMessage;
  PostsDashboardFailureState({required this.errorMessage});
}

final class PostsDashboardLoadingState extends PostsDashboardState {}

final class PostsDashboardLoadingMoreState extends PostsDashboardState {}

final class PostsDashboardNoMoreState extends PostsDashboardState {}

final class PostsDashboardSuccessState extends PostsDashboardState {}

