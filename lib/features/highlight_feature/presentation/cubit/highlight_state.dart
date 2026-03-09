part of 'highlight_cubit.dart';

@immutable
sealed class HighlightState {}

final class HighlightInitial extends HighlightState {}

final class HighlightLoaded extends HighlightState {
  final List<HighlightModel> models;
  HighlightLoaded({required this.models});
}

final class HighlightError extends HighlightState {
  final String errorMessage;
  HighlightError({required this.errorMessage});
}

final class HighlightLoading extends HighlightState {}
