part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {
}

final class UserSelectedState extends UserState {}
final class UserUpdatedState extends UserState {}
final class UserImagePicked extends UserState {}

final class UserSuccessState extends UserState {}

final class UserLoadedState extends UserState {
  final UserModel userModel;
  UserLoadedState({required this.userModel});
}

final class UserErrorState extends UserState {
  
  final String errorMessage;
  UserErrorState({required this.errorMessage});

}

final class UserLoadingState extends UserState {
}
