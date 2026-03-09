part of 'council_cubit.dart';

@immutable
sealed class CouncilState {}

final class CouncilInitialState extends CouncilState {}

final class CouncilLoadingState extends CouncilState {}

final class CouncilErrorState extends CouncilState {
  final String message;
  CouncilErrorState({required this.message});
}

final class CouncilSuccessState extends CouncilState{}