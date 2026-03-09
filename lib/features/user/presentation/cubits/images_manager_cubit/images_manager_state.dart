part of 'images_manager_cubit.dart';

@immutable
sealed class ImagesManagerState {}

final class ImagesManagerInitial extends ImagesManagerState {}

final class ImagesChoosedState extends ImagesManagerState {}
