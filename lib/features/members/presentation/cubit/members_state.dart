part of 'members_cubit.dart';

@immutable
sealed class MembersState {}

final class MembersInitial extends MembersState {}

final class MembersSuccessState extends MembersState {
  MembersSuccessState();
}

final class MembersErrorState extends MembersState {
  final String errorMessage;
  MembersErrorState({required this.errorMessage});
}

final class MembersLoadingState extends MembersState {}

final class MembersLoadingMoreState extends MembersState {}

final class MembersNoMoreState extends MembersState {}
